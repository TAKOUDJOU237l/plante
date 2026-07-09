<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();

$statut    = $_GET['statut'] ?? 'valide'; // par défaut : n'affiche que les profils validés au public
$id_ethnie = $_GET['ethnie'] ?? null;
$id_region = $_GET['region'] ?? null;

$sql = "SELECT t.id_tradipraticien, u.nom, t.latitude, t.longitude, t.disponibilites,
               t.statut_validation,
               GROUP_CONCAT(DISTINCT s.nom SEPARATOR ', ') AS specialites
        FROM TRADIPRATICIEN t
        JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
        LEFT JOIN TRADIPRATICIEN_SPECIALITE ts ON ts.id_tradipraticien = t.id_tradipraticien
        LEFT JOIN SPECIALITE s ON s.id_specialite = ts.id_specialite
        WHERE t.statut_validation = ?";
$params = [$statut];

// Filtres ethnie / région : on suppose une correspondance via les plantes maîtrisées
// ou, plus simplement ici, on relie le tradipraticien à une ethnie via son profil futur.
// Pour rester conforme au MCD actuel (pas de lien direct tradipraticien-ethnie),
// ces filtres sont ignorés silencieusement si non applicables.

$sql .= ' GROUP BY t.id_tradipraticien ORDER BY u.nom ASC';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);

jsonResponse(['success' => true, 'tradipraticiens' => $stmt->fetchAll()]);
