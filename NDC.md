# Note de clarification :

Un réseau social de veille technologique a pour but de s'actualiser sur les derniers faits et actualités technologiques sur internet. Ce réseau regroupe des **utilisateurs** identifiés par un mail unique, le réseau n'acceptant pas une inscription basée sur un mail déjà existant. Toutes les autres caractéristiques peuvent être identiques chez plusieurs utilisateurs. Ces utilisateurs sont donc caractérisés par :

- un mail
- un nom
- un résumé
- une date d'inscription
- une nationalité
- une photo

Dans ces Utilisateurs, on retrouve plus précisément des **personnes** ayant les caractéristiques ci-dessus, mais aussi les suivantes :

- un pseudo
- un prénom
- une date de naissance
- un sexe (Homme, Femme, Autres)
- un employeur

Le pseudo de chaque utilisateur est unique.
Ces personnes peuvent avoir des **compétences** identifiées par leur nom, mais aussi des **formations** qui sont identifiées par un nom unique et une date de début puis de fin de formation. Une personne peut détenir plusieurs **diplômes**, caracrtérisés par un intitulé unique.

On retrouve également des **entreprises** qui héritent des caractéristiques d'un utilisateur, puis caractérisées également par :

- une adresse
- une date de création
- un site web
- une catégorie

Notons que les personnes peuvent s'intéresser à des **domaines** en particulier, identifiés par un nom. Les entreprises, quant à elles, sont spécialisées dans un ou plusieurs domaines.

-----------------

Ces personnes peuvent être liées entre elles par des **Liens typés** regroupant les relations suivantes :
- être amis
- être collègues
- être des connaissances

et sont identifiées par les mails des 2 personnes impliquées dans cette relation. Notons que si l'une décide de révoquer le lien, ce dernier cesse d'exister.

-----------------

Les utilisateurs s'intéressant à un sujet en particulier peuvent rejoindre des **groupes thématiques** regroupant d'autres personnes ayant le même intérêt. Ces groupes sont identifiés par un thème unique : 2 groupes différents ne peuvent pas porter sur le même thème. Ces groupes sont caractérisés par :
- un thème
- un effectif (mis à jour dynamiquement)
- une description
- le nombre de messages postés dans le groupe (mis à jour dynamiquement)

Ces groupes thématiques peuvent contenir des sous-groupes plus spécifiques, qui sont définis de la même manière qu'un groupe, avec une association permettant de lier un sous-groupe à son groupe parent. Il peut exister une multitude de sous-groupes pour un même groupe, mais on ne peut pas créer de sous-groupe de sous-groupe. Notre réseau sera donc sur une profondeur de 2 au maximum concernant les groupes. Les groupes et sous-groupes peuvent être créés par les utilisateurs. Le réseau social comportera certains groupes et sous-groupes dès sa création.

-----------------

Ces groupes contiendront des **messages typés**, publiés par ses adhérents. Il est donc impossible de poster du contenu sur le réseau social en dehors d'un groupe (les personnnes n'ont pas de fil d'actualités).

Un message a les caractéristiques suivantes :
- un ID (unique)
- une date de publication
- un texte

Il est écrit par un utilisateur précis, et appartient à un et un seul groupe.

Un message typé peut contenir un ou plusieurs  **fichiers** caractérisés par:
- un contenu
- un id
- un nom

Les fichiers sont identifiés par le nom et l'id. Ils représentent des fichiers quelconques comme des PDF, du son, une image.

-----------------

Un utilisateur pourra avoir un ou plusieurs **dossiers thématiques** regroupant des liens vers les publications appartenant à un groupe thématique spécifique qu'il aura sauvegardé. Ces dossiers seront identifiés par un nom unique.
