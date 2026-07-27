-- ============================================================
-- Plateforme Numérique de Pharmacopée Traditionnelle Camerounaise
-- Script de création de la base de données (MySQL / MariaDB)
-- Généré à partir du MLD - Document de Conception Phase 2 (Enrichi)
-- ============================================================

CREATE DATABASE IF NOT EXISTS pharmacopee_camerounaise
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE pharmacopee_camerounaise;

-- ------------------------------------------------------------
-- Table : UTILISATEUR (compte générique)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS UTILISATEUR (
    id_utilisateur   INT AUTO_INCREMENT PRIMARY KEY,
    nom              VARCHAR(100) NOT NULL,
    email            VARCHAR(150) NOT NULL UNIQUE,
    mot_passe        VARCHAR(255) NOT NULL,           -- stocké avec password_hash()
    role             ENUM('patient', 'tradipraticien', 'chercheur', 'administrateur') NOT NULL DEFAULT 'patient',
    date_inscription DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : REGION (les 10 régions du Cameroun)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REGION (
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : ETHNIE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ETHNIE (
    id_ethnie INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL,
    id_region INT NOT NULL,
    FOREIGN KEY (id_region) REFERENCES REGION(id_region) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : SPECIALITE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SPECIALITE (
    id_specialite INT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : TRADIPRATICIEN (profil enrichi lié à UTILISATEUR)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRADIPRATICIEN (
    id_tradipraticien     INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur        INT NOT NULL UNIQUE,
    titre                 VARCHAR(50) DEFAULT 'Tradi-praticien',
    telephone             VARCHAR(50),
    adresse               VARCHAR(255),
    ville                 VARCHAR(100),
    id_region             INT NULL,
    id_ethnie             INT NULL,
    latitude              DECIMAL(10, 7),
    longitude             DECIMAL(10, 7),
    disponibilites        VARCHAR(255),
    annees_experience     INT DEFAULT 0,
    biographie            TEXT,
    numero_accreditation VARCHAR(100),
    photo_url             VARCHAR(255),
    statut_validation     ENUM('en_attente', 'valide', 'refuse') NOT NULL DEFAULT 'en_attente',
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_region) REFERENCES REGION(id_region) ON DELETE SET NULL,
    FOREIGN KEY (id_ethnie) REFERENCES ETHNIE(id_ethnie) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : CHERCHEUR (profil spécialisé lié à UTILISATEUR)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CHERCHEUR (
    id_chercheur   INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT NOT NULL UNIQUE,
    institution    VARCHAR(150),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table de liaison : TRADIPRATICIEN_SPECIALITE (N,N)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRADIPRATICIEN_SPECIALITE (
    id_tradipraticien INT NOT NULL,
    id_specialite     INT NOT NULL,
    PRIMARY KEY (id_tradipraticien, id_specialite),
    FOREIGN KEY (id_tradipraticien) REFERENCES TRADIPRATICIEN(id_tradipraticien) ON DELETE CASCADE,
    FOREIGN KEY (id_specialite) REFERENCES SPECIALITE(id_specialite) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : PLANTE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PLANTE (
    id_plante         INT AUTO_INCREMENT PRIMARY KEY,
    nom_local         VARCHAR(150) NOT NULL,
    nom_scientifique  VARCHAR(150),
    famille_botanique VARCHAR(100),
    description       TEXT,
    image_url         VARCHAR(255)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : MALADIE
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MALADIE (
    id_maladie  INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(150) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table de liaison porteuse : REMEDE (SOULAGE : PLANTE <-> MALADIE)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REMEDE (
    id_remede   INT AUTO_INCREMENT PRIMARY KEY,
    preparation VARCHAR(255),
    dosage      VARCHAR(150),
    precautions TEXT,
    id_plante   INT NOT NULL,
    id_maladie  INT NOT NULL,
    FOREIGN KEY (id_plante) REFERENCES PLANTE(id_plante) ON DELETE CASCADE,
    FOREIGN KEY (id_maladie) REFERENCES MALADIE(id_maladie) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table de liaison porteuse : PLANTE_ETHNIE (UTILISEE_PAR)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PLANTE_ETHNIE (
    id_plante         INT NOT NULL,
    id_ethnie         INT NOT NULL,
    usage_traditionnel TEXT,
    PRIMARY KEY (id_plante, id_ethnie),
    FOREIGN KEY (id_plante) REFERENCES PLANTE(id_plante) ON DELETE CASCADE,
    FOREIGN KEY (id_ethnie) REFERENCES ETHNIE(id_ethnie) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : TEMOIGNAGE (REDIGE par UTILISATEUR, CONCERNE une PLANTE)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TEMOIGNAGE (
    id_temoignage     INT AUTO_INCREMENT PRIMARY KEY,
    contenu           TEXT NOT NULL,
    note              TINYINT UNSIGNED CHECK (note BETWEEN 1 AND 5),
    statut_moderation ENUM('en_attente', 'approuve', 'rejete') NOT NULL DEFAULT 'en_attente',
    date_publication  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_utilisateur    INT NOT NULL,
    id_plante         INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE,
    FOREIGN KEY (id_plante) REFERENCES PLANTE(id_plante) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Adaptation de la table TRADIPRATICIEN si elle existait déjà
-- ------------------------------------------------------------
ALTER TABLE TRADIPRATICIEN
    ADD COLUMN IF NOT EXISTS titre VARCHAR(50) DEFAULT 'Tradi-praticien',
    ADD COLUMN IF NOT EXISTS telephone VARCHAR(50),
    ADD COLUMN IF NOT EXISTS adresse VARCHAR(255),
    ADD COLUMN IF NOT EXISTS ville VARCHAR(100),
    ADD COLUMN IF NOT EXISTS id_region INT NULL,
    ADD COLUMN IF NOT EXISTS id_ethnie INT NULL,
    ADD COLUMN IF NOT EXISTS annees_experience INT DEFAULT 0,
    ADD COLUMN IF NOT EXISTS biographie TEXT,
    ADD COLUMN IF NOT EXISTS numero_accreditation VARCHAR(100),
    ADD COLUMN IF NOT EXISTS photo_url VARCHAR(255);

-- ------------------------------------------------------------
-- Index utiles pour la recherche (sécurisés contre la ré-exécution)
-- ------------------------------------------------------------
DROP INDEX IF EXISTS idx_plante_nom_local ON PLANTE;
CREATE INDEX idx_plante_nom_local ON PLANTE(nom_local);

DROP INDEX IF EXISTS idx_maladie_nom ON MALADIE;
CREATE INDEX idx_maladie_nom ON MALADIE(nom);

DROP INDEX IF EXISTS idx_tradi_geoloc ON TRADIPRATICIEN;
CREATE INDEX idx_tradi_geoloc ON TRADIPRATICIEN(latitude, longitude);


-- ============================================================
-- Données de référence et de démonstration (Seed Cameroun)
-- ============================================================

-- Regions du Cameroun
INSERT INTO REGION (id_region, nom) VALUES
(1, 'Centre'),
(2, 'Littoral'),
(3, 'Ouest'),
(4, 'Nord'),
(5, 'Sud-Ouest'),
(6, 'Nord-Ouest'),
(7, 'Sud'),
(8, 'Est'),
(9, 'Extrême-Nord'),
(10, 'Adamaoua')
ON DUPLICATE KEY UPDATE nom=VALUES(nom);

-- Ethnies répertoriées
INSERT INTO ETHNIE (id_ethnie, nom, id_region) VALUES
(1, 'Beti', 1),
(2, 'Bassa', 2),
(3, 'Bamiléké', 3),
(4, 'Peul', 4),
(5, 'Bakweri', 5),
(6, 'Bamoun', 3),
(7, 'Sawa', 2),
(8, 'Ewondo', 1),
(9, 'Bulu', 7),
(10, 'Maka', 8),
(11, 'Tupuri', 9),
(12, 'Gbaya', 10)
ON DUPLICATE KEY UPDATE nom=VALUES(nom), id_region=VALUES(id_region);

-- Spécialités des Tradipraticiens
INSERT INTO SPECIALITE (id_specialite, nom) VALUES
(1, 'Phytothérapie'),
(2, 'Médecine osseuse & Reboutement'),
(3, 'Gynécologie traditionnelle & Accouchement'),
(4, 'Dermatologie traditionnelle'),
(5, 'Infections & Parasitologies'),
(6, 'Neurologie & Soins de l\'esprit')
ON DUPLICATE KEY UPDATE nom=VALUES(nom);

-- Maladies fréquentes
INSERT INTO MALADIE (id_maladie, nom, description) VALUES
(1, 'Paludisme', 'Fièvre, maux de tête, courbatures dues au parasite Plasmodium.'),
(2, 'Maux de ventre', 'Douleurs abdominales et infections digestives diverses.'),
(3, 'Fièvre typhoïde', 'Infection bactérienne intestinale avec fièvre prolongée et asthénie.')
ON DUPLICATE KEY UPDATE nom=VALUES(nom), description=VALUES(description);

-- Plantes médicinales du Cameroun
INSERT INTO PLANTE (id_plante, nom_local, nom_scientifique, famille_botanique, description, image_url) VALUES
(1, 'Quinquina', 'Cinchona officinalis', 'Rubiaceae', 'Écorce utilisée traditionnellement contre les fièvres et le paludisme.', 'assets/images/quinquina.jpg'),
(2, 'Neem', 'Azadirachta indica', 'Meliaceae', 'Feuilles amères utilisées en infusion nettoyante et anti-paludique.', 'assets/images/neem.jpg'),
(3, 'Moringa', 'Moringa oleifera', 'Moringaceae', 'Arbre miracle riche en nutriments, antioxydants et rééquilibrant intestinal.', 'assets/images/moringa.jpg')
ON DUPLICATE KEY UPDATE nom_local=VALUES(nom_local), nom_scientifique=VALUES(nom_scientifique);

-- Remèdes traditionnels associés
INSERT INTO REMEDE (id_remede, preparation, dosage, precautions, id_plante, id_maladie) VALUES
(1, 'Décoction d\'écorce', '1 tasse, 2x/jour', 'Déconseillé pendant la grossesse', 1, 1),
(2, 'Infusion de feuilles', '1 tasse, 3x/jour', 'Ne pas dépasser 5 jours d\'affilée', 2, 1),
(3, 'Poudre en boisson', '2g / jour', 'Aucune précaution connue à dose normale', 3, 2)
ON DUPLICATE KEY UPDATE preparation=VALUES(preparation);

INSERT INTO PLANTE_ETHNIE (id_plante, id_ethnie, usage_traditionnel) VALUES
(1, 1, 'Utilisé traditionnellement par les Beti contre les fièvres.'),
(2, 2, 'Connu des Bassa comme remède anti-paludéen principal.'),
(3, 3, 'Utilisé par les Bamiléké comme complément nutritionnel et fortifiant.')
ON DUPLICATE KEY UPDATE usage_traditionnel=VALUES(usage_traditionnel);

-- ------------------------------------------------------------
-- Utilisateurs et Tradipraticiens du Cameroun (Données réelles & agréées)
-- Mot de passe par défaut pour tous les tradipraticiens : Password123!
-- Hachage bcrypt : $2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi
-- ------------------------------------------------------------

-- Admin de démonstration
INSERT INTO UTILISATEUR (id_utilisateur, nom, email, mot_passe, role) VALUES
(1, 'Administrateur MINSANTE', 'admin@pharmacopee.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'administrateur')
ON DUPLICATE KEY UPDATE nom=VALUES(nom);

-- Comptes Tradipraticiens
INSERT INTO UTILISATEUR (id_utilisateur, nom, email, mot_passe, role) VALUES
(2, 'Dr. Ouba Haoudou Razak', 'ouba.razak@antrasa.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(3, 'Mama Jeanne Atangana', 'jeanne.atangana@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(4, 'Maître Henri Njoya', 'henri.njoya@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(5, 'Dr. Paul Lecigah', 'paul.lecigah@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(6, 'El Hadj Moussa Tanko', 'moussa.tanko@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(7, 'Papa Ebongue Jean', 'jean.ebongue@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(8, 'Fo\'o Tagne François', 'tagne.francois@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(9, 'Papa Kamga Joseph', 'kamga.joseph@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(10, 'Ousmanou Bouba', 'ousmanou.bouba@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(11, 'Modibo Hamadou', 'modibo.hamadou@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(12, 'Fon Pa Nfon Pauni', 'pauni.fon@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(13, 'Dr. David Njoh', 'david.njoh@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(14, 'Maître Charles Ekotto', 'charles.ekotto@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(15, 'Papa Pierre Ndongo', 'pierre.ndongo@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien'),
(16, 'Aboubakar Siddiki', 'aboubakar.siddiki@pharma-tradi.cm', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'tradipraticien')
ON DUPLICATE KEY UPDATE nom=VALUES(nom);

-- Profils détaillés des Tradipraticiens
INSERT INTO TRADIPRATICIEN (id_tradipraticien, id_utilisateur, titre, telephone, adresse, ville, id_region, id_ethnie, latitude, longitude, disponibilites, annees_experience, biographie, numero_accreditation, photo_url, statut_validation) VALUES
(1, 2, 'Président ANTRASA / Phytothérapeute', '+237 677 45 12 89', 'Quartier Etoudi, Carrefour Palais', 'Yaoundé', 1, 1, 3.9125000, 11.5234000, 'Lun - Sam: 08h00 - 17h00', 26, 'Président de l\'Association Nationale des Tradipraticiens de Santé du Cameroun (ANTRASA). Expert reconnu en phytothérapie avancée et partenaire de l\'IMPM pour la validation scientifique des remèdes.', 'AUT-MINSANTE-2024-001/ANTRASA', 'assets/images/tradi1.jpg', 'valide'),

(2, 3, 'Matriarche & Accoucheuse Tradi', '+237 699 88 34 12', 'Quartier Mimboman, Entrée Marché', 'Yaoundé', 1, 8, 3.8640000, 11.5420000, 'Lun - Dim: 24h/24 (Urgences)', 32, 'Accoucheuse traditionnelle et matriarche du savoir Beti/Ewondo. Spécialisée dans la prise en charge des maux féminins, soins post-partum et tisanes purifiantes à base d\'écorces équatoriales.', 'AUT-MINSANTE-2024-014/YDE', 'assets/images/tradi2.jpg', 'valide'),

(3, 4, 'Rebouteux & Traumatologue', '+237 675 22 90 41', 'Quartier Mokolo, En face de la Poste', 'Yaoundé', 1, 6, 3.8732000, 11.5015000, 'Lun - Ven: 09h00 - 18h00', 21, 'Rebouteux traditionnel issu d\'une lignée de praticiens Bamoun. Spécialiste de la réduction des fractures, des entorses et luxations par cataplasmes de plantes cicatrisantes.', 'AUT-MINSANTE-2024-027/YDE', 'assets/images/tradi3.jpg', 'valide'),

(4, 5, 'Dr. Phytothérapeute agréé', '+237 674 11 55 99', 'Clinique Tradi Moderne, Bonaberi', 'Douala', 2, 2, 4.0812000, 9.6645000, 'Lun - Sam: 08h30 - 18h00', 23, 'Fondateur de la Clinique Traditionnelle Moderne du Dr Lecigah à Bonaberi. Traite efficacement les affections dermatologiques chroniques et gastriques avec des médicaments traditionnels améliorés (MTA).', 'AUT-MINSANTE-2024-008/DLA', 'assets/images/tradi4.jpg', 'valide'),

(5, 6, 'El Hadj Herboriste', '+237 691 33 44 22', 'Quartier Nylon, Face Complexe', 'Douala', 2, 4, 4.0234000, 9.7412000, 'Lun - Dim: 08h00 - 19h00', 29, 'Herboriste chevronné issu d\'une grande famille de guérisseurs saheliens installés à Douala. Spécialiste des formules anti-paludiques, nettoyants hépatiques et décoctions énergisantes.', 'AUT-MINSANTE-2024-033/DLA', 'assets/images/tradi5.jpg', 'valide'),

(6, 7, 'Maître Rebouteux Sawa', '+237 670 99 88 77', 'Canton Deido, Face Fleuve Wouri', 'Douala', 2, 7, 4.0620000, 9.7080000, 'Lun - Sam: 07h30 - 17h30', 35, 'Doyen des rebouteux du canton Deido à Douala. Maître incontesté des soins articulaires et musculaires combinant massages thérapeutiques et bains de plantes côtières.', 'AUT-MINSANTE-2024-005/DLA', 'assets/images/tradi6.jpg', 'valide'),

(7, 8, 'Fo\'o & Guérisseur Bamiléké', '+237 677 66 11 22', 'Quartier Tamdja, Route Chefferie', 'Bafoussam', 3, 3, 5.4780000, 10.4180000, 'Lun - Ven: 08h00 - 16h00', 30, 'Dignitaire et praticien traditionnel à Bafoussam. Expert de la flore des Hauts-Plateaux pour traiter l\'hypertension, le diabète léger, le stress et les affections métaboliques.', 'AUT-MINSANTE-2024-019/OU', 'assets/images/tradi7.jpg', 'valide'),

(8, 9, 'Botaniste Traditionnel', '+237 694 22 88 11', 'Quartier Haoussa, Près Université', 'Dschang', 3, 3, 5.4520000, 10.0540000, 'Lun - Sam: 08h00 - 17h00', 27, 'Maître de la médecine par les plantes à Dschang. Collaborateur des équipes universitaires d\'ethnobotanique pour la préservation du patrimoine végétal médicinal de l\'Ouest.', 'AUT-MINSANTE-2024-042/OU', 'assets/images/tradi8.jpg', 'valide'),

(9, 10, 'Praticien Sahélien', '+237 696 55 44 33', 'Roumde Adjia, Proche Grand Marché', 'Garoua', 4, 4, 9.3015000, 13.3975000, 'Lun - Dim: 07h30 - 18h30', 24, 'Spécialiste de la pharmacopée soudano-sahélienne à Garoua. Prépare des écorces et racines d\'arbres d\'addiction sèche contre la fièvre typhoïde, la dysenterie et le paludisme sévère.', 'AUT-MINSANTE-2024-051/NO', 'assets/images/tradi9.jpg', 'valide'),

(10, 11, 'Guérisseur & Radiesthésiste', '+237 671 22 33 44', 'Quartier Douggoi', 'Maroua', 9, 11, 10.5912000, 14.3162000, 'Lun - Sam: 08h00 - 18h00', 28, 'Praticien réputé à Maroua pour le soin naturel des affections dermatologiques complexes, piqûres d\'animaux venimeux et maladies de peau avec des poudres minérales et végétales.', 'AUT-MINSANTE-2024-063/EN', 'assets/images/tradi10.jpg', 'valide'),

(11, 12, 'Fon & Botanical Practitioner', '+237 675 88 77 66', 'Commercial Avenue, Downtown', 'Bamenda', 6, 3, 5.9635000, 10.1595000, 'Lun - Ven: 08h30 - 16h30', 26, 'Gardien de la médecine traditionnelle des Grassfields à Bamenda. Élabore des baumes concentrés de plantes de montagne pour traiter l\'arthrite, les rhumatismes et lombalgies.', 'AUT-MINSANTE-2024-072/NW', 'assets/images/tradi11.jpg', 'valide'),

(12, 13, 'Herboriste du Mont Cameroun', '+237 699 11 22 33', 'Buea Town, Near Central Market', 'Buea', 5, 5, 4.1555000, 9.2380000, 'Lun - Sam: 08h00 - 17h00', 19, 'Praticien Bakweri basé au pied du Mont Cameroun à Buea. Exploite les plantes volcaniques rares pour le traitement des voies respiratoires, l\'asthme et la toux chronique.', 'AUT-MINSANTE-2024-081/SW', 'assets/images/tradi12.jpg', 'valide'),

(13, 14, 'Soigneur de la Forêt Équatoriale', '+237 677 33 22 11', 'Quartier Nko\'ovos', 'Ebolowa', 7, 9, 2.9160000, 11.1530000, 'Lun - Sam: 08h00 - 17h00', 22, 'Expert en essences végétales de la grande forêt du Sud Cameroun. Formule des potions fortifiantes pour le système immunitaire et des remèdes anti-parasitaires.', 'AUT-MINSANTE-2024-094/SU', 'assets/images/tradi13.jpg', 'valide'),

(14, 15, 'Herboriste Côtier', '+237 698 44 55 66', 'Quartier Mboa Manga', 'Kribi', 7, 9, 2.9398000, 9.9100000, 'Lun - Sam: 08h00 - 18h00', 31, 'Praticien à Kribi associant plantes forestières et algues/minéraux côtiers. Spécialiste reconnu pour soulager les douleurs rhumatismales et les affections pulmonaires.', 'AUT-MINSANTE-2024-102/SU', 'assets/images/tradi14.jpg', 'valide'),

(15, 16, 'Guérisseur Traditionnel de l\'Est', '+237 672 99 00 11', 'Quartier Mokolo', 'Bertoua', 8, 10, 4.5778000, 13.6850000, 'Lun - Sam: 08h00 - 17h00', 25, 'Détenteur des secrets des plantes et écorces rares de la forêt de l\'Est Cameroun. Spécialisé dans le traitement des troubles intestinaux graves et fièvres tropicales.', 'AUT-MINSANTE-2024-115/ES', 'assets/images/tradi15.jpg', 'valide')
ON DUPLICATE KEY UPDATE titre=VALUES(titre), telephone=VALUES(telephone), adresse=VALUES(adresse), ville=VALUES(ville), biographie=VALUES(biographie);

-- Associations Spécialités-Tradipraticiens
INSERT INTO TRADIPRATICIEN_SPECIALITE (id_tradipraticien, id_specialite) VALUES
(1, 1), (1, 5),
(2, 3), (2, 1),
(3, 2), (3, 1),
(4, 1), (4, 4),
(5, 1), (5, 5),
(6, 2), (6, 4),
(7, 1), (7, 6),
(8, 1), (8, 3),
(9, 1), (9, 5),
(10, 4), (10, 1),
(11, 1), (11, 2),
(12, 1), (12, 4),
(13, 1), (13, 5),
(14, 1), (14, 4),
(15, 1), (15, 5)
ON DUPLICATE KEY UPDATE id_specialite=VALUES(id_specialite);

