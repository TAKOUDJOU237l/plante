-- ============================================================
-- Enrichissement de la base : 84 plantes camerounaises
-- Compilé à partir d'enquêtes ethnobotaniques publiées
-- (Betti 2002, Dibong et al. 2011, Ladoh-Yemeda et al. 2016,
--  Mpondo et al. 2017, étude PAMJ marchés Yaoundé 2022, etc.)
--
-- ATTENTION : données ISSUES D'ENQUETES ETHNOBOTANIQUES,
-- PAS de validation clinique. Dosages volontairement laissés
-- génériques. A FAIRE VALIDER par un professionnel de santé
-- avant toute mise en production réelle destinée à de vrais patients.
--
-- image_url pointe vers assets/images/<slug>.jpg : téléchargez
-- une photo pour chaque plante et nommez-la exactement ainsi
-- (voir la liste des noms de fichiers attendus fournie à part).
-- ============================================================

USE pharmacopee_camerounaise;

-- ---- Nouvelles maladies (insertion idempotente) ----
INSERT INTO MALADIE (nom, description)
SELECT 'Anémie', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Anémie');

INSERT INTO MALADIE (nom, description)
SELECT 'Dermatoses', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Dermatoses');

INSERT INTO MALADIE (nom, description)
SELECT 'Diabète', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Diabète');

INSERT INTO MALADIE (nom, description)
SELECT 'Fatigue', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Fatigue');

INSERT INTO MALADIE (nom, description)
SELECT 'Fièvre', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Fièvre');

INSERT INTO MALADIE (nom, description)
SELECT 'Hypertension artérielle', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Hypertension artérielle');

INSERT INTO MALADIE (nom, description)
SELECT 'Jaunisse (ictère)', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Jaunisse (ictère)');

INSERT INTO MALADIE (nom, description)
SELECT 'Maux de ventre', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Maux de ventre');

INSERT INTO MALADIE (nom, description)
SELECT 'Paludisme', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Paludisme');

INSERT INTO MALADIE (nom, description)
SELECT 'Parasites intestinaux', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Parasites intestinaux');

INSERT INTO MALADIE (nom, description)
SELECT 'Toux', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Toux');

INSERT INTO MALADIE (nom, description)
SELECT 'Troubles digestifs', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Troubles digestifs');

INSERT INTO MALADIE (nom, description)
SELECT 'Troubles urinaires', 'Catégorie regroupant les usages traditionnels recensés dans les enquêtes ethnobotaniques camerounaises.'
WHERE NOT EXISTS (SELECT 1 FROM MALADIE WHERE nom = 'Troubles urinaires');


