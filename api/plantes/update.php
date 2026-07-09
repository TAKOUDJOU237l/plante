<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'PUT') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$input = getJsonInput();
requireFields($input, ['id_plante']);

$pdo = getPDO();
$champs = ['nom_local', 'nom_scientifique', 'famille_botanique', 'description', 'image_url'];
$sets = [];
$params = [];

foreach ($champs as $champ) {
    if (isset($input[$champ])) {
        $sets[] = "$champ = ?";
        $params[] = sanitize($input[$champ]);
    }
}

if (empty($sets)) {
    jsonError('Aucun champ à mettre à jour.', 422);
}

$params[] = $input['id_plante'];
$sql = 'UPDATE PLANTE SET ' . implode(', ', $sets) . ' WHERE id_plante = ?';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);

jsonResponse(['success' => true, 'message' => 'Plante mise à jour.']);
