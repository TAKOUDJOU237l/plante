<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

$utilisateur = requireAuth(['tradipraticien']);
$pdo = getPDO();

$stmt = $pdo->prepare('SELECT id_tradipraticien FROM TRADIPRATICIEN WHERE id_utilisateur = ?');
$stmt->execute([$utilisateur['id_utilisateur']]);
$profil = $stmt->fetch();
if (!$profil) {
    jsonError('Profil tradipraticien introuvable.', 404);
}
$idTradipraticien = $profil['id_tradipraticien'];

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $stmt = $pdo->prepare(
        'SELECT s.id_specialite, s.nom FROM TRADIPRATICIEN_SPECIALITE ts
         JOIN SPECIALITE s ON s.id_specialite = ts.id_specialite
         WHERE ts.id_tradipraticien = ?'
    );
    $stmt->execute([$idTradipraticien]);
    jsonResponse(['success' => true, 'specialites' => $stmt->fetchAll()]);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = getJsonInput();
    requireFields($input, ['id_specialite']);

    $stmt = $pdo->prepare(
        'INSERT IGNORE INTO TRADIPRATICIEN_SPECIALITE (id_tradipraticien, id_specialite) VALUES (?, ?)'
    );
    $stmt->execute([$idTradipraticien, $input['id_specialite']]);

    jsonResponse(['success' => true, 'message' => 'Spécialité ajoutée.'], 201);
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $id_specialite = $_GET['id_specialite'] ?? null;
    if (!$id_specialite) {
        jsonError('Identifiant de spécialité manquant.', 422);
    }
    $stmt = $pdo->prepare(
        'DELETE FROM TRADIPRATICIEN_SPECIALITE WHERE id_tradipraticien = ? AND id_specialite = ?'
    );
    $stmt->execute([$idTradipraticien, $id_specialite]);

    jsonResponse(['success' => true, 'message' => 'Spécialité retirée.']);
}

jsonError('Méthode non autorisée.', 405);
