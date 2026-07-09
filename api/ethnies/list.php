<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();
$stmt = $pdo->query(
    'SELECT e.id_ethnie, e.nom, r.nom AS region
     FROM ETHNIE e
     JOIN REGION r ON r.id_region = e.id_region
     ORDER BY e.nom ASC'
);

jsonResponse(['success' => true, 'ethnies' => $stmt->fetchAll()]);
