<?php
/**
 * chatbot/analyse.php
 * Mode hybride:
 * 1) détection maladies/plantes par règles + sémantique Groq
 * 2) génération de réponse naturelle via Groq (si GROQ_API_KEY est défini)
 */

require_once __DIR__ . '/../config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

function normaliser(string $s): string
{
    $s = mb_strtolower($s, 'UTF-8');
    $s = strtr($s, ['é' => 'e', 'è' => 'e', 'ê' => 'e', 'à' => 'a', 'ô' => 'o', 'î' => 'i', 'ù' => 'u', 'ç' => 'c']);
    $s = preg_replace('/[^a-z0-9]+/u', ' ', $s);
    $s = preg_replace('/\s+/u', ' ', (string) $s);
    return trim((string) $s);
}

function getGroqApiKey(): string
{
    $key = getenv('GROQ_API_KEY');
    if (is_string($key) && trim($key) !== '') {
        return trim($key);
    }
    if (isset($_ENV['GROQ_API_KEY']) && trim((string) $_ENV['GROQ_API_KEY']) !== '') {
        return trim((string) $_ENV['GROQ_API_KEY']);
    }
    if (isset($_SERVER['GROQ_API_KEY']) && trim((string) $_SERVER['GROQ_API_KEY']) !== '') {
        return trim((string) $_SERVER['GROQ_API_KEY']);
    }
    return '';
}

function construireContextePlantes(array $plantes): string
{
    if (empty($plantes)) {
        return 'Aucune plante pertinente trouvée dans la base locale.';
    }

    $lignes = [];
    foreach ($plantes as $p) {
        $nom = $p['nom_local'] ?? 'Plante';
        $preparation = trim((string) ($p['preparation'] ?? ''));
        $dosage = trim((string) ($p['dosage'] ?? ''));
        $bloc = "- {$nom}";
        if ($preparation !== '') {
            $bloc .= "; préparation: {$preparation}";
        }
        if ($dosage !== '') {
            $bloc .= "; dosage: {$dosage}";
        }
        $lignes[] = $bloc;
    }

    return implode("\n", $lignes);
}

function appelerGroqChat(string $apiKey, string $systemPrompt, string $userPrompt, float $temperature = 0.3): ?string
{
    if (!function_exists('curl_init')) {
        return null;
    }

    $model = getenv('GROQ_MODEL');
    $model = (is_string($model) && trim($model) !== '') ? trim($model) : 'llama-3.1-8b-instant';

    $payload = [
        'model' => $model,
        'temperature' => $temperature,
        'messages' => [
            ['role' => 'system', 'content' => $systemPrompt],
            ['role' => 'user', 'content' => $userPrompt],
        ],
    ];

    $ch = curl_init('https://api.groq.com/openai/v1/chat/completions');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 20);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $apiKey,
    ]);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload, JSON_UNESCAPED_UNICODE));

    $raw = curl_exec($ch);
    if ($raw === false) {
        curl_close($ch);
        return null;
    }

    $httpCode = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode < 200 || $httpCode >= 300) {
        return null;
    }

    $data = json_decode($raw, true);
    if (!is_array($data)) {
        return null;
    }

    $content = $data['choices'][0]['message']['content'] ?? null;
    if (!is_string($content) || trim($content) === '') {
        return null;
    }

    return trim($content);
}

function extraireJsonObjet(string $texte): ?array
{
    $direct = json_decode($texte, true);
    if (is_array($direct)) {
        return $direct;
    }

    if (preg_match('/\{.*\}/s', $texte, $match) === 1) {
        $decoded = json_decode($match[0], true);
        if (is_array($decoded)) {
            return $decoded;
        }
    }

    return null;
}

