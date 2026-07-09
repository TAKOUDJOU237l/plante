<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

// Seul l'administrateur peut voir les témoignages non approuvés
$statut = $_GET['statut'] ?? 'approuve';
if ($statut !== 'approuve') {
    requireAuth(['administrateur']);
}

$pdo = getPDO();
$stmt = $pdo->prepare(
    'SELECT t.id_temoignage, t.contenu, t.note, t.statut_moderation, t.date_publication,
            u.nom AS auteur, p.nom_local AS plante, p.id_plante
     FROM TEMOIGNAGE t
     JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
     JOIN PLANTE p ON p.id_plante = t.id_plante
     WHERE t.statut_moderation = ?
     ORDER BY t.date_publication DESC'
);
$stmt->execute([$statut]);

jsonResponse(['success' => true, 'temoignages' => $stmt->fetchAll()]);
