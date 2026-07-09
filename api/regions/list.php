<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();
$stmt = $pdo->query('SELECT id_region, nom FROM REGION ORDER BY nom ASC');

jsonResponse(['success' => true, 'regions' => $stmt->fetchAll()]);
