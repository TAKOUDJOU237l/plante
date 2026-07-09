<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();

$mot_cle   = $_GET['q'] ?? null;
$id_ethnie = $_GET['ethnie'] ?? null;
$id_region = $_GET['region'] ?? null;
$id_maladie = $_GET['maladie'] ?? null;

$sql = 'SELECT DISTINCT p.id_plante, p.nom_local, p.nom_scientifique, p.famille_botanique,
               p.description, p.image_url
        FROM PLANTE p
        LEFT JOIN PLANTE_ETHNIE pe ON pe.id_plante = p.id_plante
        LEFT JOIN ETHNIE e ON e.id_ethnie = pe.id_ethnie
        LEFT JOIN REMEDE r ON r.id_plante = p.id_plante
        WHERE 1=1';
$params = [];

if ($mot_cle) {
    $sql .= ' AND (p.nom_local LIKE ? OR p.nom_scientifique LIKE ? OR p.famille_botanique LIKE ?)';
    $like = '%' . $mot_cle . '%';
    array_push($params, $like, $like, $like);
}
if ($id_ethnie) {
    $sql .= ' AND pe.id_ethnie = ?';
    $params[] = $id_ethnie;
}
if ($id_region) {
    $sql .= ' AND e.id_region = ?';
    $params[] = $id_region;
}
if ($id_maladie) {
    $sql .= ' AND r.id_maladie = ?';
    $params[] = $id_maladie;
}

$sql .= ' ORDER BY p.nom_local ASC';

$stmt = $pdo->prepare($sql);
$stmt->execute($params);

jsonResponse(['success' => true, 'plantes' => $stmt->fetchAll()]);
