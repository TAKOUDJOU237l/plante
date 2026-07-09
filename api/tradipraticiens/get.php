<?php
require_once __DIR__ . '/../config.php';

$id = $_GET['id'] ?? null;
if (!$id) {
    jsonError('Identifiant manquant.', 422);
}

$pdo = getPDO();
$stmt = $pdo->prepare(
    "SELECT t.id_tradipraticien, u.nom, u.email, t.latitude, t.longitude,
            t.disponibilites, t.statut_validation,
            GROUP_CONCAT(DISTINCT s.nom SEPARATOR ', ') AS specialites
     FROM TRADIPRATICIEN t
     JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
     LEFT JOIN TRADIPRATICIEN_SPECIALITE ts ON ts.id_tradipraticien = t.id_tradipraticien
     LEFT JOIN SPECIALITE s ON s.id_specialite = ts.id_specialite
     WHERE t.id_tradipraticien = ?
     GROUP BY t.id_tradipraticien"
);
$stmt->execute([$id]);
$tradipraticien = $stmt->fetch();

if (!$tradipraticien) {
    jsonError('Tradipraticien introuvable.', 404);
}

jsonResponse(['success' => true, 'tradipraticien' => $tradipraticien]);
