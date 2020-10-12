# NA17

Ce repository contient les différents fichiers nécessaires au projet de NA17 sur le réseau social de veille technologique.

Les contributeurs sont **ROSSEEUW Robin**, **CHEVALIER Théo**, **FINZY Elisa** et **CHELLE Valentin**

Les différents fichiers seront ajoutés au fur et à mesure du projet. Chaque élément est un lien cliquable.

## Projet

Cette catégorie concerne la conception sur PostgreSQL du projet.

- la [**NDC**](https://gitlab.utc.fr/chelleva/na17/blob/master/NDC.md)
- la [**NDR**](https://gitlab.utc.fr/chelleva/na17/blob/master/NDR.md)

- le MCD
  - Code source en plantUML : [**MCD.plantuml**](https://gitlab.utc.fr/chelleva/na17/blob/master/MCD.plantuml)
  - PNG compilé à la main : [**MCD.png**](https://gitlab.utc.fr/chelleva/na17/blob/master/MCD.png)

- le [**MLD**](https://gitlab.utc.fr/chelleva/na17/blob/master/MLD.md)

- les fichiers SQL (à exécuter dans l'ordre):
  - Script qui créé toutes les tables, et les vues de contrôles : [**creation_tables.sql**](https://gitlab.utc.fr/chelleva/na17/blob/master/SQL/creation_tables.sql)
  - Script qui insère des données de tests dans les tables : [**insertion_donnees.sql**](https://gitlab.utc.fr/chelleva/na17/blob/master/SQL/insertion_donnees.sql)
  - Script qui exécute différentes requêtes en interrogeant la base de données.  
   Il affiche également le contenu des vues de contrôle, des vues fonctionnelles (créés à l'intérieur du script), et des attributs calculés dynamiquent: [**requetes.sql**](https://gitlab.utc.fr/chelleva/na17/blob/master/SQL/requetes.sql)
  
- Sommaire des requêtes modèles : [**requetes.md**](https://gitlab.utc.fr/chelleva/na17/blob/master/requetes.md)
- Preuve de normalisation 3NF : [**preuve_normalisation.md**](https://gitlab.utc.fr/chelleva/na17/blob/master/preuve_normalisation.md)

### PoCs

Cette catégorie répertorie les livrables des PoC.
Le répertoire contenant toutes les PoC est ici : [**PoC**](https://gitlab.utc.fr/chelleva/na17/tree/master/PoCs)

- [**MongoDB**](https://gitlab.utc.fr/chelleva/na17/blob/master/PoCs/MongoDB/PoC.md)
- [**Neo4j**](https://gitlab.utc.fr/chelleva/na17/blob/master/PoCs/Neo4j/PoC.md)
- [**RO v1**](https://gitlab.utc.fr/chelleva/na17/blob/master/PoCs/ROv1/PoC.md)
- [**RO v2**](https://gitlab.utc.fr/chelleva/na17/blob/master/PoCs/ROv2/PoC.md)