DROP TABLE IF EXISTS Utilisateur CASCADE;

DROP TABLE IF EXISTS Personne CASCADE;

DROP TABLE IF EXISTS Entreprise CASCADE;

DROP TABLE IF EXISTS Lien CASCADE;

DROP TABLE IF EXISTS Formation CASCADE;

DROP TABLE IF EXISTS Former CASCADE;

DROP TABLE IF EXISTS Competence CASCADE;

DROP TABLE IF EXISTS AvoirCompetence CASCADE;

DROP TABLE IF EXISTS Diplome CASCADE;

DROP TABLE IF EXISTS AvoirDiplome CASCADE;

DROP TABLE IF EXISTS Message CASCADE;

DROP TABLE IF EXISTS Fichier CASCADE;

DROP TABLE IF EXISTS Dossier CASCADE;

DROP TABLE IF EXISTS Groupe CASCADE;

DROP TABLE IF EXISTS Specialiser CASCADE;

DROP TABLE IF EXISTS Sinteresser CASCADE;

DROP TABLE IF EXISTS Domaine CASCADE;

DROP TABLE IF EXISTS RejoindreGroupe CASCADE;

DROP TABLE IF EXISTS DossierContient CASCADE;

DROP VIEW IF EXISTS vContAvoirCompetence;

DROP VIEW IF EXISTS vContAvoirDiplome;

DROP VIEW IF EXISTS vContFormer;

DROP VIEW IF EXISTS vContSpecialier;

DROP VIEW IF EXISTS vContUtilisateur;

DROP VIEW IF EXISTS vEffectifGroupe;

DROP VIEW IF EXISTS vEntreprise;

DROP VIEW IF EXISTS vGroupe;

DROP VIEW IF EXISTS vNbMessageGroupe;

DROP VIEW IF EXISTS vPersonne;

DROP VIEW IF EXISTS vSousGroupe;

DROP VIEW IF EXISTS vContMessage;


CREATE TABLE Utilisateur (
    mail VARCHAR(50) PRIMARY KEY,
    resume VARCHAR(500),
    dateInscription DATE NOT NULL,
    nationalite CHAR(2),
    photo VARCHAR
);

