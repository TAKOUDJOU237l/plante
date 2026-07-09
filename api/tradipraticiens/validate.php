<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'PUT') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$input = getJsonInput();
requireFields($input, ['id_tradipraticien', 'statut_validation']);

if (!in_array($input['statut_validation'], ['valide', 'refuse', 'en_attente'], true)) {
    jsonError('Statut de validation invalide.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare('UPDATE TRADIPRATICIEN SET statut_validation = ? WHERE id_tradipraticien = ?');
$stmt->execute([$input['statut_validation'], $input['id_tradipraticien']]);

if ($stmt->rowCount() === 0) {
    jsonError('Tradipraticien introuvable.', 404);
}

jsonResponse(['success' => true, 'message' => 'Statut de validation mis à jour.']);
