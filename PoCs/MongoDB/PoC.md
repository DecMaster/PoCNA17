# PoC MongoDB

## Introduction

Le but de cette Preuve de Concept (POC) est de démontrer la possibilité d'adapter une partie de notre projet en utilisant la technologie MongoDB.
Pour cela, nous allons travailler sur notre UML afin de l'adapter à une base de données orientée document.

La force du non-relationnel réside dans le stockage et l'accès aux données. Sans opérations de jointure, agrégation, etc., l'accès aux données est très rapide.
Dans la pratique, on oubliera donc avec MongoDB les associations, héritages, et les clés.
Ces concepts devront être adaptés autrement en MongoDB voire ne peuvent tout simplement pas être réalisés. Il faudra alors les gérer au niveau applicatif pour certains, comme les contraintes.

Un **Utilisateur** est donc caractérisé uniquement par ses propriétés propres, les **groupes** dans lesquels il a posté des **messages**, et enfin ces **messages**.

Dans cette PoC, nous avons choisi d'adapter un sous-ensemble de notre MCD relationnel, comprenant ***uniquement*** les :

- **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- **Entreprises**
- **Personnes**
- **Groupes**
- **Sous-Groupes**
- **Messages**

## Modèle Conceptuel de Données (MCD)

Ces informations sont représentées en UML ainsi:
![MCD](https://i.imgur.com/zPu4GbG.png)

Notre nouveau MCD comprend uniquement 5 classes :

- les **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- les **Entreprises**
- les **Personnes**
- les **Groupes**
- les **Messages**

Même s'il ne sera pas réalisé dans la pratique, nous avons fait le choix de conserver l'héritage dans le MCD afin de conserver la sémantique qu'il apporte entre les **Utilisateurs**.

Dans notre MCD, nous avons maintenant plusieurs compositions :

- Entre **Utilisateur** et **Groupe** : Chaque **Utilisateur** possède directement les **Groupes** dans lesquels il a posté au moins un message.
- Entre **Groupe** et **Message** : Chaque **Groupe** contient les **Messages** que l'**Utilisateur** a posté.
- Entre **Groupe** ... et **Groupe** : Chaque **Groupe** contient les **Groupes** dans lesquels l'**Utilisateur** a posté au moins un **Message**. Un **Groupe** composé par un autre **Groupe** est considéré comme étant un **Sous-Groupe**.

## Passage au noSQL (MongoDB)

L'héritage que l'on utilisait précédemment en relationnel afin de séparer les **Personnes** et les **Entreprises** n'existe plus au niveau applicatif (MongoDB). Les **Personnes** et les **Entreprises** se retrouveront au même endroit, dans la classe **Utilisateur**. On ne distinguera plus l'une de l'autre. On ne peut exprimer de contraintes d'exclusivités avec MongoDB. Si on les veut, il faudra les rajouter au niveau applicatif.

Les clés de notre MCD : *pseudo*, *raisonSociale*, et *mail* sont des clés définies dans notre cahier des charges. Elles ne seront cependant pas utilisées pour identifier les données lors de l'implémentation.

Au niveau MongoDB, les 3 classes de notre MCD sont fusionnées dans une même collection **utilisateur**. Ceci est possible grâce aux *compositions*, qui ont été explicitées dans la partie précédente.

Nous n'avons donc qu'une seule collection nommée **utilisateur**.

## Utilisation de notre base de données

Dans cette partie, nous effectuons 2 insertions dans la collection **utilisateur** afin de montrer l'utilisation de notre modèle.

1) Nous insérons ici une **personne**, avec un **message**, qu'elle a posté dans le **sous-groupe** *Ubuntu* :

    ``` js
    db.utilisateur.insertOne(
    {
        "mail": "valentin.chelle@etu.utc.fr",
        "pseudo": "Shell",
        "nom": "Chelle",
        "prenom": "Valentin",
        "dateNaiss": 1999,
        "dateInscription": 2019,
        "nationalite": "fr",
        "genre": {
            "homme": true,
            "femme": false,
            "autre": false
        },
        "employeur": "UTC",
        "groupes": [
            {
                "theme": "Linux",
                "description": "Informations relatives au système d''exploitation open source Linux",
                "messages": [],
                "groupes": [
                    {
                        "theme": "Ubuntu",
                        "description": "News et infos concernant la distribution Ubuntu sous Linux",
                        "messages": [
                            {
                                "datePublication": "2010-02-02 00:00:00",
                                "contenu": "Bienvenue sur le groupe Ubuntu ! Discutez ici de vos dernières trouvailles"
                            }
                        ],
                        "groupes": []
                    }
                ]
            }
        ]
    })
    ```

