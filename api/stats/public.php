<?php
/**
 * stats/public.php
 * Statistiques agrégées, SANS authentification requise : aucune donnée
 * personnelle, juste des compteurs pour la page d'accueil.
 */

require_once __DIR__ . '/../config.php';

$pdo = getPDO();

$stats = [
    'total_plantes'          => (int) $pdo->query('SELECT COUNT(*) FROM PLANTE')->fetchColumn(),
    'total_tradipraticiens'  => (int) $pdo->query("SELECT COUNT(*) FROM TRADIPRATICIEN WHERE statut_validation = 'valide'")->fetchColumn(),
    'total_ethnies'          => (int) $pdo->query('SELECT COUNT(*) FROM ETHNIE')->fetchColumn(),
    'total_remedes'          => (int) $pdo->query('SELECT COUNT(*) FROM REMEDE')->fetchColumn(),
];

jsonResponse(['success' => true, 'stats' => $stats]);