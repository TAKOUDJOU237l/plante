<?php
require_once __DIR__ . '/../config.php';

$id = $_GET['id'] ?? null;
if (!$id) {
    jsonError('Identifiant de plante manquant.', 422);
}

$pdo = getPDO();

$stmt = $pdo->prepare('SELECT * FROM PLANTE WHERE id_plante = ?');
$stmt->execute([$id]);
$plante = $stmt->fetch();

if (!$plante) {
    jsonError('Plante introuvable.', 404);
}

// Remèdes associés (jointure avec MALADIE pour le nom lisible)
$stmt = $pdo->prepare(
    'SELECT r.id_remede, r.preparation, r.dosage, r.precautions, m.nom AS nom_maladie
     FROM REMEDE r
     JOIN MALADIE m ON m.id_maladie = r.id_maladie
     WHERE r.id_plante = ?'
);
$stmt->execute([$id]);
$remedes = $stmt->fetchAll();

// Témoignages approuvés uniquement (les autres sont réservés à la modération admin)
$stmt = $pdo->prepare(
    'SELECT t.id_temoignage, t.contenu, t.note, t.date_publication, u.nom AS auteur
     FROM TEMOIGNAGE t
     JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
     WHERE t.id_plante = ? AND t.statut_moderation = "approuve"
     ORDER BY t.date_publication DESC'
);
$stmt->execute([$id]);
$temoignages = $stmt->fetchAll();

// Usages traditionnels par ethnie
$stmt = $pdo->prepare(
    'SELECT e.nom AS ethnie, pe.usage_traditionnel
     FROM PLANTE_ETHNIE pe
     JOIN ETHNIE e ON e.id_ethnie = pe.id_ethnie
     WHERE pe.id_plante = ?'
);
$stmt->execute([$id]);
$usages = $stmt->fetchAll();

jsonResponse([
    'success' => true,
    'plante' => $plante,
    'remedes' => $remedes,
    'temoignages' => $temoignages,
    'usages_ethniques' => $usages,
]);
