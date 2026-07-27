<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();

$statut    = $_GET['statut'] ?? 'valide'; // par défaut : n'affiche que les profils validés au public
$id_ethnie = $_GET['ethnie'] ?? null;
$id_region = $_GET['region'] ?? null;
$ville     = $_GET['ville'] ?? null;

$sql = "SELECT t.id_tradipraticien, u.nom, t.titre, t.telephone, t.adresse, t.ville,
               t.id_region, r.nom AS region_nom,
               t.id_ethnie, e.nom AS ethnie_nom,
               t.latitude, t.longitude, t.disponibilites, t.annees_experience,
               t.biographie, t.numero_accreditation, t.photo_url, t.statut_validation,
               GROUP_CONCAT(DISTINCT s.nom SEPARATOR ', ') AS specialites
        FROM TRADIPRATICIEN t
        JOIN UTILISATEUR u ON u.id_utilisateur = t.id_utilisateur
        LEFT JOIN REGION r ON r.id_region = t.id_region
        LEFT JOIN ETHNIE e ON e.id_ethnie = t.id_ethnie
        LEFT JOIN TRADIPRATICIEN_SPECIALITE ts ON ts.id_tradipraticien = t.id_tradipraticien
        LEFT JOIN SPECIALITE s ON s.id_specialite = ts.id_specialite
        WHERE 1=1";

$params = [];

if ($statut !== 'tous') {
    $sql .= " AND t.statut_validation = ?";
    $params[] = $statut;
}

if ($id_region) {
    $sql .= " AND t.id_region = ?";
    $params[] = $id_region;
}

if ($id_ethnie) {
    $sql .= " AND t.id_ethnie = ?";
    $params[] = $id_ethnie;
}

if ($ville) {
    $sql .= " AND t.ville LIKE ?";
    $params[] = '%' . $ville . '%';
}

$sql .= ' GROUP BY t.id_tradipraticien ORDER BY u.nom ASC';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);

jsonResponse(['success' => true, 'tradipraticiens' => $stmt->fetchAll()]);

