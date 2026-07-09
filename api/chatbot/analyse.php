<?php
/**
 * chatbot/analyse.php
 * Moteur de règles léger : associe les mots-clés du message utilisateur
 * aux noms/descriptions des MALADIE en base, puis retourne les plantes
 * (via REMEDE) qui traitent ces maladies. Conforme au choix technologique
 * "Moteur de règles + correspondance mot-clé / symptôme" du document de conception.
 */

require_once __DIR__ . '/../config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

$input = getJsonInput();
requireFields($input, ['symptomes']);

$texte = mb_strtolower(sanitize($input['symptomes']), 'UTF-8');

// Dictionnaire de synonymes simples pour améliorer la reconnaissance
// (à enrichir librement au fur et à mesure du projet)
$synonymes = [
    'mal de tete'   => 'fievre',
    'mal a la tete' => 'fievre',
    'fievre'        => 'fievre',
    'chaud'         => 'fievre',
    'ventre'        => 'ventre',
    'estomac'       => 'ventre',
    'diarrhee'      => 'ventre',
    'palu'          => 'paludisme',
    'paludisme'     => 'paludisme',
    'typhoide'      => 'typhoide',
];

// Normalise le texte (retire accents grossièrement pour la comparaison)
function normaliser(string $s): string {
    $s = strtr($s, ['é'=>'e','è'=>'e','ê'=>'e','à'=>'a','ô'=>'o','î'=>'i','ù'=>'u','ç'=>'c']);
    return $s;
}
$texteNormalise = normaliser($texte);

$pdo = getPDO();
$stmt = $pdo->query('SELECT id_maladie, nom, description FROM MALADIE');
$maladies = $stmt->fetchAll();

$idsMaladiesTrouvees = [];

foreach ($maladies as $maladie) {
    $nomNormalise = normaliser(mb_strtolower($maladie['nom'], 'UTF-8'));
    $descNormalisee = normaliser(mb_strtolower($maladie['description'] ?? '', 'UTF-8'));

    // Correspondance directe sur le nom de la maladie
    if (strpos($texteNormalise, $nomNormalise) !== false) {
        $idsMaladiesTrouvees[] = $maladie['id_maladie'];
        continue;
    }

    // Correspondance via le dictionnaire de synonymes
    foreach ($synonymes as $motCle => $maladieAssociee) {
        if (strpos($texteNormalise, normaliser($motCle)) !== false) {
            // Ex : "fievre" -> cherche les maladies dont le nom contient "paludisme" ou "typhoide"
            if (strpos($nomNormalise, normaliser($maladieAssociee)) !== false) {
                $idsMaladiesTrouvees[] = $maladie['id_maladie'];
            }
        }
    }
}

$idsMaladiesTrouvees = array_unique($idsMaladiesTrouvees);

$plantes = [];
if (!empty($idsMaladiesTrouvees)) {
    $placeholders = implode(',', array_fill(0, count($idsMaladiesTrouvees), '?'));
    $stmt = $pdo->prepare(
        "SELECT DISTINCT p.id_plante, p.nom_local, r.preparation, r.dosage
         FROM REMEDE r
         JOIN PLANTE p ON p.id_plante = r.id_plante
         WHERE r.id_maladie IN ($placeholders)"
    );
    $stmt->execute($idsMaladiesTrouvees);
    $plantes = $stmt->fetchAll();
}

jsonResponse([
    'success' => true,
    'maladies_detectees' => count($idsMaladiesTrouvees),
    'plantes' => $plantes,
]);
