# PoC Neo4j

## Introduction

Le but de cette Preuve de Concept (POC) est de démontrer la possibilité d'adapter une partie de notre projet en utilisant la technologie Neo4J.
Pour cela, nous allons travailler sur notre UML afin de l'adapter à une base de donéees orientée graphe. Nous utiliserons le même exemple que dans la précédente **PoC** sur **MongoDB**.

La force du non-relationnel réside dans le stockage et l'accès aux données, arborant un modèle dit *schéma-less*.
Sans opérations de jointure, agrégation, etc., l'accès aux données est très rapide.
Ces concepts devront être adaptés autrement en Neo4J voire ne peuvent tout simplement pas être réalisés. Il faudra alors les gérer au niveau applicatif pour certains, comme les contraintes.

Un **Utilisateur** est donc caractérisé uniquement par ses propriétés propres, les **groupes** dans lesquels il a posté des **messages**, et les **liens** qu'il entretient avec d'autres personnes.

Dans cette PoC, nous avons choisi d'adapter un sous-ensemble de notre MCD relationnel, comprenant ***uniquement*** les :

- **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- **Entreprises**
- **Personnes**
- **Groupes**
- **Sous-Groupes**
- **Messages**
- **Liens**

## Modèle Conceptuel de Données (MCD)

Ces informations sont représentées en UML ainsi:
![MCD](https://i.imgur.com/YOYNS4G.png)

Notre nouveau MCD comprend uniquement 6 classes :

- les **Utilisateurs** (soit **Entreprise**, soit **Personne**)
- les **Entreprises**
- les **Personnes**
- les **Groupes**
- les **Messages**
- les **Liens**

Même s'il ne sera pas réalisé dans la pratique, nous avons fait le choix de conserver l'héritage dans le MCD afin de conserver la sémantique qu'il apporte entre les **Utilisateurs**.

Nous avons dû faire plusieurs modifications dans notre UML :

- **Message** et **Lien** sont maintenant des classes d'associations, étant donnés que leurs données seront stockées au sein des relations entre plusieurs noeuds en Neo4J:
    - Entre **Groupe** et **Personne** ou **Entreprise** pour les **Messages**
    - Entre 2 noeuds de type **Personne** pour les **Liens**

## Passage au noSQL (Neo4J)

Neo4J est un stockage des données permettant une représentation de ces données et de leur associations sous forme de graphe. Nous devons donc raisonner afin d'obtenir une représentation graphique optimale afin de faire apparaître clairement les relations entre chaque élément de la base de données.

Les noeuds représenteront alors les classes principales de notre MCD, à savoir **Personne**, **Entreprise** et **Groupe**. Les relations entre les noeuds serviront à représenter les éléments suivants:

- Les **Messages** à travers la relation dont le type est **MESSAGE** entre Groupe et Personne OU entre Groupe et Entreprise.
- Les **Liens** à travers la relation dont le type est **LIEN** entre 2 Personnes
- La parenté entre 2 groupe à travers la relation **parent** entre 2 Groupes

Par exemple, on aura alors autant de relations entre un groupe et une personne que de messages postés par cette dernière sur ce groupe.

En conclusion: Chaque classe de notre MCD représente un type noeud, et chaque classe d'association représente un type de relation en Neo4J.


## Utilisation de notre base de données

Dans cette partie, nous effectuons 2 insertions dans la collection **utilisateur** afin de montrer l'utilisation de notre modèle.

1) Nous insérons ici une **personne**, avec un **message**, qu'elle a posté dans le **sous-groupe** *Ubuntu* :
2) 
``` js

// Creation des groupes

create(linux:groupe {name : 'Linux', description : 'Informations relatives au système d\'exploitation open source Linux.'})

create(ubuntu:groupe {name : 'Ubuntu', description : 'News et infos concernant la distribution Ubuntu sous Linux'})

// Creation de l'entreprise

create(UTC:entreprise {mail : 'contact@utc.fr', resume : 'Universite de Technologie de Compiegne', dateInscription : '2010-07-09', nationalite : 'FR', photo : 'https://www.utc.fr/fileadmin/user_upload/SITE-UTC/images/Home/Logotheque/SU-UTC18-70.jpg', name : 'UTC', adresse : 'Rue Roger Coutolenc, 60200 Compiègne', dateCreation : '1972-01-01', siteweb : 'https://www.utc.fr/'})

// Creation des personnes

create(Shell:personne {mail : 'valentin.chelle@etu.utc.fr', resume : 'Etudiant à l\'Universite de Technologie de Compiegne', dateInscription : '2017-03-04', nationalite : 'FR', name : 'Shell', nom : 'Chelle', prenom : 'Valentin', dateNaiss : '1999-03-24', genre : 'Homme', employeur : 'UTC'})

create(RobinR:personne {mail : 'robinrosseeuw.rr@gmail.com', resume : 'Etudiant à l\'Universite de Technologie de Compiegne', dateInscription : '2016-01-01', nationalite : 'FR', name : 'RobinR', nom : 'Rosseeuw', prenom : 'Robin', dateNaiss : '1998-02-26', genre : 'Homme', employeur : 'UTC'})

// Creation des relations

create(RobinR)-[:MESSAGE {datePublication : '2018-02-02 17:36:07', contenu : 'Bienvenue sur le groupe Linux ! Discutez ici de vos dernières trouvailles'}]->(linux)
create(Shell)-[:MESSAGE {datePublication : '2019-02-08 09:15:57', contenu : 'Bienvenue sur le groupe Ubuntu ! Discutez ici de vos dernières trouvailles'}]->(ubuntu)
create(UTC)-[:MESSAGE {datePublication : '2017-10-03 13:56:30', contenu : 'La nouvelle version d\'Ubuntu va bientôt sortir ! Voir plus d\'informations sur le lien suivant'}]->(ubuntu)

create(RobinR) -[:LIEN {type:'amis'}]-> (Shell)

create(ubuntu) <-[:PARENT]-(linux)
```
  