-- ---- 84 plantes camerounaises (avec chemin d'image attendu) ----
INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Ndolé (Vernonia)', 'Vernonia amygdalina', 'Asteraceae', 'Feuille très amère, base du plat national camerounais. Recensée dans plusieurs enquêtes ethnobotaniques camerounaises pour un usage traditionnel contre le diabète et le paludisme. (Partie utilisée : Feuilles. Source : Enquêtes de marché, Cameroun.)', 'assets/images/vernonia-amygdalina.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Vernonia amygdalina');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Pygeum', 'Prunus africana', 'Rosaceae', 'Le Cameroun est le premier producteur mondial de cette écorce, largement documentée en phytothérapie pour les troubles urinaires liés à la prostate. (Partie utilisée : Écorce. Source : Littérature phytothérapique, export CITES.)', 'assets/images/prunus-africana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Prunus africana');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Corossolier', 'Annona muricata', 'Annonaceae', 'Arbre fruitier tropical dont les feuilles sont citées dans les enquêtes de marché de Yaoundé pour un usage traditionnel contre l''hypertension. (Partie utilisée : Feuilles. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/annona-muricata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Annona muricata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Citronnelle', 'Cymbopogon citratus', 'Poaceae', 'Plante aromatique très utilisée en infusion contre la fièvre et les troubles digestifs légers dans plusieurs marchés camerounais. (Partie utilisée : Feuilles. Source : Dibong et al. 2011, Douala.)', 'assets/images/cymbopogon-citratus.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cymbopogon citratus');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Avocatier', 'Persea americana', 'Lauraceae', 'Les feuilles sont citées dans les enquêtes ethnobotaniques de Yaoundé pour un usage traditionnel contre l''hypertension et le diabète. (Partie utilisée : Feuilles. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/persea-americana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Persea americana');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Basilic africain', 'Ocimum gratissimum', 'Lamiaceae', 'Plante aromatique traditionnellement utilisée en infusion pour les troubles digestifs et comme antiseptique léger. (Partie utilisée : Feuilles. Source : Usage courant marchés camerounais.)', 'assets/images/ocimum-gratissimum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ocimum gratissimum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Moambe jaune', 'Enantia chlorantha', 'Annonaceae', 'Écorce à l''intense couleur jaune, composant fréquent des recettes traditionnelles contre les crises de paludisme et la jaunisse dans la région de Yaoundé. (Partie utilisée : Écorce. Source : Betti 2002, Journal Medicinal Plants Research 2009.)', 'assets/images/enantia-chlorantha.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Enantia chlorantha');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Moambe jaune (Annickia)', 'Annickia chlorantha', 'Annonaceae', 'Nom scientifique alternatif d''Enantia chlorantha ; largement citée pour le traitement traditionnel de la jaunisse au Cameroun. (Partie utilisée : Écorce. Source : Betti & Lejoly, Journal Medicinal Plants Research 2009.)', 'assets/images/annickia-chlorantha.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Annickia chlorantha');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Brimstone tree', 'Morinda lucida', 'Rubiaceae', 'Écorce amère citée parmi les plantes antidiabétiques et antipaludiques les plus fréquemment vendues sur les marchés de Yaoundé. (Partie utilisée : Écorce. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/morinda-lucida.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Morinda lucida');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Emien', 'Alstonia boonei', 'Apocynaceae', 'Écorce très amère, largement utilisée en Afrique centrale contre l''hypertension et les fièvres. (Partie utilisée : Écorce. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/alstonia-boonei.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Alstonia boonei');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Kinjar (Rauvolfia)', 'Rauvolfia vomitoria', 'Apocynaceae', 'Racine connue en pharmacopée traditionnelle pour ses usages contre l''hypertension ; a inspiré la réserpine en pharmacologie moderne. (Partie utilisée : Racine. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/rauvolfia-vomitoria.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Rauvolfia vomitoria');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Akuamma', 'Picralima nitida', 'Apocynaceae', 'Graines amères traditionnellement utilisées contre le paludisme et comme antidiabétique dans les marchés camerounais. (Partie utilisée : Graines. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/picralima-nitida.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Picralima nitida');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Manguier', 'Mangifera indica', 'Anacardiaceae', 'Écorce et feuilles citées dans les enquêtes de marché pour un usage traditionnel contre le diabète et les troubles digestifs. (Partie utilisée : Feuilles, écorce. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/mangifera-indica.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Mangifera indica');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Aloès', 'Aloe vera', 'Asphodelaceae', 'Gel utilisé traditionnellement pour les affections cutanées et comme digestif léger. (Partie utilisée : Gel des feuilles. Source : Étude marchés Yaoundé, PAMJ 2022.)', 'assets/images/aloe-vera.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Aloe vera');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Séné cathartique', 'Cassia alata', 'Fabaceae', 'Feuilles traditionnellement utilisées contre les dermatoses fongiques (dartre) dans les marchés de Douala. (Partie utilisée : Feuilles. Source : Ladoh-Yemeda et al. 2016, Douala.)', 'assets/images/cassia-alata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cassia alata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Alchornée à feuilles de cordia', 'Alchornea cordifolia', 'Euphorbiaceae', 'Plante largement citée dans les enquêtes ethnobotaniques camerounaises pour les troubles gastro-intestinaux et la cicatrisation des plaies. (Partie utilisée : Feuilles. Source : Dibong et al. 2011, Douala.)', 'assets/images/alchornea-cordifolia.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Alchornea cordifolia');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Citronnier', 'Citrus limon', 'Rutaceae', 'Fruit et feuilles utilisés en infusion traditionnelle contre la fièvre et les états grippaux. (Partie utilisée : Fruit, feuilles. Source : Dibong et al. 2011, Douala.)', 'assets/images/citrus-limon.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Citrus limon');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Kiluma (Newbouldia)', 'Newbouldia laevis', 'Bignoniaceae', 'Espèce la plus citée dans l''étude ethnobotanique des marchés de Douala, utilisée contre le paludisme et pour la cicatrisation. (Partie utilisée : Écorce, feuilles. Source : Étude marchés Douala, ~2016.)', 'assets/images/newbouldia-laevis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Newbouldia laevis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Limettier', 'Citrus aurantiifolia', 'Rutaceae', 'Fruit acide très utilisé en jus ou décoction traditionnelle contre la fièvre. (Partie utilisée : Fruit. Source : Étude marchés Douala.)', 'assets/images/citrus-aurantiifolia.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Citrus aurantiifolia');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Moabi', 'Baillonella toxisperma', 'Sapotaceae', 'Grand arbre dont l''écorce est traditionnellement utilisée contre l''anémie, la fatigue et les vers intestinaux dans plusieurs régions forestières du Cameroun. (Partie utilisée : Écorce. Source : Betti 2002, Yaoundé.)', 'assets/images/baillonella-toxisperma.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Baillonella toxisperma');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Oboto', 'Mammea africana', 'Calophyllaceae', 'Écorce utilisée traditionnellement contre la gale et les démangeaisons cutanées, documentée dans plusieurs enquêtes camerounaises. (Partie utilisée : Écorce. Source : Étude marchés Douala, ~2016.)', 'assets/images/mammea-africana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Mammea africana');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Caïlcédrat', 'Khaya senegalensis', 'Meliaceae', 'Écorce très amère, l''une des plus utilisées en Afrique de l''Ouest et centrale contre les accès de paludisme. (Partie utilisée : Écorce. Source : Littérature pharmacopée africaine.)', 'assets/images/khaya-senegalensis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Khaya senegalensis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Amandier tropical', 'Terminalia catappa', 'Combretaceae', 'Feuilles traditionnellement utilisées en décoction contre le diabète dans plusieurs régions d''Afrique centrale. (Partie utilisée : Feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/terminalia-catappa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Terminalia catappa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Bissap / Foléré', 'Hibiscus sabdariffa', 'Malvaceae', 'Calice de la fleur, consommé en boisson (bissap) ; l''usage traditionnel contre l''hypertension est largement documenté en Afrique de l''Ouest et centrale. (Partie utilisée : Calices. Source : Littérature pharmacopée africaine.)', 'assets/images/hibiscus-sabdariffa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Hibiscus sabdariffa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Papayer', 'Carica papaya', 'Caricaceae', 'Graines et feuilles traditionnellement utilisées comme vermifuge et contre le paludisme. (Partie utilisée : Graines, feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/carica-papaya.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Carica papaya');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Goyavier', 'Psidium guajava', 'Myrtaceae', 'Feuilles largement utilisées en décoction traditionnelle contre la diarrhée. (Partie utilisée : Feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/psidium-guajava.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Psidium guajava');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Gingembre', 'Zingiber officinale', 'Zingiberaceae', 'Rhizome traditionnellement utilisé contre les nausées et les troubles digestifs. (Partie utilisée : Rhizome. Source : Usage courant.)', 'assets/images/zingiber-officinale.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Zingiber officinale');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Oignon', 'Allium cepa', 'Amaryllidaceae', 'Bulbe traditionnellement utilisé en sirop maison contre la toux et le rhume. (Partie utilisée : Bulbe. Source : Usage courant.)', 'assets/images/allium-cepa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Allium cepa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Euphorbe fluette', 'Euphorbia hirta', 'Euphorbiaceae', 'Plante herbacée pantropicale très documentée contre l''asthme, la toux et la diarrhée. (Partie utilisée : Partie aérienne. Source : Littérature ethnobotanique africaine.)', 'assets/images/euphorbia-hirta.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Euphorbia hirta');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Bident hérissé', 'Bidens pilosa', 'Asteraceae', 'Plante largement utilisée pour la cicatrisation des plaies et comme digestif traditionnel. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/bidens-pilosa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Bidens pilosa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Herbe à bouc', 'Ageratum conyzoides', 'Asteraceae', 'Utilisée traditionnellement pour désinfecter les plaies et arrêter les saignements légers. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/ageratum-conyzoides.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ageratum conyzoides');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Faux baume', 'Chromolaena odorata', 'Asteraceae', 'Feuilles écrasées appliquées traditionnellement pour accélérer la cicatrisation des plaies. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/chromolaena-odorata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Chromolaena odorata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Kinkéliba', 'Combretum micranthum', 'Combretaceae', 'Feuilles très utilisées en Afrique de l''Ouest et centrale en infusion pour le foie et la digestion. (Partie utilisée : Feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/combretum-micranthum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Combretum micranthum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Sida à feuilles aiguës', 'Sida acuta', 'Malvaceae', 'Plante herbacée traditionnellement utilisée en décoction contre la fièvre. (Partie utilisée : Feuilles, racine. Source : Littérature ethnobotanique africaine.)', 'assets/images/sida-acuta.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Sida acuta');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Casse puante', 'Cassia occidentalis', 'Fabaceae', 'Graines et feuilles traditionnellement utilisées contre le paludisme et la fièvre. (Partie utilisée : Feuilles, graines. Source : Littérature ethnobotanique africaine.)', 'assets/images/cassia-occidentalis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cassia occidentalis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Pêcher africain', 'Nauclea latifolia', 'Rubiaceae', 'Racine très largement citée en Afrique centrale et de l''Ouest contre le paludisme, la fièvre et le diabète. (Partie utilisée : Racine, écorce. Source : Littérature pharmacopée africaine.)', 'assets/images/nauclea-latifolia.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Nauclea latifolia');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Faux poivrier', 'Piper guineense', 'Piperaceae', 'Graines traditionnellement utilisées comme stimulant digestif. (Partie utilisée : Graines. Source : Littérature ethnobotanique africaine.)', 'assets/images/piper-guineense.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Piper guineense');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Poivre de Guinée (Xylopia)', 'Xylopia aethiopica', 'Annonaceae', 'Fruits traditionnellement utilisés contre la toux et les troubles respiratoires légers. (Partie utilisée : Fruits. Source : Littérature ethnobotanique africaine.)', 'assets/images/xylopia-aethiopica.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Xylopia aethiopica');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Noix de kola amère', 'Garcinia kola', 'Clusiaceae', 'Graines mâchées traditionnellement contre la toux et les affections hépatiques. (Partie utilisée : Graines. Source : Littérature pharmacopée africaine.)', 'assets/images/garcinia-kola.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Garcinia kola');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Colatier', 'Cola acuminata', 'Malvaceae', 'Noix de kola, stimulant traditionnel contre la fatigue, largement consommée au Cameroun. (Partie utilisée : Graines. Source : Usage courant.)', 'assets/images/cola-acuminata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cola acuminata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Aidan', 'Tetrapleura tetraptera', 'Fabaceae', 'Fruit traditionnellement utilisé en assaisonnement et en décoction contre le diabète. (Partie utilisée : Fruit. Source : Littérature pharmacopée africaine.)', 'assets/images/tetrapleura-tetraptera.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Tetrapleura tetraptera');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Eru / Okok', 'Gnetum africanum', 'Gnetaceae', 'Feuille alimentaire très consommée au Cameroun (plat ''eru''), également utilisée traditionnellement contre l''anémie. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/gnetum-africanum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Gnetum africanum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Safoutier', 'Dacryodes edulis', 'Burseraceae', 'Écorce traditionnellement utilisée contre les troubles digestifs ; fruit très consommé au Cameroun. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/dacryodes-edulis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Dacryodes edulis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Mangue sauvage / Odika', 'Irvingia gabonensis', 'Irvingiaceae', 'Amande traditionnellement utilisée contre le diabète et le cholestérol élevé. (Partie utilisée : Amande. Source : Littérature pharmacopée africaine.)', 'assets/images/irvingia-gabonensis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Irvingia gabonensis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Figuier râpeux', 'Ficus exasperata', 'Moraceae', 'Feuilles traditionnellement utilisées en décoction contre le diabète. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/ficus-exasperata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ficus exasperata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Prunier mombin', 'Spondias mombin', 'Anacardiaceae', 'Écorce et feuilles traditionnellement utilisées contre la diarrhée et la dysenterie. (Partie utilisée : Écorce, feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/spondias-mombin.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Spondias mombin');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Harungane', 'Harungana madagascariensis', 'Hypericaceae', 'Écorce et résine traditionnellement utilisées pour les affections cutanées et la cicatrisation des plaies. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/harungana-madagascariensis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Harungana madagascariensis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Bridelia ferrugineux', 'Bridelia ferruginea', 'Phyllanthaceae', 'Écorce traditionnellement utilisée contre le diabète et l''hypertension en Afrique de l''Ouest et centrale. (Partie utilisée : Écorce. Source : Littérature pharmacopée africaine.)', 'assets/images/bridelia-ferruginea.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Bridelia ferruginea');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Fraké', 'Terminalia superba', 'Combretaceae', 'Écorce traditionnellement utilisée en décoction contre la fièvre. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/terminalia-superba.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Terminalia superba');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Fromager', 'Ceiba pentandra', 'Malvaceae', 'Écorce traditionnellement utilisée comme digestif et contre les troubles intestinaux. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/ceiba-pentandra.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ceiba pentandra');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Palmier à huile', 'Elaeis guineensis', 'Arecaceae', 'Huile traditionnellement appliquée sur les plaies et utilisée comme support de préparations traditionnelles. (Partie utilisée : Huile. Source : Usage courant.)', 'assets/images/elaeis-guineensis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Elaeis guineensis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Manioc', 'Manihot esculenta', 'Euphorbiaceae', 'Feuilles traditionnellement consommées et utilisées contre l''anémie dans plusieurs villages camerounais. (Partie utilisée : Feuilles. Source : Mpondo et al. 2017.)', 'assets/images/manihot-esculenta.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Manihot esculenta');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Bananier plantain', 'Musa paradisiaca', 'Musaceae', 'Sève et fruit traditionnellement utilisés contre les troubles digestifs. (Partie utilisée : Sève, fruit. Source : Usage courant.)', 'assets/images/musa-paradisiaca.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Musa paradisiaca');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Ananas', 'Ananas comosus', 'Bromeliaceae', 'Jus traditionnellement utilisé comme vermifuge léger et digestif. (Partie utilisée : Fruit. Source : Usage courant.)', 'assets/images/ananas-comosus.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ananas comosus');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Oranger', 'Citrus sinensis', 'Rutaceae', 'Feuilles et écorce traditionnellement utilisées en infusion contre la fièvre. (Partie utilisée : Feuilles, écorce. Source : Usage courant.)', 'assets/images/citrus-sinensis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Citrus sinensis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Cocotier', 'Cocos nucifera', 'Arecaceae', 'Eau de coco traditionnellement utilisée pour la réhydratation en cas de diarrhée. (Partie utilisée : Eau de fruit. Source : Usage courant.)', 'assets/images/cocos-nucifera.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cocos nucifera');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Tamarinier', 'Tamarindus indica', 'Fabaceae', 'Pulpe du fruit traditionnellement utilisée contre la fièvre et comme laxatif léger. (Partie utilisée : Fruit. Source : Littérature pharmacopée africaine.)', 'assets/images/tamarindus-indica.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Tamarindus indica');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Sésame', 'Sesamum indicum', 'Pedaliaceae', 'Huile de graines traditionnellement utilisée en soin de la peau. (Partie utilisée : Graines. Source : Usage courant.)', 'assets/images/sesamum-indicum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Sesamum indicum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Piment', 'Capsicum frutescens', 'Solanaceae', 'Fruit traditionnellement utilisé comme stimulant digestif et circulatoire. (Partie utilisée : Fruit. Source : Usage courant.)', 'assets/images/capsicum-frutescens.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Capsicum frutescens');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Morelle', 'Solanum torvum', 'Solanaceae', 'Fruit et feuilles traditionnellement utilisés contre les troubles digestifs. (Partie utilisée : Feuilles, fruit. Source : Littérature ethnobotanique africaine.)', 'assets/images/solanum-torvum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Solanum torvum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Prunier noir', 'Vitex doniana', 'Lamiaceae', 'Écorce traditionnellement utilisée contre la diarrhée et la fièvre. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/vitex-doniana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Vitex doniana');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Piliostigma', 'Piliostigma thonningii', 'Fabaceae', 'Feuilles et écorce traditionnellement utilisées contre la diarrhée. (Partie utilisée : Feuilles, écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/piliostigma-thonningii.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Piliostigma thonningii');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Anacardier', 'Anacardium occidentale', 'Anacardiaceae', 'Écorce et feuilles traditionnellement utilisées contre le diabète. (Partie utilisée : Écorce, feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/anacardium-occidentale.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Anacardium occidentale');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Néré', 'Parkia biglobosa', 'Fabaceae', 'Écorce traditionnellement utilisée contre l''hypertension en Afrique de l''Ouest et centrale. (Partie utilisée : Écorce. Source : Littérature pharmacopée africaine.)', 'assets/images/parkia-biglobosa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Parkia biglobosa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Baobab', 'Adansonia digitata', 'Malvaceae', 'Pulpe du fruit et feuilles traditionnellement utilisées contre la fièvre et pour renforcer l''organisme. (Partie utilisée : Fruit, feuilles. Source : Littérature pharmacopée africaine.)', 'assets/images/adansonia-digitata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Adansonia digitata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Casse de Siberia', 'Cassia sieberiana', 'Fabaceae', 'Racine traditionnellement utilisée contre le paludisme et les troubles digestifs. (Partie utilisée : Racine. Source : Littérature ethnobotanique africaine.)', 'assets/images/cassia-sieberiana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Cassia sieberiana');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Iroko', 'Milicia excelsa', 'Moraceae', 'Écorce traditionnellement utilisée en décoction contre la fièvre. (Partie utilisée : Écorce. Source : Littérature ethnobotanique africaine.)', 'assets/images/milicia-excelsa.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Milicia excelsa');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Acajou de savane', 'Khaya grandifoliola', 'Meliaceae', 'Écorce amère traditionnellement utilisée contre le paludisme, proche du caïlcédrat. (Partie utilisée : Écorce. Source : Littérature pharmacopée africaine.)', 'assets/images/khaya-grandifoliola.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Khaya grandifoliola');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Poivrier long', 'Piper umbellatum', 'Piperaceae', 'Feuilles traditionnellement utilisées contre la fièvre et pour la cicatrisation. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/piper-umbellatum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Piper umbellatum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Poivre de Guinée (Aframomum)', 'Aframomum melegueta', 'Zingiberaceae', 'Graines traditionnellement utilisées comme stimulant digestif et épice. (Partie utilisée : Graines. Source : Usage courant.)', 'assets/images/aframomum-melegueta.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Aframomum melegueta');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Canne du diable', 'Costus afer', 'Costaceae', 'Tige traditionnellement utilisée contre la fièvre et pour la cicatrisation des plaies. (Partie utilisée : Tige. Source : Littérature ethnobotanique africaine.)', 'assets/images/costus-afer.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Costus afer');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Ricin', 'Ricinus communis', 'Euphorbiaceae', 'Huile de graines traditionnellement utilisée comme purgatif léger. (Partie utilisée : Graines. Source : Littérature pharmacopée africaine.)', 'assets/images/ricinus-communis.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ricinus communis');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Pignon d''Inde', 'Jatropha curcas', 'Euphorbiaceae', 'Latex traditionnellement appliqué sur les plaies pour arrêter les saignements. (Partie utilisée : Latex. Source : Littérature ethnobotanique africaine.)', 'assets/images/jatropha-curcas.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Jatropha curcas');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Herbe médicinale (Justicia)', 'Justicia secunda', 'Acanthaceae', 'Feuilles traditionnellement utilisées contre l''anémie dans plusieurs régions d''Afrique centrale. (Partie utilisée : Feuilles. Source : Littérature ethnobotanique africaine.)', 'assets/images/justicia-secunda.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Justicia secunda');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Talinum', 'Talinum triangulare', 'Talinaceae', 'Légume-feuille traditionnellement consommé pour lutter contre l''anémie. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/talinum-triangulare.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Talinum triangulare');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Amarante', 'Amaranthus hybridus', 'Amaranthaceae', 'Légume-feuille riche en fer, traditionnellement recommandé en cas d''anémie. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/amaranthus-hybridus.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Amaranthus hybridus');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Corète potagère', 'Corchorus olitorius', 'Malvaceae', 'Légume-feuille traditionnellement utilisé comme digestif doux. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/corchorus-olitorius.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Corchorus olitorius');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Patate douce', 'Ipomoea batatas', 'Convolvulaceae', 'Feuilles traditionnellement utilisées en cataplasme ou décoction contre les troubles digestifs légers. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/ipomoea-batatas.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ipomoea batatas');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Igname', 'Dioscorea alata', 'Dioscoreaceae', 'Tubercule traditionnellement valorisé pour ses apports énergétiques en cas de fatigue. (Partie utilisée : Tubercule. Source : Usage courant.)', 'assets/images/dioscorea-alata.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Dioscorea alata');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Arachide', 'Arachis hypogaea', 'Fabaceae', 'Graine traditionnellement recommandée comme apport énergétique. (Partie utilisée : Graines. Source : Usage courant.)', 'assets/images/arachis-hypogaea.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Arachis hypogaea');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Maïs', 'Zea mays', 'Poaceae', 'Barbes de maïs traditionnellement utilisées en infusion pour les troubles urinaires légers. (Partie utilisée : Barbes (soies). Source : Usage courant.)', 'assets/images/zea-mays.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Zea mays');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Basilic sacré', 'Ocimum basilicum', 'Lamiaceae', 'Feuilles traditionnellement utilisées en infusion contre la toux et comme calmant digestif. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/ocimum-basilicum.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Ocimum basilicum');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Menthe', 'Mentha piperita', 'Lamiaceae', 'Feuilles traditionnellement utilisées en infusion contre les troubles digestifs et les maux de tête. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/mentha-piperita.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Mentha piperita');

