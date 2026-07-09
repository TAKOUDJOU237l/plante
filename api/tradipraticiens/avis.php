<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

$utilisateur = requireAuth(['tradipraticien']);
$pdo = getPDO();

// NB : dans le MCD actuel, les témoignages portent sur une PLANTE, pas directement
// sur un TRADIPRATICIEN. On récupère ici les témoignages liés aux plantes que ce
// tradipraticien maîtrise (relation possible via ses spécialités / plantes associées).
// Pour un MVP, on renvoie les témoignages généraux approuvés à titre d'exemple.

$stmt = $pdo->prepare(
    'SELECT t.id_temoignage, t.contenu, t.note, t.date_publication, u.nom AS auteur, p.nom_local AS plante
     FROM TEMOIGNAGE t
     JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
     JOIN PLANTE p ON p.id_plante = t.id_plante
     WHERE t.statut_moderation = "approuve"
     ORDER BY t.date_publication DESC
     LIMIT 20'
);
$stmt->execute();

jsonResponse(['success' => true, 'temoignages' => $stmt->fetchAll()]);
