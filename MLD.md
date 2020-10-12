# MLD

- **Utilisateur** (#mail : VARCHAR(50), resume : VARCHAR(500), dateInscription : date, nationalite : CHAR(2), lien_photo : TEXT)  
*dateInscription, nationalite NOT NULL*  
*PROJECTION(Utilisateur, mail) = PROJECTION(Personne, mail) UNION PROJECTION(Entreprise, mail)*  

- **Personne** (#mail => Utilisateur, pseudo : VARCHAR(30), nom : VARCHAR(50), prenom : VARCHAR(50), dateNaiss : date, sexe : CHAR(1), employeur : VARCHAR(50))  
*nom, prenom, dateNaiss, sexe NOT NULL*
*pseudo KEY*  
*(sexe = 'H') OR (sexe='F') OR (sexe='A')*
  - **vPersonne** = JOINTURE(Utilisateur, Personne, Utilisateur.mail = Personne.mail)  

- **Entreprise** (#mail => Utilisateur, raisonSociale : VARCHAR(50), adresse : VARCHAR(500), dateCreation : date, siteWeb : VARCHAR(50), categorie : CHAR(3))  
*adresse, dateCreation NOT NULL*
*raisonSociale KEY*  
*(categorie = 'MIC') OR (categorie = 'PME') OR (categorie = 'ETI') OR (categorie = 'GE')*  
  - **vEntreprise** = JOINTURE(Utilisateur, Entreprise, Utilisateur.mail = Entreprise.mail)  

- **Lien** (#pseudoP1 => Personne(pseudo), #pseudoP2 => Personne(pseudo), #relation : VARCHAR)  
*(pseudoP1 != pseudoP2)*  
*(type = 'amis') OR (type = 'collegues') OR (type ='connaissances')*  

- **Formation** (#nom : VARCHAR(100)) 

- **Former** (#formation => Formation, #personne => Personne(pseudo), debut : date, fin : date)  
*PROJECTION(Personne, pseudo) = PROJECTION(Former, pseudo)*  
*debut, fin NOT NULL*

- **Competence** (#nom : VARCHAR(50)) 

- **AvoirCompetence** (#competence => Competence, #personne => Personne(pseudo))  
*PROJECTION(Personne, pseudo) = PROJECTION(AvoirCompetence, pseudo)*  

- **Diplome** (#intitule : VARCHAR(200))

- **AvoirDiplome** (#diplome => Diplome, #pseudo => Personne(pseudo))  
*PROJECTION(Personne, pseudo) = PROJECTION(AvoirDiplome, pseudo)*  

- **Message** (#id : BIGSERIAL, #groupe => Groupe, datePublication : timestamp, contenu : VARCHAR(8000), utilisateur =>Utilisateur)  
*datePublication, contenu, utilisateur NOT NULL* 
*PROJECTION(Message,groupe,utilisateur) ⊆ RejoindreGroupe*

- **Fichier** (#nom : VARCHAR(100), #message => Message(id), #groupe => Message(groupe), lien_fichier : TEXT)  
*lien_fichier NOT NULL*

- **Dossier** (#nom : VARCHAR(100), #utilisateur => Utilisateur) 

- **Groupe** (#theme : VARCHAR(30), description : VARCHAR(500), groupeParent => Groupe, estSousGroupe BOOL)  
*description NOT NULL*
*(estSousGroupe = FALSE AND groupeParent NULL) OR (estSousGroupe = TRUE and groupeParent NOT NULL)*
*PROJECTION(RESTRICTION(Groupe, estSousGroupe = TRUE), groupeParent) ⊆ PROJECTION(RESTRICTION(Groupe, estSousGroupe = FALSE), theme)*  
  - **vGroupe** = RESTRICTION(Groupe, estSousGroupe = FALSE)
  - **vSousGroupe** = RESTRICTION(Groupe, estSousGroupe = TRUE)

- **Domaine** (#nom : VARCHAR(50))  

- **Specialiser** (#domaine => Domaine, #entreprise=> Entreprise(raisonSociale))  
*PROJECTION(Entreprise, raisonSociale) = PROJECTION(Specialiser, entreprise)*  

- **Sinteresser** (#personne => Personne(pseudo), #domaine => Domaine) 

- **RejoindreGroupe** (#groupe => Groupe, #utilisateur => Utilisateur) 

- **DossierContient** (#message => Message(id), #groupe => Message(groupe), #nomDossier => Dossier(nom), #mail => Dossier(mail))  

## NOTES :

- Les id sont pour l'instant des SERIAL et BIGSERIAL, mais cela risque de changer.  
- Les photos des utilisateurs et les fichiers des messages sont stockées directement sur le serveur. Un lien vers ce fichier est établi par les champs *lien_photo* et *lien_fichier*.
- Les contraintes de projection et de restriction dues aux cardinalités ne peuvent être appliquées dans les CREATE TABLE en SQL.
- Les vues *CompterEffectif()* et *CompterNbMessage()* ne peuvent être exprimées en relationnel, car on a besoin d'outils comme *COUNT()* et *GROUP BY*,  mais peuvent l'être en SQL.
- Lorsque l'on supprime un groupe, qui a des groupes fils, chaque groupe fils devient alors un groupe parent.