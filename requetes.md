# Creation Personne
*Requête servant à créer une Personne à partir des données saisies par l'utilisateur à travers différentes zones de textes correspondant à chaque attribut attendu*  
```sql
INSERT INTO Personne (mail,pseudo,nom,prenom,dateNaiss,genre,employeur) VALUES ([mail],[pseudo],[nom],[prenom],[dateNaiss],[genre],[employeur]); 
```

# Creation Entreprise
*Requête servant à créer une Entreprise à partir des données saisies par l'utilisateur à travers différentes zones de textes correspondant à chaque attribut attendu*  
```sql
INSERT INTO Entreprise (mail,raisonSociale,adresse,dateCreation,siteWeb,categorie) VALUES ([mail],[raisonSociale],[adresse],[dateCreation],[siteWeb],[categorie]); 
```

# Ajouter Competence
*Permet de creer une nouvelle compétence dans la BD à partir d'une chaîne de caractère saisie par l'utilisateur*  
```sql
INSERT INTO Competence (nom) VALUES ([nom]);
```

# Lier Competence
*Permet de lier une compétence à une personne en particulier en saisissant le nom du diplome et le pseudo, existant déjà dans la BD*  
```sql
INSERT INTO AvoirCompetence (competence, personne) VALUES ([competence],[personne]);
```

# Ajouter Formation
*Permet de creer une nouvelle formation dans la BD à partir d'une chaîne de caractère saisie par l'utilisateur*  
```sql
INSERT INTO Formation (nom) VALUES ([nom]);
```

# Lier Formation
*Permet de lier une formation à une personne en particulier en saisissant le nom du diplome et le pseudo, existant déjà dans la BD*  
```sql
INSERT INTO Former (debut, fin, formation, personne) VALUES ([debut],[fin],[formation],[pseudo]);
```

# Ajouter Domaine
*Permet de creer un nouveau domaine dans la BD à partir d'une chaîne de caractère saisie par l'utilisateur*  
```sql
INSERT INTO Domaine (nom) VALUES ([nom]);
```

# Lier Domaine-Personne
*Permet de lier un domaine à une personne en particulier en saisissant le nom du diplome et le pseudo, existant déjà dans la BD*  
```sql
INSERT INTO Sinteresser (domaine, personne) VALUES ([domaine],[personne]);
```

# Lier Domaine-Entreprise
*Permet de lier un domaine à une entreprise en particulier en saisissant le nom du diplome et le pseudo, existant déjà dans la BD*  
```sql
INSERT INTO Specialiser (domaine, entreprise) VALUES ([domaine],[entreprise]);
```

# Ajouter Diplome
*Permet de creer un nouveau diplome dans la BD à partir d'une chaîne de caractère saisie par l'utilisateur*  
```sql
INSERT INTO Diplome (intitule) VALUES ([intitule]);
```

# Lier Diplome
*Permet de lier un diplome à une personne en particulier en saisissant le nom du diplome et le pseudo, existant déjà dans la BD*  
```sql
INSERT INTO AvoirDiplome (diplome, pseudo) VALUES ([diplome],[pseudo]);
```

# Ajouter Lien
*Permet des créer des liens entre des personnes à partir des pseudos des deux personnes concernées en mettant aussi le type de relation*  
```sql
INSERT INTO Lien (pseudoP1, pseudoP2, relation) VALUES ([pseudoP1],[pseudoP2],[relation]);
```

# Ajouter Groupe
*Permet d'ajouter des groupes en renseignant le thème, la description du groupe, et le type de groupe (groupe parent, sous-groupe ou rien)*  
```sql
INSERT INTO Groupe (theme,description,groupeParent,estSousGroupe) VALUES ([theme],[description],[groupeParent],[estSousGroupe]);
```

# Rejoindre Groupe
*Permet d'assosier des utilisateurs à des groupes*
```sql
INSERT INTO RejoindreGroupe (groupe,utilisateur) VALUES ([groupe],[utilisateur]);
```

# Poster Message & Fichier
*Permet d'ajouter des messages dans un groupe*  
```sql
INSERT INTO Message (groupe, datePublication, contenu, utilisateur) VALUES ([groupe],[datePublication],[contenu],[utilisateur]);
```

*Lorsqu'un fichier doit être ajouté à un message, on effectue également la commande suivante:*  
```sql
INSERT INTO Fichier (nom,message,groupe,contenu) VALUES ([nom],[message],[groupe],[contenu]);
```

# Creer Dossier
*Permer de créer des dossiers à partir d'un nom de dossier saisi par l'utilisateur*  
```sql
INSERT INTO Dossier (nom, utilisateur) VALUES ([nom],[utilisateur]);
```

# Remplir dossier
*Permet d'ajouter des messages et des groupes à un dossier*  
```sql
INSERT INTO DossierContient (message, groupe, nomDossier ,mail) VALUES ([idMessage],[groupe],[nomDossier],[mailUtilisateur]);
```

-- Notes --
- N'ayant pas encore l'implémentation en PHP à réaliser, nous avons décidé de nous inspirer du devoir de la semaine du TD6 (lien ici: https://librecours.net/exercice/opt1-devoir_a/optUE10.xhtml?part=jg) qui écrit les ENTREES de la requêtes entre crochets (ex: [Nom] est le Nom saisie en entrée de la requête)