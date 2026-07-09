<?php
/**
 * Configuration commune à tous les endpoints de l'API REST.
 * Inclure ce fichier en tête de chaque script api/*.php
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// CORS - à restreindre au domaine réel en production
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/functions.php';
