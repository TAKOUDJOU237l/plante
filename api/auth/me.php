<?php
require_once __DIR__ . '/../config.php';

if (!isset($_SESSION['id_utilisateur'])) {
    jsonResponse(['success' => true, 'connecte' => false]);
}

jsonResponse([
    'success' => true,
    'connecte' => true,
    'utilisateur' => [
        'id_utilisateur' => $_SESSION['id_utilisateur'],
        'nom'            => $_SESSION['nom'],
        'role'           => $_SESSION['role'],
    ],
]);
