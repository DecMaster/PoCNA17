# PoC RO 1:

## Introduction

Le but de cette Preuve de Concept (POC) est de démontrer la possibilité d'adapter une partie de notre projet en relationnel-objet en utilisant l'outil Oracle.
Pour cela, nous allons travailler sur notre UML afin de l'adapter à une base de données relationel-objet.

La force du relationnel-objet réside dans la conservation des points forts du relationnel tout en minimisant ses défauts. Il permet ainsi de gérer des structures de données complexes tout en réduisant les pertes de performances liées aux jointures et à la normalisation. L'utilisateur a la possibilité de créer ses propres structures de données, ce qui est très intéressant pour structurer l'information. On peut également créer des collections de données, ou bien imbriquer des données les unes à l'intérieur des autres.
Un **Utilisateur**, c'est à dire soit une **Personne** soit une **Entreprise**, est donc caractérisé uniquement par ses propriétés propres, dont ses **Compétences** (uniquement pour les **Personnes**) ainsi que les **Groupes** dans lesquels il a posté des **Messages**.

Dans cette PoC, nous avons choisi d'adapter un sous-ensemble de notre MCD relationnel, comprenant ***uniquement*** les :

- **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- **Entreprises**
- **Personnes**
- **Compétences**
- **Groupe**
- **Message**

## Modèle Conceptuel de Données (MCD)