2) Nous insérons ici une **entreprise**, avec un **message**, dans les groupes **Apple** et **Windows**

    ``` js
    db.utilisateur.insertOne(
    {
        "mail": "contact@utc.fr",
        "raisonSociale": "UTC",
        "adresse": "Rue Roger Coutolenc, 60200 Compiègne",
        "dateCreation": 1972,
        "dateInscription": 2019,
        "nationalite": "fr",
        "siteWeb": "https://www.utc.fr/",
        "categorie": {
            "PME": false,
            "MIC": false,
            "ETI": false,
            "GE": false,
        },
        "groupes": [
            {
                "theme": "Apple",
                "description": "Informations relatives aux outils gérés par la boîte Apple",
                "messages": [
                    {
                        "datePublication": "2011-03-27 16:25:21",
                        "contenu": "Quelqu'un peut me renseigner sur la firme de la pomme ?"
                    }
                ],
                "groupes": []
            },
            {
                "theme": "Windows",
                "description": "Informations relatives aux système d''exploitation Windows",
                "messages": [
                    {
                        "datePublication": "2011-02-27 19:04:37",
                        "contenu": "Je n'arrive pas à faire la dernière mise à jour, est-ce-normal ?"
                    }
                ],
                "groupes": []
            }
        ]
    })
    ```
  
### Remarques

- La création de tables en SQL (CREATE TABLE) n'est pas à transcrire en MongoDB étant donné que la création de la collection se fait dynamiquement à l'insertion de la 1ère donnée dans cette dernière.
- Les contraintes de création de table ne sont pas adaptables en MongoDB. Il faut les réaliser au niveau applicatif.
- Ici il n'y a pas de collections de **groupe** ou de **message**, seulement d'**utilisateur**. Ainsi les **sous-groupes** sont représentés à l'intérieur des **groupes** et possèdent donc un élément "groupes" vide puisqu'un **sous-groupe** est un **groupe**. Puisqu'il n'y a pas de contraintes en MongoDB, on ne peut pas assurer que cet élément "groupes" reste vide.

## Exemples de requêtes fonctionnelles

### Affichage du nom et prénom de toutes les personnes

``` js
db.utilisateur.find({},{"nom":1, "prenom":1})
```

### Affichage de la raison sociale de toutes les entreprises

``` js
db.utilisateur.find({},{"raisonSociale":1})
```

On voit ici que l'on fait appel à une même collection pour les entreprises et personnes: "**utilisateur**". Or avec MongoDB les données d'une même collection n'ayant pas forcément les mêmes propriétés (Mongo étant Schéma-Less), changer les noms des propriétés à afficher dans le find() suffit à afficher des documents faisant référence à des personnes (ayant les propriétés "nom" et "prénom") ou à des documents faisant références à des entreprises (ayant la propriété "raisonSociale").

### Affichage de tous les utilisateurs

``` js
db.utilisateur.find({},{"nom":1, "prenom":1, "raisonSociale":1})
```

On note que dans l'affichage de tous les utilisateurs, seules les propriétés valides pour un document sont affichées, alors qu'une jointure entre les relations Personne et Entreprise en SQL relationnel pour afficher tous les Utilisateurs auraient entraîné l'affichage de bon nombre de valeurs NULL.

### Affichage du thème des groupes auxquels appartient Shell

``` js
db.utilisateur.find({"pseudo":"Shell"},{"groupes.theme":1, "groupes.groupes.theme" : 1})
```

### Affichage des utilisateurs ayant pour nom "Chelle" ou pour raison sociale "UTC" *(OR)*

``` js
db.utilisateur.find({$or: [{"nom":"Chelle"},{"raisonSociale":"UTC"}]},{"nom":1, "prenom":1, "raisonSociale":1})
```

### Affichage du contenu des messages postés par l'utilisateur ayant pour prénom "Valentin" et nom "Chelle" *(AND)*

``` js
 db.utilisateur.find({"nom":"Chelle", "prenom":"Valentin"},{"groupes.messages.contenu":1, "groupes.messages.datePublication":1, "groupes.groupes.messages.contenu" : 1, "groupes.groupes.messages.datePublication" : 1})
```

### Compter le nombre d'utilisateurs de la BDD *(COUNT)*

``` js
db.utilisateur.count()
```

### Afficher les messages postés par les utilisateurs ayant une adresse terminant par "utc.fr" *(LIKE)*

