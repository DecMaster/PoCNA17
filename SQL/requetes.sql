-- creation_table.sql et insertion_donnes.sql doivent avoir été exécutés au préalable.

-- Ce fichier est composé de plusieurs parties : 
-- 1) Création des vues fonctionnelles
-- 2) Créations des vues représentant les attributs dynamiques
-- 3) Affichage des vues fonctionnelles
-- 4) Affichage des vues représentant les attributs dynamiques
-- 5) Requêtes supplémentaires
-- 6) Vérification des contraintes complexes à travers l'affichage des vues de contrôles

DROP VIEW IF EXISTS vEffectifGroupe;

DROP VIEW IF EXISTS vNbMessageGroupe;

DROP VIEW IF EXISTS vGroupe;

DROP VIEW IF EXISTS vSousGroupe;

DROP VIEW IF EXISTS vPersonne;

DROP VIEW IF EXISTS vEntreprise;

---------------------------------
-- 1) Création des vues fonctionnelles
CREATE VIEW vGroupe
AS
    SELECT
        theme,
        description
    FROM
        Groupe
    WHERE
    estSousGroupe = FALSE;

CREATE VIEW vSousGroupe
AS
    SELECT
        theme,
        description,
        groupeParent
    FROM
        Groupe
    WHERE
    estSousGroupe = TRUE;

CREATE VIEW vPersonne
AS
    SELECT
        Personne.mail,
        pseudo,
        nom,
        prenom,
        genre,
        dateNaiss,
        resume,
        dateInscription,
        nationalite,
        employeur,
        photo
    FROM
        Personne,
        Utilisateur
    WHERE
    Personne.mail = Utilisateur.mail;

CREATE VIEW vEntreprise
AS
    SELECT
        Entreprise.mail,
        raisonSociale,
        adresse,
        dateCreation,
        siteWeb,
        resume,
        dateInscription,
        categorie,
        nationalite,
        photo
    FROM
        Entreprise,
        Utilisateur
    WHERE
    Entreprise.mail = Utilisateur.mail;

---------------------------------
-- 2) Création des vues correspondants aux attributs dynamiques
CREATE VIEW vEffectifGroupe
(
    nom_Groupe,
    effectif
)
AS
    SELECT
        theme,
        COUNT(utilisateur)
    FROM
        Groupe
        LEFT OUTER JOIN RejoindreGroupe ON Groupe.theme = RejoindreGroupe.groupe
    GROUP BY
    theme;

CREATE VIEW vNbMessageGroupe
(
    nom_Groupe,
    nb_message
)
AS
    SELECT
        theme,
        COUNT(utilisateur)
    FROM
        Groupe
        LEFT OUTER JOIN Message ON Groupe.theme = Message.groupe
    GROUP BY
    theme;

---------------------------------
-- 3) Affichage des vues fonctionnelles

-- Affiche toutes les Entreprises
SELECT *
FROM vEntreprise; 

-- Affiche toutes les Personnes
SELECT *
FROM vPersonne; 

-- Affiche tous les Groupes
SELECT *
FROM vGroupe; 

-- Affiche tous les Sous-Groupes
SELECT *
FROM vSousGroupe;

---------------------------------
-- 4) Affichage des vues correspondant aux attributs dynamiques

-- Donne pour chaque groupe, le nombre de messages
SELECT *
FROM vNbMessageGroupe; 

-- Donne le nombre d'Utilisateurs qui ont rejoint chaque groupe
SELECT *
FROM vEffectifGroupe; 

---------------------------------
-- 5) Requêtes supplémentaires

-- Affiche le mail des utilisateurs appartenant au groupe "Linux":
SELECT 
    G.utilisateur
FROM
    RejoindreGroupe G
WHERE 
    G.groupe='Linux'
;

-- Afficher les mails des utilisateurs ayant au moins 2 messages dans leur dossier
SELECT
    mail,
    COUNT(message) AS NbMessage
FROM
    DossierContient
GROUP BY 
    mail
HAVING 
    COUNT(message) > 1 ;

---------------------------------
-- 6) Vérification des contraintes complexes
-- SELECT * des vues de contrôle ci-dessous pour visualiser les contraintes complexesnon respectées
-- Ces contraintes n'ont pas pu être intégrés dans les CREATE TABLE(), on a donc créé des vues à la place.
-- Si toutes les contraintes sont respectées, ces requêtes devraient renvoyer des tables vides.

-- Affiche les lignes ne respectant pas les contraintes sur AvoirCompetence
SELECT *
FROM vContAvoirCompetence; 

-- Affiche les lignes ne respectant pas les contraintes complexes sur AvoirDiplome
SELECT *
FROM vContAvoirDiplome;

-- Affiche les lignes ne respectant pas les contraintes complexes sur Former
SELECT *
FROM vContFormer;

-- Affiche les lignes ne respectant pas les contraintes complexes sur Specialiser
SELECT *
FROM vContSpecialier;

-- Affiche les lignes ne respectant pas les contraintes complexes sur Utilisateur
SELECT *
FROM vContUtilisateur;

-- Affiche les lignes ne respectant pas les contraintes complexes sur Message
SELECT *
FROM vContMessage;