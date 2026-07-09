<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$input = getJsonInput();
requireFields($input, ['nom_local']);

$pdo = getPDO();
$stmt = $pdo->prepare(
    'INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
     VALUES (?, ?, ?, ?, ?)'
);
$stmt->execute([
    sanitize($input['nom_local']),
    isset($input['nom_scientifique']) ? sanitize($input['nom_scientifique']) : null,
    isset($input['famille_botanique']) ? sanitize($input['famille_botanique']) : null,
    isset($input['description']) ? sanitize($input['description']) : null,
    isset($input['image_url']) ? sanitize($input['image_url']) : null,
]);

jsonResponse(['success' => true, 'id_plante' => (int) $pdo->lastInsertId()], 201);
