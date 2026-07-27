<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();

$region_id = $_GET['region'] ?? null;

if ($region_id) {
    $stmt = $pdo->prepare(
        'SELECT e.id_ethnie, e.nom, r.nom AS region, e.id_region
         FROM ETHNIE e
         JOIN REGION r ON r.id_region = e.id_region
         WHERE e.id_region = ?
         ORDER BY e.nom ASC'
    );
    $stmt->execute([$region_id]);
} else {
    $stmt = $pdo->query(
        'SELECT e.id_ethnie, e.nom, r.nom AS region, e.id_region
         FROM ETHNIE e
         JOIN REGION r ON r.id_region = e.id_region
         ORDER BY e.nom ASC'
    );
}

jsonResponse(['success' => true, 'ethnies' => $stmt->fetchAll()]);

