<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$input = getJsonInput();
requireFields($input, ['nom']);

$pdo = getPDO();
$stmt = $pdo->prepare('INSERT INTO MALADIE (nom, description) VALUES (?, ?)');
$stmt->execute([
    sanitize($input['nom']),
    isset($input['description']) ? sanitize($input['description']) : null,
]);

jsonResponse(['success' => true, 'id_maladie' => (int) $pdo->lastInsertId()], 201);