INSERT INTO PLANTE (nom_local, nom_scientifique, famille_botanique, description, image_url)
SELECT 'Eucalyptus', 'Eucalyptus globulus', 'Myrtaceae', 'Feuilles traditionnellement utilisées en inhalation contre la toux et les affections respiratoires. (Partie utilisée : Feuilles. Source : Usage courant.)', 'assets/images/eucalyptus-globulus.jpg'
WHERE NOT EXISTS (SELECT 1 FROM PLANTE WHERE nom_scientifique = 'Eucalyptus globulus');


-- ---- Remèdes associés (préparation/dosage volontairement génériques) ----
INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Vernonia amygdalina' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Prunus africana' AND m.nom = 'Troubles urinaires'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Annona muricata' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cymbopogon citratus' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Persea americana' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ocimum gratissimum' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Enantia chlorantha' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Annickia chlorantha' AND m.nom = 'Jaunisse (ictère)'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Morinda lucida' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Alstonia boonei' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Racine)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Rauvolfia vomitoria' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Picralima nitida' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Mangifera indica' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Gel des feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Aloe vera' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cassia alata' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Alchornea cordifolia' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Citrus limon' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Newbouldia laevis' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Citrus aurantiifolia' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Baillonella toxisperma' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Mammea africana' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Khaya senegalensis' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Terminalia catappa' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Calices)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Hibiscus sabdariffa' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Carica papaya' AND m.nom = 'Parasites intestinaux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Psidium guajava' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Rhizome)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Zingiber officinale' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Bulbe)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Allium cepa' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Partie aérienne)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Euphorbia hirta' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Bidens pilosa' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ageratum conyzoides' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Chromolaena odorata' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Combretum micranthum' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, racine)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Sida acuta' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cassia occidentalis' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Racine, écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Nauclea latifolia' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Piper guineense' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruits)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Xylopia aethiopica' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Garcinia kola' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cola acuminata' AND m.nom = 'Fatigue'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Tetrapleura tetraptera' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Gnetum africanum' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Dacryodes edulis' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Amande)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Irvingia gabonensis' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ficus exasperata' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Spondias mombin' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Harungana madagascariensis' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Bridelia ferruginea' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Terminalia superba' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ceiba pentandra' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Huile)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Elaeis guineensis' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Manihot esculenta' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Sève, fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Musa paradisiaca' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ananas comosus' AND m.nom = 'Parasites intestinaux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Citrus sinensis' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Eau de fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cocos nucifera' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Tamarindus indica' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Sesamum indicum' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Capsicum frutescens' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, fruit)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Solanum torvum' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Vitex doniana' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles, écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Piliostigma thonningii' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Anacardium occidentale' AND m.nom = 'Diabète'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Parkia biglobosa' AND m.nom = 'Hypertension artérielle'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Fruit, feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Adansonia digitata' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Racine)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Cassia sieberiana' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Milicia excelsa' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Écorce)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Khaya grandifoliola' AND m.nom = 'Paludisme'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Piper umbellatum' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Aframomum melegueta' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Tige)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Costus afer' AND m.nom = 'Fièvre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ricinus communis' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Latex)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Jatropha curcas' AND m.nom = 'Dermatoses'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Justicia secunda' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Talinum triangulare' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Amaranthus hybridus' AND m.nom = 'Anémie'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Corchorus olitorius' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ipomoea batatas' AND m.nom = 'Maux de ventre'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Tubercule)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Dioscorea alata' AND m.nom = 'Fatigue'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Graines)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Arachis hypogaea' AND m.nom = 'Fatigue'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Barbes (soies))', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Zea mays' AND m.nom = 'Troubles urinaires'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Ocimum basilicum' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Mentha piperita' AND m.nom = 'Troubles digestifs'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

INSERT INTO REMEDE (preparation, dosage, precautions, id_plante, id_maladie)
SELECT 'Décoction/infusion traditionnelle (Feuilles)', 'À déterminer par un professionnel de santé', 'Donnée issue d''enquête ethnobotanique, non clinique. Ne pas s''auto-médicamenter ; consulter un professionnel de santé, surtout en cas de grossesse, jeune enfant ou traitement en cours.', p.id_plante, m.id_maladie
FROM PLANTE p, MALADIE m
WHERE p.nom_scientifique = 'Eucalyptus globulus' AND m.nom = 'Toux'
AND NOT EXISTS (SELECT 1 FROM REMEDE r WHERE r.id_plante = p.id_plante AND r.id_maladie = m.id_maladie);

