<?php
/**
 * Connexion centralisée à la base de données via PDO.
 * À adapter selon l'environnement (XAMPP local / hébergement cPanel).
 */

define('DB_HOST', 'localhost');
define('DB_NAME', 'pharmacopee_camerounaise');
define('DB_USER', 'root');
define('DB_PASS', '');       // sous XAMPP, mot de passe root vide par défaut
define('DB_CHARSET', 'utf8mb4');

function getPDO(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
        } catch (PDOException $e) {
            http_response_code(500);
            die(json_encode(['success' => false, 'message' => 'Erreur de connexion à la base de données.']));
        }
    }
    return $pdo;
}