CREATE TABLE Personne (
    mail VARCHAR(50) PRIMARY KEY,
    pseudo VARCHAR(30) UNIQUE NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    dateNaiss DATE NOT NULL,
    genre CHAR(5) CHECK (genre IN ('Homme',
            'Femme',
            'Autre')),
    employeur VARCHAR(50),
    FOREIGN KEY (mail) REFERENCES Utilisateur (mail) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Entreprise (
    mail VARCHAR(50) PRIMARY KEY,
    raisonSociale VARCHAR(50) UNIQUE NOT NULL,
    adresse VARCHAR(500) NOT NULL,
    dateCreation DATE NOT NULL,
    siteWeb VARCHAR(50),
    categorie VARCHAR(3) CHECK (categorie IN ('MIC',
            'PME',
            'ETI',
            'GE')),
    FOREIGN KEY (mail) REFERENCES Utilisateur (mail) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Lien (
    pseudoP1 VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    pseudoP2 VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    relation VARCHAR(10) CHECK (relation IN ('amis',
            'collegues',
            'connaissances')),
    CHECK (pseudoP1 != pseudoP2),
    PRIMARY KEY (pseudoP1,pseudoP2,relation)
);

CREATE TABLE Formation (
    nom VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Former (
    formation VARCHAR(100) REFERENCES Formation (nom) ON DELETE CASCADE ON UPDATE CASCADE,
    personne VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    debut DATE NOT NULL,
    fin DATE NOT NULL,
    PRIMARY KEY (formation, personne)
);

CREATE TABLE Competence (
    nom VARCHAR(50) PRIMARY KEY
);

CREATE TABLE AvoirCompetence (
    competence VARCHAR(50) REFERENCES Competence (nom) ON DELETE CASCADE ON UPDATE CASCADE,
    personne VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (competence, personne)
);

CREATE TABLE Diplome (
    intitule VARCHAR(200) PRIMARY KEY
);

CREATE TABLE AvoirDiplome (
    diplome VARCHAR(200) REFERENCES Diplome (intitule) ON DELETE CASCADE ON UPDATE CASCADE,
    pseudo VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (diplome, pseudo)
);

CREATE TABLE Groupe (
    theme VARCHAR(30) PRIMARY KEY,
    description VARCHAR(500) NOT NULL,
    groupeParent VARCHAR(30) REFERENCES Groupe (theme) ON UPDATE CASCADE,
    estSousGroupe BOOLEAN NOT NULL CHECK ((estSousGroupe = TRUE
            AND (groupeParent IS NOT NULL))
        OR (estSousGroupe = FALSE
            AND (groupeParent IS NULL)))
);

CREATE TABLE Message (
    id BIGSERIAL,
    groupe VARCHAR(30) REFERENCES Groupe (theme) ON DELETE CASCADE ON UPDATE CASCADE,
    datePublication TIMESTAMP NOT NULL,
    contenu VARCHAR(8000) NOT NULL,
    utilisateur VARCHAR(50) NOT NULL,
    FOREIGN KEY (utilisateur) REFERENCES Utilisateur (mail) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (id, groupe)
);

CREATE TABLE Fichier (
    nom VARCHAR(100),
    message BIGSERIAL,
    groupe VARCHAR(30),
    contenu VARCHAR NOT NULL,
    FOREIGN KEY (message,
        groupe) REFERENCES Message (id,
        groupe) ON DELETE CASCADE,
    PRIMARY KEY (nom, message, groupe)
);

CREATE TABLE Dossier (
    nom VARCHAR(100),
    utilisateur VARCHAR(50) REFERENCES Utilisateur (mail) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (nom, utilisateur)
);

CREATE TABLE Domaine (
    nom VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Specialiser (
    domaine VARCHAR(50) REFERENCES Domaine (nom) ON DELETE CASCADE ON UPDATE CASCADE,
    entreprise VARCHAR(50) REFERENCES Entreprise (raisonSociale) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (domaine, entreprise)
);

CREATE TABLE Sinteresser (
    domaine VARCHAR(50) REFERENCES Domaine (nom) ON DELETE CASCADE ON UPDATE CASCADE,
    personne VARCHAR(30) REFERENCES Personne (pseudo) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (personne, domaine)
);

CREATE TABLE RejoindreGroupe (
    groupe VARCHAR(30) REFERENCES Groupe (theme) ON DELETE CASCADE ON UPDATE CASCADE,
    utilisateur VARCHAR(50) REFERENCES Utilisateur (mail) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (groupe, utilisateur)
);

CREATE TABLE DossierContient (
    message BIGSERIAL,
    groupe VARCHAR(30),
    nomDossier VARCHAR(100),
    mail VARCHAR(50),
    FOREIGN KEY (message,
        groupe) REFERENCES Message (id,
        groupe) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nomDossier,
        mail) REFERENCES Dossier (nom,
        utilisateur) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (message, groupe, nomDossier, mail)
);

CREATE VIEW vEffectifGroupe (
    nom_Groupe,
    effectif) AS
SELECT
    theme,
    COUNT(
        utilisateur)
FROM
    Groupe
    LEFT OUTER JOIN RejoindreGroupe ON Groupe.theme = RejoindreGroupe.groupe
GROUP BY
    theme;

CREATE VIEW vNbMessageGroupe (
    nom_Groupe,
    nb_message) AS
SELECT
    theme,
    COUNT(
        utilisateur)
FROM
    Groupe
    LEFT OUTER JOIN Message ON Groupe.theme = Message.groupe
GROUP BY
    theme;

CREATE VIEW vGroupe AS
SELECT
    theme,
    description
FROM
    Groupe
WHERE
    estSousGroupe = FALSE;

CREATE VIEW vSousGroupe AS
SELECT
    theme,
    description,
    groupeParent
FROM
    Groupe
WHERE
    estSousGroupe = TRUE;

CREATE VIEW vPersonne AS
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

CREATE VIEW vEntreprise AS
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

-- Les vues ci-dessous sont les contraintes dynamiques de nos tables.
-- Un SELECT * de chacune de ces vues renvoie une table vide
-- si toutes les contraintes sont respectées sur les données.

CREATE VIEW vContFormer AS
SELECT
    pseudo
FROM
    Personne
EXCEPT
SELECT
    personne
FROM
    Former
GROUP BY
    personne;

CREATE VIEW vContAvoirCompetence AS
SELECT
    pseudo
FROM
    Personne
EXCEPT
SELECT
    personne
FROM
    AvoirCompetence
GROUP BY
    personne;

CREATE VIEW vContAvoirDiplome AS
SELECT
    pseudo
FROM
    Personne
EXCEPT
SELECT
    pseudo
FROM
    AvoirDiplome
GROUP BY
    pseudo;

CREATE VIEW vContMessage AS
SELECT
    groupe,
    utilisateur
FROM
    Message
GROUP BY
    groupe,
    utilisateur
EXCEPT
SELECT
    *
FROM
    RejoindreGroupe;

CREATE VIEW vContSpecialier AS
SELECT
    raisonSociale
FROM
    Entreprise
EXCEPT
SELECT
    entreprise
FROM
    Specialiser
GROUP BY
    entreprise;

CREATE VIEW vContUtilisateur AS
SELECT
    mail
FROM
    Utilisateur
EXCEPT
SELECT
    mail
FROM
    Entreprise
EXCEPT
SELECT
    mail
FROM
    Personne;

CREATE OR REPLACE FUNCTION filsDeviennentPere ()
    RETURNS TRIGGER
    AS $$
BEGIN
    UPDATE
        groupe
    SET
        estsousgroupe = FALSE,
        groupeparent = NULL
    WHERE
        groupeparent = OLD.theme;
    RETURN OLD;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER updateSousGroupe
    BEFORE DELETE ON groupe
    FOR EACH ROW
    WHEN (OLD.estSousGroupe = FALSE)
    EXECUTE PROCEDURE filsDeviennentPere ();

