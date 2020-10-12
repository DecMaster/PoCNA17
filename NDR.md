# 15/03/2019

- Création de **Utilisateur** et **Entreprise**, en plus de **Personne**.  
Les caractéristiques initiales ont été réparties dans ces trois catégories. D'autres ont été ajoutées.
- L'*adresse mail* est maintenant l'identifiant unique, le *login* est supprimé.
- Ajout de la date d'inscription dans **Utilisateur**.
- Ajout du pseudo dans **Personne**.
- *compétences*, *formations* et *domaines* sont maintenant indépendants.
- Ajout des mails des 2 personnes concernées dans un **Lien typé**.
- Ajout d'un identifiant unique pour chaque **Message**.
- Ajout de **Fichier** qui contient les caractéristiques *nom*, *identifiant*, *contenu*. Il regroupe les anciennes différentes catégories *Vidéo*, *Photo* etc.

# 22/03/2019

- Modification du MCD
    - Suppression de *mail_p1* et *mail_p2* de **Lien**.
    - Ajout d'une contrainte en conséquence sur les **liens**.
    - Suppression de l'association **Dossier** -- **Groupe**.
    - Modification des associations :
        - C'est maintenant **Utilisateur** qui appartient a un **Groupe**, qui écrit un **Message**, qui possède un **Dossier**.
    - *entreprise* devient *employeur*
    - Les pays sont codés sur 2 caractères (norme ISO 3166).
    - Le *sexe* est codée sur une énumération.

- Modification de la NDC
    - Modification en conséquence des phrases.
    - Changement de *avatar* en *photo*.
    - Clarification sur le *pseudo* et les attributs d'**Utilisateur**.

# 29/03/2019
- Modification de la NDC
    - Précision sur **Diplôme**.

- Modification du MCD
    - Transformation de l'attribut **Diplôme** en classe, pour l'atomicité:
      - Ajout d'un attribut intitulé.
    - Ajout d'une composition entre **Message** et **Fichier**
    - Suppression de l'id dans **Fichier**, le *nom* devient clé locale
    - Ajout d'une agrégation entre **Groupe** et **sousGroupe**.
    - Ajout d'une composition entre **Groupe** et **Message**.
    - Modification des cardinalités entre **Personne** et **Formation**, et **Personne** et **Compétence**.
    - Déplacement de *nom* de **Utilisateur** à **Personne**.
    - Ajout de *raisonSociale* comme clé candidate pour **Entreprise**.
    - Changement de certaines {key} en {local key}.
    - Ajout de stéréotypes d'énumérations
    - Les attriuts *nbMessages* et *effectifs* disparaissent : ce sont des vues

- Modification du MLD
    - Remplacement de *mail* par *pseudo* dans la relation **Lien**, **Sinteresser**.
    - Ajout de la relation **AvoirDiplome**.
    - Ajout de contraintes sur **Former**, **AvoirCompetence** et **AvoirDiplome**.
    - **sousGroupe** fusionne avec **Groupe**, afin de simplifier et respecter plus facilement les contraintes.
    - Le CHAR(1) *type* de la classe **Groupe** devient le booléen *estSousGroupe*
    - Les types binaires disparaissent au profit de liens
    - Les attriuts *nbMessages* et *effectifs* disparaissent : ce sont des vues
    - Ajout des vues
    - Ajout d'une note sur la suppression d 'un groupe

- Ajout du script SQL de création des tables *creation_tables.sql*
- Ajout du script SQL d'insertion de données *insertion_donnes.sql*

# 10/04/2019

- Modification du MCD
    - le type énuméré relation devient affinité.
    - l'attribut type de **Lien** devient relation de type affinité

- Modification du MLD
    - type devient relation dans la relation Lien

- Modification de creation_tables.sql
    - ajout des vues dynamiques
    
- Création de **visualiser_donnes.sql**

# 03/05/2019

- Modification de l'organisation des fichiers SQL
- Suppression du dossier *images* inutile.
- Ajout de la PoC MongoDB

# 09/05/2019

- Correction de la création de table: Rajout de la clé locale "relation" dans la clé primaire de la table "Lien", afin que plusieurs personnes puissent entretenir plusieurs liens entre elles.
- Ajout de la PoC Neo4j