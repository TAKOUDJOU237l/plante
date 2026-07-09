<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    jsonError('Méthode non autorisée.', 405);
}

$utilisateur = requireAuth(); // n'importe quel rôle connecté peut témoigner

$input = getJsonInput();
requireFields($input, ['id_plante', 'contenu', 'note']);

$note = (int) $input['note'];
if ($note < 1 || $note > 5) {
    jsonError('La note doit être comprise entre 1 et 5.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare(
    'INSERT INTO TEMOIGNAGE (contenu, note, statut_moderation, id_utilisateur, id_plante)
     VALUES (?, ?, "en_attente", ?, ?)'
);
$stmt->execute([
    sanitize($input['contenu']),
    $note,
    $utilisateur['id_utilisateur'],
    $input['id_plante'],
]);

jsonResponse([
    'success' => true,
    'message' => 'Témoignage soumis avec succès. Il sera visible après modération.',
    'id_temoignage' => (int) $pdo->lastInsertId(),
], 201);
