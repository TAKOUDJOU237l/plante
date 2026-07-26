<?php
/**
 * plantes/ethnies.php
 * GET  ?id_plante=X   -> liste les usages ethniques renseignés pour une plante
 * POST { id_plante, id_ethnie, usage_traditionnel } -> ajoute une contribution
 *      (réservé aux tradipraticiens validés et aux administrateurs, pour
 *      garder une donnée collaborative mais crédible)
 */

require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $id_plante = $_GET['id_plante'] ?? null;
    if (!$id_plante) {
        jsonError('Identifiant de plante manquant.', 422);
    }

    $pdo = getPDO();
    $stmt = $pdo->prepare(
        'SELECT pe.id_ethnie, e.nom AS ethnie, r.nom AS region, pe.usage_traditionnel
         FROM PLANTE_ETHNIE pe
         JOIN ETHNIE e ON e.id_ethnie = pe.id_ethnie
         JOIN REGION r ON r.id_region = e.id_region
         WHERE pe.id_plante = ?
         ORDER BY e.nom ASC'
    );
    $stmt->execute([$id_plante]);

    jsonResponse(['success' => true, 'usages_ethniques' => $stmt->fetchAll()]);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Contribution réservée aux tradipraticiens validés et aux administrateurs :
    // on garde un savoir collaboratif, mais rattaché à des comptes identifiés.
    $utilisateur = requireAuth(['tradipraticien', 'administrateur']);

    $input = getJsonInput();
    requireFields($input, ['id_plante', 'id_ethnie', 'usage_traditionnel']);

    $pdo = getPDO();

    // Si un tradipraticien, on vérifie que son compte est bien validé
    if ($utilisateur['role'] === 'tradipraticien') {
        $stmt = $pdo->prepare('SELECT statut_validation FROM TRADIPRATICIEN WHERE id_utilisateur = ?');
        $stmt->execute([$utilisateur['id_utilisateur']]);
        $profil = $stmt->fetch();
        if (!$profil || $profil['statut_validation'] !== 'valide') {
            jsonError('Seuls les tradipraticiens validés peuvent contribuer à ce savoir.', 403);
        }
    }

    $texte = sanitize($input['usage_traditionnel']);

    $stmt = $pdo->prepare(
        'INSERT INTO PLANTE_ETHNIE (id_plante, id_ethnie, usage_traditionnel)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE usage_traditionnel = VALUES(usage_traditionnel)'
    );
    $stmt->execute([$input['id_plante'], $input['id_ethnie'], $texte]);

    jsonResponse(['success' => true, 'message' => 'Contribution enregistrée. Merci de partager ce savoir !'], 201);
}

jsonError('Méthode non autorisée.', 405);
