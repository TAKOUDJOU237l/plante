<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'DELETE') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$id = $_GET['id'] ?? null;
if (!$id) {
    jsonError('Identifiant de plante manquant.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare('DELETE FROM PLANTE WHERE id_plante = ?');
$stmt->execute([$id]);

if ($stmt->rowCount() === 0) {
    jsonError('Plante introuvable.', 404);
}

jsonResponse(['success' => true, 'message' => 'Plante supprimée.']);
