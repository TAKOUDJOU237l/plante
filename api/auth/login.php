<?php
require_once __DIR__ . '/../config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

$input = getJsonInput();
requireFields($input, ['email', 'mot_passe']);

$email = filter_var(trim($input['email']), FILTER_VALIDATE_EMAIL);
if (!$email) {
    jsonError('Adresse email invalide.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare('SELECT id_utilisateur, nom, mot_passe, role FROM UTILISATEUR WHERE email = ?');
$stmt->execute([$email]);
$utilisateur = $stmt->fetch();

if (!$utilisateur || !password_verify($input['mot_passe'], $utilisateur['mot_passe'])) {
    jsonError('Email ou mot de passe incorrect.', 401);
}

$_SESSION['id_utilisateur'] = $utilisateur['id_utilisateur'];
$_SESSION['nom']            = $utilisateur['nom'];
$_SESSION['role']           = $utilisateur['role'];

jsonResponse([
    'success' => true,
    'utilisateur' => [
        'id_utilisateur' => $utilisateur['id_utilisateur'],
        'nom'            => $utilisateur['nom'],
        'role'           => $utilisateur['role'],
    ],
]);