function detecterMaladiesAvecGroq(string $apiKey, string $texteUtilisateur, array $maladies): array
{
    if (empty($maladies)) {
        return [];
    }

    $lignesMaladies = [];
    foreach ($maladies as $m) {
        $id = (int) $m['id_maladie'];
        $nom = (string) $m['nom'];
        $description = trim((string) ($m['description'] ?? ''));
        $lignesMaladies[] = "{$id} | {$nom} | {$description}";
    }

    $systemPrompt = "Tu es un classifieur sémantique médical non-diagnostique. "
        . "Ta tâche: mapper la phrase utilisateur vers une ou plusieurs maladies de la liste fournie, "
        . "en reconnaissant paraphrases, formulations indirectes et fautes légères. "
        . "Ne retourne que du JSON valide, sans texte autour.";

    $userPrompt = "Texte utilisateur: {$texteUtilisateur}\n\n"
        . "Liste de maladies (id | nom | description):\n" . implode("\n", $lignesMaladies) . "\n\n"
        . "Retourne exactement ce format JSON:\n"
        . "{\"ids\":[<id1>,<id2>],\"raisonnement_court\":\"...\"}\n"
        . "Règles: n'invente aucun id, ids uniques, max 3 ids, [] si aucune correspondance.";

    $raw = appelerGroqChat($apiKey, $systemPrompt, $userPrompt, 0.1);
    if (!is_string($raw) || $raw === '') {
        return [];
    }

    $json = extraireJsonObjet($raw);
    if (!is_array($json) || !isset($json['ids']) || !is_array($json['ids'])) {
        return [];
    }

    $idsAutorises = [];
    foreach ($maladies as $m) {
        $idsAutorises[(int) $m['id_maladie']] = true;
    }

    $ids = [];
    foreach ($json['ids'] as $id) {
        $idInt = (int) $id;
        if ($idInt > 0 && isset($idsAutorises[$idInt])) {
            $ids[] = $idInt;
        }
    }

    return array_values(array_unique($ids));
}

function extraireSymptomesAvecGroq(string $apiKey, string $texteUtilisateur): array
{
    $symptomesAutorises = [
        'mal de tete',
        'fievre',
        'douleur abdominale',
        'diarrhee',
        'vomissements',
        'fatigue',
        'courbatures',
        'frissons',
    ];

    $systemPrompt = "Tu normalises des symptômes en français. "
        . "Tu dois comprendre les paraphrases et fautes légères. "
        . "Retourne strictement un JSON valide, sans texte autour.";

    $userPrompt = "Texte utilisateur: {$texteUtilisateur}\n"
        . "Liste autorisée des symptômes canoniques: " . implode(', ', $symptomesAutorises) . "\n"
        . "Retour attendu: {\"symptomes\":[\"...\"]}\n"
        . "Règles: uniquement des éléments de la liste autorisée, sans doublon, max 5.";

    $raw = appelerGroqChat($apiKey, $systemPrompt, $userPrompt, 0.0);
    if (!is_string($raw) || $raw === '') {
        return [];
    }

    $json = extraireJsonObjet($raw);
    if (!is_array($json) || !isset($json['symptomes']) || !is_array($json['symptomes'])) {
        return [];
    }

    $autorisesNormalises = [];
    foreach ($symptomesAutorises as $s) {
        $autorisesNormalises[normaliser($s)] = $s;
    }

    $res = [];
    foreach ($json['symptomes'] as $s) {
        $sn = normaliser((string) $s);
        if ($sn !== '' && isset($autorisesNormalises[$sn])) {
            $res[] = $autorisesNormalises[$sn];
        }
    }

    return array_values(array_unique($res));
}

function extraireSymptomesParRegex(string $texteNormalise): array
{
    $patterns = [
        '/\b(tete)\b.*\b(mal|douleur|migraine|cephalee)\b|\b(mal|douleur|migraine|cephalee)\b.*\b(tete)\b/u' => 'mal de tete',
        '/\b(fievre|temperature|frisson|chaud)\b/u' => 'fievre',
        '/\b(ventre|estomac|abdomen|abdominal)\b.*\b(mal|douleur|crampe)\b|\b(mal|douleur|crampe)\b.*\b(ventre|estomac|abdomen|abdominal)\b/u' => 'douleur abdominale',
        '/\bdiarrhee\b/u' => 'diarrhee',
        '/\b(vomissement|vomissements|vomir)\b/u' => 'vomissements',
        '/\b(fatigue|faiblesse)\b/u' => 'fatigue',
        '/\b(courbature|courbatures)\b/u' => 'courbatures',
        '/\b(frisson|frissons)\b/u' => 'frissons',
    ];

    $trouves = [];
    foreach ($patterns as $regex => $canonique) {
        if (preg_match($regex, $texteNormalise) === 1) {
            $trouves[] = $canonique;
        }
    }

    return array_values(array_unique($trouves));
}

