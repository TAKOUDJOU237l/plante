<?php
/**
 * Vérifie qu'un utilisateur est authentifié (session PHP) et,
 * optionnellement, qu'il possède l'un des rôles autorisés.
 *
 * Usage :
 *   require_once __DIR__ . '/../includes/auth_check.php';
 *   $utilisateur = requireAuth();                       // n'importe quel utilisateur connecté
 *   $utilisateur = requireAuth(['administrateur']);      // uniquement admin
 */

require_once __DIR__ . '/functions.php';

function requireAuth(array $rolesAutorises = []): array {
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    if (!isset($_SESSION['id_utilisateur'])) {
        jsonError('Authentification requise. Veuillez vous connecter.', 401);
    }

    if (!empty($rolesAutorises) && !in_array($_SESSION['role'], $rolesAutorises, true)) {
        jsonError('Accès refusé : rôle insuffisant pour cette action.', 403);
    }

    return [
        'id_utilisateur' => $_SESSION['id_utilisateur'],
        'nom'            => $_SESSION['nom'],
        'role'           => $_SESSION['role'],
    ];
}
