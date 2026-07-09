<?php
require_once __DIR__ . '/../../includes/db.php';
require_once __DIR__ . '/../../includes/functions.php';
require_once __DIR__ . '/../../includes/auth_check.php';

// Export réservé aux chercheurs et administrateurs
requireAuth(['chercheur', 'administrateur']);

$pdo = getPDO();
$stmt = $pdo->query(
    'SELECT p.nom_local, p.nom_scientifique, p.famille_botanique,
            m.nom AS maladie, r.preparation, r.dosage, r.precautions
     FROM PLANTE p
     LEFT JOIN REMEDE r ON r.id_plante = p.id_plante
     LEFT JOIN MALADIE m ON m.id_maladie = r.id_maladie
     ORDER BY p.nom_local'
);
$lignes = $stmt->fetchAll();

header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="pharmacopee_export_' . date('Y-m-d') . '.csv"');

$sortie = fopen('php://output', 'w');
// BOM UTF-8 pour une ouverture correcte dans Excel
fwrite($sortie, "\xEF\xBB\xBF");

fputcsv($sortie, ['Nom local', 'Nom scientifique', 'Famille botanique', 'Maladie traitée', 'Préparation', 'Dosage', 'Précautions']);
foreach ($lignes as $ligne) {
    fputcsv($sortie, [
        $ligne['nom_local'],
        $ligne['nom_scientifique'],
        $ligne['famille_botanique'],
        $ligne['maladie'],
        $ligne['preparation'],
        $ligne['dosage'],
        $ligne['precautions'],
    ]);
}
fclose($sortie);
exit;
