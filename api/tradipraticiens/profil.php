<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

$utilisateur = requireAuth(['tradipraticien']);
$pdo = getPDO();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->prepare(
        'SELECT id_tradipraticien, titre, telephone, adresse, ville, id_region, id_ethnie,
                latitude, longitude, disponibilites, annees_experience, biographie,
                numero_accreditation, photo_url, statut_validation
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
         SET titre = ?, telephone = ?, adresse = ?, ville = ?, id_region = ?, id_ethnie = ?,
             latitude = ?, longitude = ?, disponibilites = ?, annees_experience = ?,
             biographie = ?, numero_accreditation = ?, photo_url = ?
         WHERE id_utilisateur = ?'
    );
    $stmt->execute([
        isset($input['titre']) ? sanitize($input['titre']) : 'Tradi-praticien',
        isset($input['telephone']) ? sanitize($input['telephone']) : null,
        isset($input['adresse']) ? sanitize($input['adresse']) : null,
        isset($input['ville']) ? sanitize($input['ville']) : null,
        !empty($input['id_region']) ? (int)$input['id_region'] : null,
        !empty($input['id_ethnie']) ? (int)$input['id_ethnie'] : null,
        $input['latitude'] ?? null,
        $input['longitude'] ?? null,
        isset($input['disponibilites']) ? sanitize($input['disponibilites']) : null,
        isset($input['annees_experience']) ? (int)$input['annees_experience'] : 0,
        isset($input['biographie']) ? sanitize($input['biographie']) : null,
        isset($input['numero_accreditation']) ? sanitize($input['numero_accreditation']) : null,
        isset($input['photo_url']) ? sanitize($input['photo_url']) : null,
        $utilisateur['id_utilisateur'],
    ]);

    jsonResponse(['success' => true, 'message' => 'Profil mis à jour.']);
}

jsonError('Méthode non autorisée.', 405);

