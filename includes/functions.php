<?php
/**
 * Fonctions utilitaires communes à tous les endpoints de l'API.
 */

function jsonResponse($data, int $statusCode = 200): void {
    http_response_code($statusCode);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

function jsonError(string $message, int $statusCode = 400): void {
    jsonResponse(['success' => false, 'message' => $message], $statusCode);
}

function getJsonInput(): array {
    $raw = file_get_contents('php://input');
    $data = json_decode($raw, true);
    return is_array($data) ? $data : [];
}

function sanitize(string $value): string {
    return htmlspecialchars(trim($value), ENT_QUOTES, 'UTF-8');
}

function requireFields(array $input, array $fields): void {
    $missing = [];
    foreach ($fields as $f) {
        if (!isset($input[$f]) || $input[$f] === '') {
            $missing[] = $f;
        }
    }
    if (!empty($missing)) {
        jsonError('Champs obligatoires manquants : ' . implode(', ', $missing), 422);
    }
}
