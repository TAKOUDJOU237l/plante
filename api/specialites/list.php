<?php
require_once __DIR__ . '/../config.php';

$pdo = getPDO();
$stmt = $pdo->query('SELECT id_specialite, nom FROM SPECIALITE ORDER BY nom ASC');

jsonResponse(['success' => true, 'specialites' => $stmt->fetchAll()]);
