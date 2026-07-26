# Plateforme Numérique de Pharmacopée Traditionnelle Camerounaise

Projet RICTD — Université de Yaoundé I — 2025-2026

## Installation locale (XAMPP)

1. Copier le dossier `pharmacopee-platform/` dans `htdocs/` (ex : `C:\xampp\htdocs\pharmacopee-platform`).
2. Démarrer **Apache** et **MySQL** depuis le panneau XAMPP.
3. Ouvrir **phpMyAdmin** (`http://localhost/phpmyadmin`), créer la base en important le fichier :
   `database/schema.sql` (il crée la base `pharmacopee_camerounaise`, les tables et des données de démonstration).
4. Vérifier les identifiants de connexion dans `includes/db.php` (par défaut : `root` sans mot de passe, standard XAMPP).
5. Ouvrir le site : `http://localhost/pharmacopee-platform/public/index.html`

## Configuration du chatbot LLM (Groq)

Le chatbot utilise la variable d'environnement serveur `GROQ_API_KEY`.

### Sous Windows / XAMPP (Apache)

1. Ouvrir le fichier de configuration Apache (ex: `C:\xampp\apache\conf\httpd.conf`).
2. Ajouter une variable d'environnement, par exemple :

   ```apache
   SetEnv GROQ_API_KEY "votre_cle_api_groq"
   ```

   Optionnel pour changer de modèle :

   ```apache
   SetEnv GROQ_MODEL "llama-3.1-8b-instant"
   ```

3. Redémarrer Apache depuis XAMPP Control Panel.

Notes :
- La clé API reste côté serveur (jamais exposée dans le frontend).
- Si `GROQ_API_KEY` est absente, le chatbot fonctionne en mode local (règles + base de données).

## Structure du projet

```
pharmacopee-platform/
├── public/       → Frontend (HTML/CSS/JS servi au navigateur)
├── api/          → Backend PHP (endpoints REST, organisés par ressource)
├── includes/     → Connexion BDD, fonctions communes, vérification d'authentification
└── database/     → Script SQL de création des tables (schema.sql)
```

## Comptes de test à créer

Aucun compte n'est pré-créé (les mots de passe sont hashés). Créez un compte
administrateur manuellement après import :

```sql
INSERT INTO UTILISATEUR (nom, email, mot_passe, role)
VALUES ('Admin', 'admin@pharmacopee.cm', '$2y$10$REMPLACER_PAR_UN_HASH', 'administrateur');
```

Générez le hash avec PHP : `php -r "echo password_hash('votremotdepasse', PASSWORD_DEFAULT);"`

Ou plus simple : inscrivez-vous via `register.html` en tant que patient, puis
changez manuellement le champ `role` en `administrateur` dans phpMyAdmin.

## Prochaine étape (Étape 4 du planning)

Affiner le frontend (styles, responsive mobile), enrichir le moteur du chatbot
(`api/chatbot/analyse.php`) avec davantage de synonymes, et ajouter la gestion
des images de plantes (upload réel au lieu d'URLs statiques).
