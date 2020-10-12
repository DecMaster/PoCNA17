-- Ajout des Utilisateurs de bases

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('robinrosseeuw.rr@gmail.com','Etudiant à l''Universite de Technologie de Compiegne',NOW(),'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,genre,employeur) VALUES ('robinrosseeuw.rr@gmail.com','Robin.R','Rosseeuw','Robin','1998-02-26','Homme','UTC'); 

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('valentin.chelle@etu.utc.fr','Etudiant à l''Universite de Technologie de Compiegne',NOW(),'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,genre,employeur) VALUES ('valentin.chelle@etu.utc.fr','Shell','Chelle','Valentin','1998-03-24','Homme','UTC'); 

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('theo.chevalier@etu.utc.fr','Etudiant à l''Universite de Technologie de Compiegne',NOW(),'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,genre,employeur) VALUES ('theo.chevalier@etu.utc.fr','Mez','Chevalier','Théo','1998-07-01','Homme','UTC'); 

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('elisa.finzy@etu.utc.fr','Etudiant à l''Universite de Technologie de Compiegne',NOW(),'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,genre,employeur) VALUES ('elisa.finzy@etu.utc.fr','Elisa.F','Finzy','Elisa','1998-08-07','Femme','UTC'); 

INSERT INTO Utilisateur (mail,resume,dateInscription,nationalite,photo) VALUES ('contact@utc.fr','Universite de Technologie de Compiegne',NOW(),'FR','https://gitlab.utc.fr/chelleva/na17/raw/master/images/default.jpg');
INSERT INTO Entreprise (mail,raisonSociale,adresse,dateCreation,siteWeb,categorie) VALUES ('contact@utc.fr','UTC','Rue Roger Coutolenc, 60200 Compiègne','1972-01-01','https://www.utc.fr/',NULL); 

-- Ajout des Compétences

INSERT INTO Competence (nom) VALUES ('C');
INSERT INTO Competence (nom) VALUES ('C++');
INSERT INTO Competence (nom) VALUES ('C#');
INSERT INTO Competence (nom) VALUES ('SQL');
INSERT INTO Competence (nom) VALUES ('Python');
INSERT INTO Competence (nom) VALUES ('Java');
INSERT INTO Competence (nom) VALUES ('Javascript');
INSERT INTO Competence (nom) VALUES ('HTML');
INSERT INTO Competence (nom) VALUES ('CSS');
INSERT INTO Competence (nom) VALUES ('Leadership');

INSERT INTO AvoirCompetence (competence, personne) VALUES ('SQL','Shell');
INSERT INTO AvoirCompetence (competence, personne) VALUES ('CSS','Shell');
INSERT INTO AvoirCompetence (competence, personne) VALUES ('Javascript','Mez');
INSERT INTO AvoirCompetence (competence, personne) VALUES ('Python','Elisa.F');
INSERT INTO AvoirCompetence (competence, personne) VALUES ('C++','Robin.R');

-- Ajout des Diplomes

INSERT INTO Diplome (intitule) VALUES ('Master en Ingénieurie Informatique');
INSERT INTO Diplome (intitule) VALUES ('Doctorat en Sciences de l''informatique');

INSERT INTO AvoirDiplome (diplome, pseudo) VALUES ('Master en Ingénieurie Informatique','Mez');
INSERT INTO AvoirDiplome (diplome, pseudo) VALUES ('Master en Ingénieurie Informatique','Shell');
INSERT INTO AvoirDiplome (diplome, pseudo) VALUES ('Master en Ingénieurie Informatique','Robin.R');
INSERT INTO AvoirDiplome (diplome, pseudo) VALUES ('Master en Ingénieurie Informatique','Elisa.F');

-- Ajout des Formations

INSERT INTO Formation (nom) VALUES ('Formation d''Ingénieur informatique - Université de Technologie de Compiègne (France)');

/* A CHANGER POUR METTRE LA DATE */
INSERT INTO Former (debut, fin, formation, personne) VALUES ('2016-09-02','2021-06-23','Formation d''Ingénieur informatique - Université de Technologie de Compiègne (France)','Mez');
INSERT INTO Former (debut, fin, formation, personne) VALUES ('2016-09-02','2021-06-23','Formation d''Ingénieur informatique - Université de Technologie de Compiègne (France)','Elisa.F');
INSERT INTO Former (debut, fin, formation, personne) VALUES ('2016-09-02','2021-06-23','Formation d''Ingénieur informatique - Université de Technologie de Compiègne (France)','Shell');
INSERT INTO Former (debut, fin, formation, personne) VALUES ('2016-09-02','2021-06-23','Formation d''Ingénieur informatique - Université de Technologie de Compiègne (France)','Robin.R');

-- Ajout des Domaines

INSERT INTO Domaine (nom) VALUES ('Informatique');
INSERT INTO Domaine (nom) VALUES ('Biologie');
INSERT INTO Domaine (nom) VALUES ('Astronomie');
INSERT INTO Domaine (nom) VALUES ('Domotique');
INSERT INTO Domaine (nom) VALUES ('Robotique');
INSERT INTO Domaine (nom) VALUES ('Intelligence Artificielle');
INSERT INTO Domaine (nom) VALUES ('Musique');
INSERT INTO Domaine (nom) VALUES ('Ingénieurie');
INSERT INTO Domaine (nom) VALUES ('Jeux-Vidéos');

INSERT INTO Sinteresser (domaine, personne) VALUES ('Informatique','Elisa.F');
INSERT INTO Sinteresser (domaine, personne) VALUES ('Domotique','Shell');

INSERT INTO Specialiser (domaine, entreprise) VALUES ('Ingénieurie','UTC');
INSERT INTO Specialiser (domaine, entreprise) VALUES ('Informatique','UTC');

-- Ajout des Liens

INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Robin.R','Shell','amis');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Robin.R','Shell','collegues');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Mez','Shell','amis');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Robin.R','Elisa.F','amis');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Robin.R','Mez','amis');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Shell','Elisa.F','collegues');
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ('Mez','Elisa.F','collegues');

-- Ajout des groupes de bases

INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Linux','Informations relatives au système d''exploitation open source Linux.',NULL,FALSE);
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Microsoft','Informations relatives aux outils gérés par la boîte Microsoft',NULL,FALSE); 
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Windows','Informations relatives aux système d''exploitation Windows','Microsoft',TRUE);
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Apple','Informations relatives aux outils gérés par la boîte Apple',NULL,FALSE); 
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('MacOS','Informations relatives au système d''exploitation MacOS','Apple',TRUE);
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('iOS','Informations relatives au système d''exploitation mobile iOS','Apple',TRUE);
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Android','Informations relatives au système d''exploitation mobile Android',NULL,FALSE); 
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ('Ubuntu','News et infos concernant la distribution Ubuntu sous Linux','Linux',TRUE); 

-- Ajout des appartenances aux groupes

INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Linux','robinrosseeuw.rr@gmail.com');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Linux','valentin.chelle@etu.utc.fr');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Linux','theo.chevalier@etu.utc.fr');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Windows','robinrosseeuw.rr@gmail.com');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('iOS','robinrosseeuw.rr@gmail.com');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Ubuntu','robinrosseeuw.rr@gmail.com');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Ubuntu','elisa.finzy@etu.utc.fr');
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ('Ubuntu','valentin.chelle@etu.utc.fr');
INSERT INTO RejoindreGroupe VALUES ('Windows','contact@utc.fr');
INSERT INTO RejoindreGroupe VALUES ('Apple','contact@utc.fr');
-- Ajout de messages & Fichiers & dossiers de bases

