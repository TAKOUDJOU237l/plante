<?php
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../../includes/auth_check.php';

requireAuth(['administrateur']);

$pdo = getPDO();

$stats = [
    'total_utilisateurs'               => (int) $pdo->query('SELECT COUNT(*) FROM UTILISATEUR')->fetchColumn(),
    'total_plantes'                     => (int) $pdo->query('SELECT COUNT(*) FROM PLANTE')->fetchColumn(),
    'total_maladies'                    => (int) $pdo->query('SELECT COUNT(*) FROM MALADIE')->fetchColumn(),
    'total_tradipraticiens_valides'     => (int) $pdo->query("SELECT COUNT(*) FROM TRADIPRATICIEN WHERE statut_validation = 'valide'")->fetchColumn(),
    'total_tradipraticiens_en_attente'  => (int) $pdo->query("SELECT COUNT(*) FROM TRADIPRATICIEN WHERE statut_validation = 'en_attente'")->fetchColumn(),
    'total_temoignages_approuves'       => (int) $pdo->query("SELECT COUNT(*) FROM TEMOIGNAGE WHERE statut_moderation = 'approuve'")->fetchColumn(),
    'total_temoignages_en_attente'      => (int) $pdo->query("SELECT COUNT(*) FROM TEMOIGNAGE WHERE statut_moderation = 'en_attente'")->fetchColumn(),
    'total_chercheurs'                  => (int) $pdo->query('SELECT COUNT(*) FROM CHERCHEUR')->fetchColumn(),
];

jsonResponse(['success' => true, 'stats' => $stats]);