function construireLexiqueSymptomesMaladie(array $synonymes): array
{
    $lexique = [];
    foreach ($synonymes as $motCle => $maladieAssociee) {
        $maladieCle = normaliser($maladieAssociee);
        if ($maladieCle === '') {
            continue;
        }
        if (!isset($lexique[$maladieCle])) {
            $lexique[$maladieCle] = [];
        }
        $lexique[$maladieCle][] = normaliser($motCle);
    }
    return $lexique;
}

function genererReponseGroq(string $apiKey, string $texteUtilisateur, array $maladiesTrouvees, array $plantes): ?string
{
    $contexteMaladies = empty($maladiesTrouvees)
        ? 'Aucune maladie détectée avec certitude.'
        : implode(', ', array_map(static function ($m) {
            return (string) $m['nom'];
        }, $maladiesTrouvees));

    $promptSysteme = "Tu es l'assistant de pharmacopée camerounaise. "
        . "Réponds en français simple, 3 à 6 phrases maximum. "
        . "Tu dois t'appuyer uniquement sur les données fournies. "
        . "Ne pose pas de diagnostic médical. "
        . "Ajoute une phrase de prudence invitant à consulter un professionnel de santé en cas de symptômes graves ou persistants.";

    $promptUtilisateur = "Message utilisateur: {$texteUtilisateur}\n"
        . "Maladies détectées: {$contexteMaladies}\n"
        . "Plantes suggérées:\n" . construireContextePlantes($plantes);

    return appelerGroqChat($apiKey, $promptSysteme, $promptUtilisateur, 0.3);
}

function detecterMaladiesParRegles(string $texteNormalise, array $maladies, array $synonymes, array $symptomesDetectes): array
{
    $idsMaladiesTrouvees = [];
    $lexiqueParMaladie = construireLexiqueSymptomesMaladie($synonymes);
    $symptomesNormalises = array_map('normaliser', $symptomesDetectes);

    foreach ($maladies as $maladie) {
        $nomNormalise = normaliser((string) $maladie['nom']);
        $descriptionNormalisee = normaliser((string) ($maladie['description'] ?? ''));
        $nomMaladieCle = $nomNormalise;

        if ($nomNormalise !== '' && strpos($texteNormalise, $nomNormalise) !== false) {
            $idsMaladiesTrouvees[] = (int) $maladie['id_maladie'];
            continue;
        }

        $scoreSymptomes = 0;
        if (isset($lexiqueParMaladie[$nomMaladieCle])) {
            foreach ($symptomesNormalises as $symptome) {
                if ($symptome === '') {
                    continue;
                }
                foreach ($lexiqueParMaladie[$nomMaladieCle] as $indiceMaladie) {
                    if ($indiceMaladie !== '' && strpos($indiceMaladie, $symptome) !== false) {
                        $scoreSymptomes++;
                        break;
                    }
                }
            }
        }
        if ($scoreSymptomes > 0) {
            $idsMaladiesTrouvees[] = (int) $maladie['id_maladie'];
            continue;
        }

        foreach ($synonymes as $motCle => $maladieAssociee) {
            $motCleNormalise = normaliser($motCle);
            $cibleNormalisee = normaliser($maladieAssociee);
            if ($motCleNormalise === '' || $cibleNormalisee === '') {
                continue;
            }

            if (
                strpos($texteNormalise, $motCleNormalise) !== false
                && (
                    strpos($nomNormalise, $cibleNormalisee) !== false
                    || strpos($descriptionNormalisee, $cibleNormalisee) !== false
                )
            ) {
                $idsMaladiesTrouvees[] = (int) $maladie['id_maladie'];
            }
        }
    }

    return array_values(array_unique($idsMaladiesTrouvees));
}

