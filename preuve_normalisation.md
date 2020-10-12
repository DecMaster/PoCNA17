# Etape 1: Enumération des dépendances fonctionnelles
- **Utilisateur**
    - mail → resume,dateInscription,narionalite,photo
- **Personne**
    - mail → pseudo,nom,prenom,dateNaiss,genre,employeur
    - pseudo → mail,nom,prenom,dateNaiss,genre,employeur
- **Entreprise**
    - mail → raisonSociale,adresse,dateCreation,siteWeb,categorie
    - raisonSociale →mail,adresse,dateCreation,siteWeb,categorie
- **Lien**
    - (pseudoP1,pseudoP2) → relation
- **Formation**
    - Relation toute clé
- **Former**
    - (formation,personne) → debut, fin
- **Competence**
    - Relation toute clé
- **AvoirCompetence**
    - Relation toute clé   
- **Diplome**
    - Relation toute clé
- **AvoirDiplome**
    - Relation toute clé
- **Groupe**
    - theme → description,groupeParent,estSousGroupe
- **Message**
    - (id,groupe) → datePublication,contenu,utilisateur
- **Fichier**
    - (nom,message,groupe) → contenu
- **Dossier**
    - Relation toute clé
- **Domaine**
    - Relation toute clé
- **Specialiser**
    - Relation toute clé
- **Sinteresser**
    - Relation toute clé
- **RejoindreGroupe**
    - Relation toute clé
- **DossierContient**
    - Relation toute clé

# Etape 2: 1NF
- Utilisateur a pour clé mail
- Personne a pour clés mail et pseudo
- Entreprise a pour clés mail et raisonSociale
- Lien a pour clé (pseudop1, pseudoP2)
- Formation a pour clé nom
- Former a pour clé (formation, personne)
- Competence a pour clé nom
- AvoirCompetence a pour clé (competence, personne)
- Diplome a pour clé intitule
- AvoirDiplome a pour clé (diplome, pseudo)
- Groupe a pour clé theme
- Message a pour clé (id, groupe)
- Fichier a pour clé (nom, message, groupe)
- Dossier a pour clé (nom, utilisateur)
- Domaine a pour clé nom
- Specialiser a pour clé (domaine, entreprise)
- Sinteresse a pour clé (personne, domaine)
- RejoindreGroupe a pour clé (groupe, utilisateur)
- DossierContient a pour clé (message, groupe, nomDossier, mail)

Toutes nos relations ont donc une clé, et tous leurs attributs sont atomiques, c'est à dire qu'ils ne contiennet qu'une seule valeur pour un tuple donné.
Notre modèle est donc au moins **1NF**.

# Etape 3: 2NF
Tout attribut n'appartenant à aucune clé candidate ne dépend directement que de clés candidates, étant donné que toutes nos relations sont de la forme K→A où K est une clé et A un attribut quelconque.

# Etape 4: BCNF/3NF

On remarque que toutes les dépendances fonctionnelles de notre modèle sont de la forme K→A où K est une clé et A un attribut quelconque, vu que chaque attribut de nos relations sont définis par la clé primaire ou candidate de cette même relation.
Ainsi vu que notre modèle est déjà en 2NF, on en déduit que notre modèle est bien en BCNF, et donc par définition en 3NF.