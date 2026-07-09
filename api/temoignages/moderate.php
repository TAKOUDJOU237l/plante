<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'PUT') {
    jsonError('Méthode non autorisée.', 405);
}

requireAuth(['administrateur']);

$input = getJsonInput();
requireFields($input, ['id_temoignage', 'statut_moderation']);

if (!in_array($input['statut_moderation'], ['approuve', 'rejete', 'en_attente'], true)) {
    jsonError('Statut de modération invalide.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare('UPDATE TEMOIGNAGE SET statut_moderation = ? WHERE id_temoignage = ?');
$stmt->execute([$input['statut_moderation'], $input['id_temoignage']]);

if ($stmt->rowCount() === 0) {
    jsonError('Témoignage introuvable.', 404);
}

jsonResponse(['success' => true, 'message' => 'Témoignage modéré avec succès.']);