$input = getJsonInput();
requireFields($input, ['symptomes']);

$texteSource = (string) $input['symptomes'];
$texteUtilisateur = trim($texteSource);
$texteNormalise = normaliser($texteUtilisateur);

$synonymes = [
    'ma tete fait mal' => 'fievre',
    'j ai mal a la tete' => 'fievre',
    'j ai la tete qui fait mal' => 'fievre',
    'maux de tete' => 'fievre',
    'mal de tete' => 'fievre',
    'mal a la tete' => 'fievre',
    'fievre' => 'fievre',
    'chaud' => 'fievre',
    'ventre' => 'ventre',
    'estomac' => 'ventre',
    'diarrhee' => 'ventre',
    'palu' => 'paludisme',
    'paludisme' => 'paludisme',
    'typhoide' => 'typhoide',
];

$pdo = getPDO();
$stmt = $pdo->query('SELECT id_maladie, nom, description FROM MALADIE');
$maladies = $stmt->fetchAll();

$idsMaladiesRegles = [];
$idsMaladiesSemantiques = [];
$llmSemantiqueUtilise = false;
$llmExtractionSymptomesUtilise = false;
$symptomesRegex = extraireSymptomesParRegex($texteNormalise);
$symptomesLLM = [];

$maladiesTrouvees = [];
$groqApiKey = getGroqApiKey();
if ($groqApiKey !== '') {
    $symptomesLLM = extraireSymptomesAvecGroq($groqApiKey, $texteUtilisateur);
    $llmExtractionSymptomesUtilise = !empty($symptomesLLM);
    $idsMaladiesSemantiques = detecterMaladiesAvecGroq($groqApiKey, $texteUtilisateur, $maladies);
    $llmSemantiqueUtilise = !empty($idsMaladiesSemantiques);
}

$symptomesDetectes = array_values(array_unique(array_merge($symptomesRegex, $symptomesLLM)));
$texteNormaliseEnrichi = trim($texteNormalise . ' ' . implode(' ', array_map('normaliser', $symptomesDetectes)));
$idsMaladiesRegles = detecterMaladiesParRegles($texteNormaliseEnrichi, $maladies, $synonymes, $symptomesDetectes);

$idsMaladiesTrouvees = array_values(array_unique(array_merge($idsMaladiesRegles, $idsMaladiesSemantiques)));

if (!empty($idsMaladiesTrouvees)) {
    $placeholdersMaladies = implode(',', array_fill(0, count($idsMaladiesTrouvees), '?'));
    $stmt = $pdo->prepare("SELECT id_maladie, nom FROM MALADIE WHERE id_maladie IN ($placeholdersMaladies)");
    $stmt->execute($idsMaladiesTrouvees);
    $maladiesTrouvees = $stmt->fetchAll();
}

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

$reponseDefaut = !empty($plantes)
    ? "J'ai trouvé des plantes traditionnellement utilisées pour vos symptômes. Vérifiez les suggestions ci-dessous et consultez un professionnel de santé si les symptômes persistent."
    : "Je n'ai pas trouvé de correspondance fiable dans la base locale. Essayez de reformuler vos symptômes ou consultez un tradipraticien/médecin.";

$llmUtilise = false;
$reponse = $reponseDefaut;

if ($groqApiKey !== '') {
    $reponseGroq = genererReponseGroq($groqApiKey, $texteUtilisateur, $maladiesTrouvees, $plantes);
    if (is_string($reponseGroq) && $reponseGroq !== '') {
        $reponse = $reponseGroq;
        $llmUtilise = true;
    }
}

jsonResponse([
    'success' => true,
    'maladies_detectees' => count($idsMaladiesTrouvees),
    'maladies_ids' => $idsMaladiesTrouvees,
    'plantes' => $plantes,
    'reponse' => $reponse,
    'llm_utilise' => $llmUtilise,
    'llm_semantique_utilise' => $llmSemantiqueUtilise,
    'llm_extraction_symptomes_utilise' => $llmExtractionSymptomesUtilise,
    'symptomes_detectes' => $symptomesDetectes,
]);
