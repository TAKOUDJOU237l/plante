<?php
require_once __DIR__ . '/../config.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

$input = getJsonInput();
requireFields($input, ['nom', 'email', 'mot_passe', 'role']);

$nom       = sanitize($input['nom']);
$email     = filter_var(trim($input['email']), FILTER_VALIDATE_EMAIL);
$motPasse  = $input['mot_passe'];
$role      = $input['role']; // patient | tradipraticien | chercheur

if (!$email) {
    jsonError('Adresse email invalide.', 422);
}
if (!in_array($role, ['patient', 'tradipraticien', 'chercheur'], true)) {
    jsonError('Rôle invalide.', 422);
}
if (strlen($motPasse) < 6) {
    jsonError('Le mot de passe doit contenir au moins 6 caractères.', 422);
}

$pdo = getPDO();

$stmt = $pdo->prepare('SELECT id_utilisateur FROM UTILISATEUR WHERE email = ?');
$stmt->execute([$email]);
if ($stmt->fetch()) {
    jsonError('Un compte existe déjà avec cet email.', 409);
}

$pdo->beginTransaction();
try {
    $hash = password_hash($motPasse, PASSWORD_DEFAULT);
    $stmt = $pdo->prepare(
        'INSERT INTO UTILISATEUR (nom, email, mot_passe, role) VALUES (?, ?, ?, ?)'
    );
    $stmt->execute([$nom, $email, $hash, $role]);
    $idUtilisateur = (int) $pdo->lastInsertId();

    // Création du profil spécialisé selon le rôle
    if ($role === 'tradipraticien') {
        $stmt = $pdo->prepare(
            'INSERT INTO TRADIPRATICIEN (id_utilisateur, statut_validation) VALUES (?, ?)'
        );
        $stmt->execute([$idUtilisateur, 'en_attente']);
    } elseif ($role === 'chercheur') {
        $institution = isset($input['institution']) ? sanitize($input['institution']) : null;
        $stmt = $pdo->prepare(
            'INSERT INTO CHERCHEUR (id_utilisateur, institution) VALUES (?, ?)'
        );
        $stmt->execute([$idUtilisateur, $institution]);
    }

    $pdo->commit();
} catch (Exception $e) {
    $pdo->rollBack();
    jsonError('Erreur lors de la création du compte.', 500);
}

jsonResponse([
    'success' => true,
    'message' => 'Compte créé avec succès.' . ($role === 'tradipraticien' ? ' Votre profil sera visible après validation par un administrateur.' : ''),
    'id_utilisateur' => $idUtilisateur,
], 201);
