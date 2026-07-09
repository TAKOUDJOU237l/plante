<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

$utilisateur = requireAuth(['tradipraticien']);
$pdo = getPDO();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->prepare(
        'SELECT id_tradipraticien, latitude, longitude, disponibilites, statut_validation
         FROM TRADIPRATICIEN WHERE id_utilisateur = ?'
    );
    $stmt->execute([$utilisateur['id_utilisateur']]);
    $profil = $stmt->fetch();

    if (!$profil) {
        jsonError('Profil tradipraticien introuvable.', 404);
    }

    jsonResponse(['success' => true, 'profil' => $profil]);
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    $input = getJsonInput();

    $stmt = $pdo->prepare(
        'UPDATE TRADIPRATICIEN
         SET latitude = ?, longitude = ?, disponibilites = ?
         WHERE id_utilisateur = ?'
    );
    $stmt->execute([
        $input['latitude'] ?? null,
        $input['longitude'] ?? null,
        isset($input['disponibilites']) ? sanitize($input['disponibilites']) : null,
        $utilisateur['id_utilisateur'],
    ]);

    jsonResponse(['success' => true, 'message' => 'Profil mis à jour.']);
}

jsonError('Méthode non autorisée.', 405);