/* Bienvenue */
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Linux','2010-02-02 00:00:00','Bienvenue sur le groupe Linux ! Discutez ici de vos dernières trouvailles','robinrosseeuw.rr@gmail.com');
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Windows','2010-02-02 00:00:00','Bienvenue sur le groupe Windows ! Discutez ici de vos dernières trouvailles','robinrosseeuw.rr@gmail.com');
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Ubuntu','2010-02-02 00:00:00','Bienvenue sur le groupe Ubuntu ! Discutez ici de vos dernières trouvailles','valentin.chelle@etu.utc.fr');

/* Messages */
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Ubuntu','2010-02-02 00:00:10','La nouvelle version d''Ubuntu va bientôt sortir ! Voir plus d''informations sur le lien suivant','robinrosseeuw.rr@gmail.com');
INSERT INTO Fichier (nom,message,groupe,contenu) VALUES ('https://www.omgubuntu.co.uk/2019/03/download-ubuntu-19-04-beta-iso',4,'Ubuntu','https://www.omgubuntu.co.uk/2019/03/download-ubuntu-19-04-beta-iso');
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Apple','2011-03-27 16:25:21', 'Quelqu''un peut me renseigner sur la firme de la pomme?','contact@utc.fr') ;
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ('Windows','2011-02-27 19:04:37', 'Je n''arrive pas à faire la dernière mise à jour, est-ce-normal ?','contact@utc.fr') ;

/* Dossiers */
INSERT INTO Dossier (nom, utilisateur) VALUES ('Messages de bienvenue','robinrosseeuw.rr@gmail.com');
INSERT INTO DossierContient (message, groupe, nomDossier ,mail) VALUES (1,'Linux','Messages de bienvenue','robinrosseeuw.rr@gmail.com');
INSERT INTO DossierContient (message, groupe, nomDossier ,mail) VALUES (2,'Windows','Messages de bienvenue','robinrosseeuw.rr@gmail.com');

INSERT INTO Dossier (nom, utilisateur) VALUES ('Messages de bienvenue','valentin.chelle@etu.utc.fr');
INSERT INTO DossierContient (message, groupe, nomDossier ,mail) VALUES (3,'Ubuntu','Messages de bienvenue','valentin.chelle@etu.utc.fr');



/* 
* NOTES:
* - Pour mettre un ' dans une chaîne, il suffit de la doubler et mettre '' !
* - format DATE : AAAA-MM-JJ // format TIMESTAMP: 'YYYY-MM-DD HH:MI:SS' (avec minutes)
* - NOW() permet de récuperer la date du jour
*/