Ces informations sont représentées en UML ainsi:  
![MCD](https://imgur.com/Rbwa1ad.png)

Notre nouveau MCD comprend uniquement 5 classes :

- les **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- les **Entreprises**
- les **Personnes**
- les **Groupes**
- les **Messages**
- les **Adresses**

ainsi que deux enumérations : 

- Les **Catégories**
- Les **Genres**

Dans notre MCD, nous avons maintenant:

- Deux **compositions**, qui peuvent aussi se traduire comme des **attributs composites**: **Message** compose Groupe et **Adresse** compose Entreprise.
- La classe **Compétence** de notre précédent MCD est ici devenu un **attribut multivalué** de la classe **Personne**.

Ces choix nous permettront d'inclure les notions de Relationnel-Objet vu en cours, comme par exemple la création d'un nouveau type (pour **Adresse**), ou encore d'une collection d'objets de type particulier (pour **Message**), ou simplement une collection de plusieurs chaînes de caractères de type VARCHAR2 (pour **Compétence**). Nous avons fait le choix pour cette PoC de ne pas avoir de liens direct entre un **Message** et un **Utilisateur** : il n'est pas possible de savoir quel **Utilisateur** a écrit un **Message**.

## Transition du modèle en MLD

Le MLD obtenu contient donc **4 nouveaux types**, et **4 tables/relations**. Nous avons choisir un héritage par référence entre entre **Utilisateur**, et **Personne** / **Entreprise**.

```
Type Message : <datePublication : date, contenu : string>
Type ListeMessage : collection de <Message>
Type Adresse : <numero : int, rue : string, ville : string, codeP : int, pays : string>
Type Competence : collection de <string>

Groupe (#theme : string , description : string, messages : ListeMessage)
Utilisateur (#mail : string, resume : string, dateInscription : date, nationalite : string(2), photo : string)
Entreprise (#mail=>Utilisateur, raisonSociale : string, adresse : Adresse, dateCreation : date, siteWeb : string, categorie : {'MIC','PME','ETI','GE'})
avec raisonSociale UNIQUE NOT NULL
Personne (#mail=>Utilisateur, nom : string, prenom : string, dateNaiss : date, sexe : {'Homme','Femme','Autre'}, employeur: string, competences : Competence) avec pseudo UNIQUE NOT NULL
RejoindreGroupe (#utilisateur=>Utilisateur, #groupe=>Groupe)

Contraintes :
- PROJECTION(Utilisateur, mail) = PROJECTION(Personne, mail) UNION PROJECTION(Entreprise, mail)
- Tous les attributs sont non nuls
```

## Transition du modèle en PL/SQL

Nous ne réaliserons pas ici la contrainte sur l'héritage, car ce n'est pas ce qui nous intéresse dans cette PoC. Il faudrait créer une vue afin d'afficher les tuples ne respectant pas la contrainte. Puisque nous l'avons déjà fait dans notre projet Relationnel, nous ne le referons pas ici.

```sql
CREATE OR REPLACE TYPE Adresse AS OBJECT (
    numero NUMBER(4),
    rue VARCHAR2(50),
    ville VARCHAR2(25),
    codeP NUMBER(5),
    pays VARCHAR2(50)
);
/
CREATE OR REPLACE TYPE Message AS OBJECT (
    datePublication DATE,
    contenu VARCHAR2(3000)
);
/

CREATE TYPE ListeMessages AS TABLE OF Message;
/

CREATE TYPE Competence AS TABLE OF VARCHAR2(100);
/
CREATE TABLE Utilisateur (
    mail VARCHAR2(50) PRIMARY KEY,
    resume VARCHAR2(500) NOT NULL,
    dateInscription DATE NOT NULL,
    nationalite VARCHAR2(2) NOT NULL,
    photo VARCHAR2(200) NOT NULL
);
/
CREATE TABLE Personne (
    mail VARCHAR2(50) PRIMARY KEY,
    pseudo VARCHAR2(30) UNIQUE NOT NULL,
    nom VARCHAR2(50) NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    dateNaiss DATE NOT NULL,
    sexe VARCHAR2(5) NOT NULL CHECK (sexe IN('Homme','Femme','Autre')),
    employeur VARCHAR2(50) NOT NULL,
    competences Competence,
    FOREIGN KEY (mail) REFERENCES Utilisateur (mail)
)
NESTED TABLE competences STORE AS table_competences;
/
CREATE TABLE Entreprise (
    mail VARCHAR2(50) PRIMARY KEY,  
    raisonSociale VARCHAR2(50) UNIQUE NOT NULL,
    adresse Adresse NOT NULL,
    dateCreation DATE NOT NULL,
    siteWeb VARCHAR2(200) NOT NULL,
    categorie VARCHAR2(3) NOT NULL CHECK (categorie IN('MIC','PME','ETI','GE')),
    FOREIGN KEY (mail) REFERENCES Utilisateur (mail)
);
/
CREATE TABLE Groupe (
    theme VARCHAR2(30) PRIMARY KEY,
    description VARCHAR2(500),
    messages ListeMessages
) NESTED TABLE messages STORE AS table_messages ;
/
CREATE TABLE RejoindreGroupe (
    utilisateur VARCHAR2(50),
    groupe VARCHAR2(30),
    PRIMARY KEY (utilisateur, groupe),
    FOREIGN KEY (utilisateur) REFERENCES Utilisateur(mail),
    FOREIGN KEY (groupe) REFERENCES Groupe(theme)
);
/
```

## Insertion des données

``` sql

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo)
VALUES ('contact@utc.fr','Universite de Technologie de Compiegne',CURRENT_DATE,'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO  Entreprise(mail,raisonSociale,adresse,dateCreation,siteWeb,categorie) 
VALUES ('contact@utc.fr','UTC',adresse(NULL,'Rue Roger Couttolenc','Compiègne','60200','France'),TO_DATE('01-01-1972','DD-MM-YYYY'),'https://www.utc.fr/','GE');

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('valentin.chelle@etu.utc.fr','Etudiant à l''Universite de Technologie de Compiegne',CURRENT_DATE,'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,sexe,employeur,competences) VALUES ('valentin.chelle@etu.utc.fr','Shell','Chelle','Valentin',TO_DATE('24-03-1998','DD-MM-YYYY'),'Homme','UTC',Competence('SQL','CSS')); 


INSERT INTO Groupe (theme,description,messages) 
VALUES ('Linux','Informations relatives au système d''exploitation open source Linux.',listemessages(message(TO_DATE('02-02-2010 0:00:00','DD-MM-YYYY HH24:MI:SS'), 'Bienvenue sur le groupe Linux ! Discutez ici de vos dernières trouvailles')));

INSERT INTO Groupe (theme,description,messages)
VALUES ('Ubuntu','News et infos concernant la distribution Ubuntu sous Linux',listemessages(message(TO_DATE('02-02-2010 00:00:00','DD-MM-YYYY HH24:MI:SS'), 'Bienvenue sur le groupe Ubuntu ! Discutez ici de vos dernières trouvailles'))); 
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Linux','valentin.chelle@etu.utc.fr');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Ubuntu','valentin.chelle@etu.utc.fr');

```

### Affichage de la raison sociale de toutes les entreprises

``` sql
SELECT raisonSociale
FROM Entreprise;
```

### Affichage de tous les utilisateurs

``` sql
SELECT *
FROM Utilisateur;
```

### Affichage du thème des groupes auxquels appartient l'utilisateur correspondant au mail: 'valentin.chelle@etu.utc.fr'

``` sql
SELECT groupe AS theme
FROM RejoindreGroupe 
WHERE utilisateur = 'valentin.chelle@etu.utc.fr';

```

### Affichage de tous les messages de tous les groupes

``` sql
SELECT m.datePublication as dateP, m.contenu as contenu
FROM Groupe G, TABLE(G.messages) m;
```

### Affichage des contenu des messages du groupe dont le thème est 'Ubuntu'

``` sql
SELECT m.contenu as contenu
FROM Groupe G, TABLE(G.messages) m
WHERE G.theme = 'Ubuntu';
```

### Affichage des dates des messages des groupes qu'à rejoint valentin.chelle@etu.utc.fr

``` sql
SELECT m.datePublication as dateP
FROM Groupe G, RejoindreGroupe RG, Personne P, TABLE(G.messages) m
WHERE G.theme = RG.groupe AND RG.utilisateur = 'valentin.chelle@etu.utc.fr';
```

### Compter le nombre d'utilisateurs de la BDD

``` sql
SELECT COUNT(mail) AS Utilisateurstotaux
FROM Utilisateur;
```

### Afficher le thème et les contenus des messages des groupes auxquels appartiennent les utilisateurs ayant une adresse se terminant par "utc.fr".

``` sql
SELECT RG.groupe,  m.contenu
FROM Utilisateur U, RejoindreGroupe RG, Groupe G, TABLE(G.messages) m
WHERE U.mail LIKE '%@%utc.fr' AND RG.utilisateur = U.mail AND RG.groupe = G.theme;
```

### Afficher les compétences de valentin.chelle@etu.utc.fr

``` sql
SELECT P.competences
FROM Personne P
WHERE P.mail = 'valentin.chelle@etu.utc.fr';
```

### Afficher l'adresse de contact@utc.fr

``` sql
SELECT E.adresse.numero as numero, E.adresse.rue as rue, E.adresse.ville as ville, E.adresse.codeP as codeP, E.adresse.pays as Pays
FROM Entreprise E
WHERE E.mail = 'contact@utc.fr';
```

### Afficher les raisons sociales et codes postaux de toutes les entreprises 

``` sql
SELECT E.raisonSociale, E.adresse.codeP as codePostal
FROM Entreprise E
```

## Conséquences de l'implémentation du relationnel-objet

### Avantages

- Le système de gestion de base de données Oracle est le plus portable et le plus utilisé, puisqu'il occupe la première place dans le marché des SGBDR. Utiliser cet alternative est donc un bon moyen de s'assurer un code avec une bonne portabilité à travers les différents supports.
- Il est également plus riche en fonctionnalités que PostgreSQL : il est possible d'utiliser le langage PL/SQL qui permet notamment une manipulation procédurale de requêtes SQL. Ainsi, il est possible, grâce à ce langage, d'implémenter des fonctions complexes de manipulation de données (il y a aussi beaucoup plus de types de variables, et la possibilité d'utiliser des blocs anonymes ainsi que des strucures conditionnelles). Les résultats de requêtes, par ailleurs, peuvent être inclues dans ces nouvelles structures et stockés dans des variables.
- Le langage de programmation d'Oracle (PL/SQL), étant proche du moteur Oracle, dispose également de requêtes pré-compilées, optimisant ainsi l'exécution. Et, de manière générale, Oracle est particulièrement performant.
- On peut gérer des données complexes grâce à la notion de types, de collections et d'imbrications. On se trouve dans la réalisation plus proche de notre MCD.

### Désavantages

- Oracle est un système de gestion de base de données propriétaire et, de ce fait, limite la contribution de tiers à son élaboration et restreint l'accès au code source. Il peut deplus requérir un coût élevé en cas d'utilisations particulières.
- Les données sont structurées, on ne peut donc pas "faire ce que l'on veut" avec.

## Conclusion

Le relationnel-objet permet de réaliser des BDD relationnel-objet. Bien que le RO soit en relationnel, qui contient des défauts comme des performances moindres comparées au non relationnel, il permet par l'ajout des objets de palier à ces derniers. La syntaxe est semblable au SQL classique, mais avec des ajouts. Les objets permettent de gérer plus facilement un jeu de données  complexe. On se retrouve ainsi avec une architecture assez semblable avec notre code SQL classique, mais avec des types et des collections de types plus proches de notre modélisation initiale (MCD/MLD) qui ont été traduits efficacement depuis celle-ci. Les requêtes sont alors plus facile a écrire, et sont plus logiques à la lecture. On a donc bel et bien un projet adaptable en RO. Bien que le RO tire meilleure partie des points forts du relationnel, une de ses limites est de toujours laisser peu de libertés aux applications qui vont l'utiliser. De plus on utilise un SGBDRO propriétaire, ce qui n'est pas forcément à la convenance de tout le monde.