### Remarques sur l'implémentation:

- Il faut exécuter tout ce code dans la même commande, car nous n'utilisons pas ici de référence.
- On doit faire figurer une propriété "name" dans les noeuds afin que ce nom s'affiche sur les noeuds lors de la représentation graphique. Les anciennes propriétés "pseudo", "raisonSociale" et "theme" deviennent alors "name" dans leur noeud respectif.
- héritage par classe fille

## Exemples de requêtes fonctionnelles

### Affichage de tous les utilisateurs

``` js
match (n:personne),(m:entreprise)
return n, m
```

### Affichage de toutes les personnes

``` js
match (n:personne) return n
```

### Affichage de toutes les entreprises

``` js
match (n:entreprise) return n
```

### Affichage de tous les groupes

``` js
match (n:groupe) return n
```

### Affichage du nom et prénom de toutes les personnes

``` js
match (n:personne) return n.nom, n.prenom
```

### Affichage de la raison sociale de toutes les entreprises

``` js
match (n:entreprise) return n.name
```

### Afficher toutes les personnes ayant une relation d'affinité avec Shell

``` neo4j
match (n:personne {name:'Shell'}) <-[l:LIEN]- (n2) return n2 
```

### Afficher toutes les personnes ayant une relation de type "amis" avec Shell

``` neo4j
match (n:personne {name:'Shell'}) <-[l:LIEN {type:"amis"}]- (n2) return n2 
```

### Affichage des groupes dans lesquels Shell a posté au moins un message

``` neo4j
match (n:personne {name:'Shell'}) -[l:MESSAGE]-> (n2) return n2
```

### Afficher tous les messages existants

``` neo4j
match (n1) -[l:MESSAGE]-> (n2) return l 
```

### Afficher les messages postés par RobinR dans le groupe Linux

``` neo4j
match(n1:personne {name:'RobinR'})-[l:MESSAGE]->(n2:groupe {name:'Linux'}) return l
```

### Ajouter un sous-groupe "Fedora" au groupe Linux déjà existant

``` neo4j
match (b:groupe{name:'Linux'})
create (a:groupe{name:'Fedora', description:'Sous groupe de Linux, distribution alternative'})<-[r:PARENT]-(b)
return a, r, b
```

### Ajout d'un nouveau message de "RobinR" dans le groupe "Linux"

``` neo4j
match (a:personne{name:'RobinR'}),(b:groupe{name:'Linux'})
create (a)-[r:MESSAGE{contenu:'Salut c\'est Robin'}]->(b)
return a, r, b
```

## Conséquences de l'implémentation Neo4j

### Avantages

- Neo4j est open source et sa structure sous forme de graphe facilite la modélisation ainsi que la visualisation des données, puisqu'on sort de l'aspect "relation" et "tableau" associé aux autres bases de données qui ne sont pas shemas-less. Le langage Cypher est également très visuel.

- Les requêtes sont plus courtes qu'en relationnel. Il est possible d'effectuer des restrictions par labels et projections des propriétés désirées grâce au return.

- Plusieurs modes de visualisation des données sont disponibles pour diverses applications, notamment la vision graphique ou la vision Json.

- Syntaxe facile à apprendre et à prendre en main.

- On peut ajouter de manière très souple de nouveaux noeuds et/ou relations entre les noeuds existant comme le montre les deux dernières requêtes ci-dessus.

### Désavantages

- Aucune gestion des contraintes en Neo4j. Par exemple rien ne nous empêcherai de faire un lien entre 2 entreprises, alors que ceci n'est pas possible si l'on suit notre MCD, ou encore on peut omettre des attributs qui sont clés dans le MCD (comme le mail par exemple).


## Conclusion

Neo4j tire sa force de sa syntaxe souple et de son affichage graphique permettant une visualisation claire et un stockage efficace des données. Il est beaucoup plus permissif que les bases de données SQL, étant donné qu'aucune contrainte d'intégrité n'est affectable aux noeuds ou relations. Nous avons donc stocker des données de types **Personne**, **Entreprise**, **Groupe** sous forme de noeuds et **Message** et **Lien** sous forme de relations. Ainsi par rapport à notre MCD, les classes se transcrivent bien sous forme de noeuds, et les classes d'associations et associations se transcrivent bien sous forme de relations entre ces noeuds.
Le but principal de Neo4j est donc d'offrir un stockage de données souple et une représentation graphique ne laissant place à aucune ambiguité pour se représenter la base de données dans son ensemble et les relations qu'entretiennent chaque noeuds précisément.