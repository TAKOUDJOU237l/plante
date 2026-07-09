-- ============================================================
-- Plateforme Numérique de Pharmacopée Traditionnelle Camerounaise
-- Script de création de la base de données (MySQL / MariaDB)
-- Généré à partir du MLD - Document de Conception Phase 2
-- ============================================================

CREATE DATABASE IF NOT EXISTS pharmacopee_camerounaise
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE pharmacopee_camerounaise;

-- ------------------------------------------------------------
-- Table : UTILISATEUR (compte générique)
-- ------------------------------------------------------------
CREATE TABLE UTILISATEUR (
    id_utilisateur   INT AUTO_INCREMENT PRIMARY KEY,
    nom              VARCHAR(100) NOT NULL,
    email            VARCHAR(150) NOT NULL UNIQUE,
    mot_passe        VARCHAR(255) NOT NULL,           -- stocké avec password_hash()
    role             ENUM('patient', 'tradipraticien', 'chercheur', 'administrateur') NOT NULL DEFAULT 'patient',
    date_inscription DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : REGION (découpage administratif du Cameroun)
-- ------------------------------------------------------------
CREATE TABLE REGION (
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : ETHNIE
-- ------------------------------------------------------------
CREATE TABLE ETHNIE (
    id_ethnie INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL,
    id_region INT NOT NULL,
    FOREIGN KEY (id_region) REFERENCES REGION(id_region) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : SPECIALITE
-- ------------------------------------------------------------
CREATE TABLE SPECIALITE (
    id_specialite INT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : TRADIPRATICIEN (profil spécialisé lié à UTILISATEUR)
-- ------------------------------------------------------------
CREATE TABLE TRADIPRATICIEN (
    id_tradipraticien INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur    INT NOT NULL UNIQUE,
    latitude          DECIMAL(10, 7),
    longitude         DECIMAL(10, 7),
    disponibilites    VARCHAR(255),
    statut_validation ENUM('en_attente', 'valide', 'refuse') NOT NULL DEFAULT 'en_attente',
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : CHERCHEUR (profil spécialisé lié à UTILISATEUR)
-- ------------------------------------------------------------
CREATE TABLE CHERCHEUR (
    id_chercheur   INT AUTO_INCREMENT PRIMARY KEY,
    id_utilisateur INT NOT NULL UNIQUE,
    institution    VARCHAR(150),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table de liaison : TRADIPRATICIEN_SPECIALITE (N,N)
-- ------------------------------------------------------------
CREATE TABLE TRADIPRATICIEN_SPECIALITE (
    id_tradipraticien INT NOT NULL,
    id_specialite     INT NOT NULL,
    PRIMARY KEY (id_tradipraticien, id_specialite),
    FOREIGN KEY (id_tradipraticien) REFERENCES TRADIPRATICIEN(id_tradipraticien) ON DELETE CASCADE,
    FOREIGN KEY (id_specialite) REFERENCES SPECIALITE(id_specialite) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table : PLANTE
-- ------------------------------------------------------------
CREATE TABLE PLANTE (
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
CREATE TABLE MALADIE (
    id_maladie  INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(150) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Table de liaison porteuse : REMEDE (SOULAGE : PLANTE <-> MALADIE)
-- ------------------------------------------------------------
CREATE TABLE REMEDE (
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
CREATE TABLE PLANTE_ETHNIE (
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
CREATE TABLE TEMOIGNAGE (
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
-- Index utiles pour la recherche (chatbot, filtres)
-- ------------------------------------------------------------
CREATE INDEX idx_plante_nom_local ON PLANTE(nom_local);
CREATE INDEX idx_maladie_nom ON MALADIE(nom);
CREATE INDEX idx_tradi_geoloc ON TRADIPRATICIEN(latitude, longitude);

-- ============================================================
-- Données de démonstration (seed) - facultatif mais pratique en dev
-- ============================================================

INSERT INTO REGION (nom) VALUES ('Centre'), ('Littoral'), ('Ouest'), ('Nord'), ('Sud-Ouest');

INSERT INTO ETHNIE (nom, id_region) VALUES
('Beti', 1), ('Bassa', 2), ('Bamiléké', 3), ('Peul', 4), ('Bakweri', 5);

INSERT INTO SPECIALITE (nom) VALUES
('Phytothérapie'), ('Médecine osseuse'), ('Gynécologie traditionnelle'), ('Dermatologie traditionnelle');

INSERT INTO MALADIE (nom, description) VALUES
('Paludisme', 'Fièvre, maux de tête, courbatures dues au parasite Plasmodium.'),
('Maux de ventre', 'Douleurs abdominales diverses.'),
('Fièvre typhoïde', 'Infection bactérienne intestinale avec fièvre prolongée.');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url) VALUES
('Quinquina', 'Cinchona officinalis', 'Rubiaceae', 'Écorce utilisée traditionnellement contre la fièvre.', 'assets/images/quinquina.jpg'),
('Neem', 'Azadirachta indica', 'Meliaceae', 'Feuilles utilisées en infusion contre le paludisme.', 'assets/images/neem.jpg'),
('Moringa', 'Moringa oleifera', 'Moringaceae', 'Poudre de feuilles riche en nutriments, usages multiples.', 'assets/images/moringa.jpg');

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie) VALUES
('Décoction d\'écorce', '1 tasse, 2x/jour', 'Déconseillé pendant la grossesse', 1, 1),
('Infusion de feuilles', '1 tasse, 3x/jour', 'Ne pas dépasser 5 jours', 2, 1),
('Poudre en boisson', '2g / jour', 'Aucune connue à dose normale', 3, 2);

INSERT INTO PLANTE_ETHNIE (id_plante, id_ethnie, usage_traditionnel) VALUES
(1, 1, 'Utilisé traditionnellement par les Beti contre les fièvres.'),
(2, 2, 'Connu des Bassa comme remède anti-paludéen.'),
(3, 3, 'Utilisé par les Bamiléké comme complément nutritionnel.');
