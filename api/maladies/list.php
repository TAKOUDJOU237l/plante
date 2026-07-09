<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();
$stmt = $pdo->query('SELECT id_maladie, nom, description FROM MALADIE ORDER BY nom ASC');

jsonResponse(['success' => true, 'maladies' => $stmt->fetchAll()]);