``` js
db.utilisateur.find({"mail": { $regex: /utc.fr$/} },{"groupes.messages.contenu":1, "groupes.messages.datePublication":1,"groupes.groupes.messages.contenu" : 1, "groupes.groupes.messages.datePublication" : 1 })
```

On voit ici que l'on peut poser des conditions plus complexes en terme de restriction, comme des *OR*, *AND*, *LIKE*... permettant de transcrire bon nombre de requêtes SQL avec MongoDB également.

## Conséquences de l'implémentation MongoDB

L'adaptation de notre projet avec MongoDB ainsi que l'exécution de certaines requêtes fait émerger plusieurs avantages et limites de MongoDB par rapport à notre code précédent en SQL relationnel :

### Avantages

- Le passage à MongoDB, à présent plus concentré sur le stockage et la recherche des données, permet d'effectuer ces opérations plus facilement puisque la plupart des informations sont regroupées dans une même collection. Ainsi, lors de requêtes et de recherches de données, on évite les jointures auparavant employées dans le relationnel, qui étaient assez coûteuses.
- Le passage à MongoDB est beaucoup plus permissif, cela permet aux applications qui vont l'utiliser de retenir ce qu'elles veulent. On peut donc l'utiliser dans plusieurs cas et pas seulement dans un cas spécifique.
- MongoDB permet de modifier les collections de manière très simple en raison de sa flexibilité : il est possible de modifier facilement la structure en ajoutant des propriétés. Chaque document peut avoir une structure différente au sein d'une même collection.

### Désavantages

- On ne peut plus exprimer la plupart de nos contraintes d'intégrité en NoSQL (Mongo), ce qui signifie par exemple que des données habituellement NOT NULL et donc obligatoirement saisies peuvent être non présentes dans nos documents sans que cela pose problème à Mongo. Les contraintes d'arités, et d'héritage ne sont pas non plus applicables avec MongoDB. Il est à noter toutefois que les contraintes d'intégrité peuvent être appliqués par les couches applicatives qui utiliseront ensuite les données de la BDD MongoDB (API, Applications...etc). Cependant, gérer les contraintes de manière applicative peut vite se retrouver bien plus complexe que de les gérer au niveau d'une BDD relationnelle. Il s'agit alors de déterminer les besoins que l'on a, et de privilégier, d'un côté l'intégrité pour le relationnel, ou les performances pour MongoDB. Dans notre projet, il y a un grand nombre de contraintes, il n'est pas forcément judicieux d'utiliser MongoDB à cet effet.
- Notre base de données comporte de la redondance au niveau des groupes. En effet, on retrouve dans la structure de chaque utilisateur le thème et la description des groupes dans lesquels l'utilisateur a posté un message. Les informations d'un groupe sont donc répliqué dans chaque utilisateur qui a posté un message à l'intérieur de celui-ci. 
Une voie d'amélioration potentielle serait, pour chaque message posté, l'usage de références sur le groupe concerné. Il faudrait alors une autre collection comprenant les groupes. On éliminerait la redondance, mais on diminuerait le temps de recherche d'informations sur l'utilisateur. On favorise ici la vitesse d'exécution au détriment de la redondance, et nous n'utilisons donc pas les références.

## Conclusion

MongoDB est utilisé pour réaliser des bases de données non-relationnelles. Il est beaucoup plus permissif que les bases de données SQL, étant donné qu'aucune contrainte d'intégrité n'est affectable aux documents des collections, permettant ainsi par exemple le regroupement des relations SQL "**Personnes**" et "**Entreprise**" au sein d'une même collection "**Utilisateur**". Nous avons également affecté à ces entités des **groupes** et **messages**, qui étaient des relations à part entières dans notre code SQL, ici au sein d'une même collection. Là est tout le but de MongoDB : centraliser les informations au sein d'une même collection à travers différents documents dont les propriétés peuvent varier, au lieu de faire des références entre plusieurs collections.
On peut donc bien adapter notre projet afin de trouver une solution orientée document.
Néanmoins cette adaptation n'est pas une transcription totale étant donné que les contraintes d'intégrité ne pourront être respectées, ce qui est certes une limite de MongoDB que nous n'avions pourtant pas en SQL.
Enfin, on a bien cette idée de commerce de caractéristiques puisqu'on a perdu de la cohérence en supprimant certaines contraintes, mais on a gagné en performance puisque l'interrogation de la base de données et la recherche de données s'effectuent plus facilement et de manière plus rapide (notamment en évitant les opérations de jointure).
