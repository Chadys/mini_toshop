- filters.sci : application de filtres (de convolution ou non)
- color_transform.sci : opération sur les couleurs (negatif, luminosité, extension linéaire,...)
- format_transform.sci : modification du format de l'image (taille, orientation)
- physical_transform.sci : transformation sur les forme (mosaïc, tourbillon,...)
- utils.sci : diverses fonctions mathématiques basiques
- my_gui.sci : interface graphique
- get_demo.sci : contient une fonction qui permet de créer des images de démonstration de l'application


- scilab_sivp_mode_d-emploi.txt : Tutorial pour installer Scilab et faire fonctionner SIVP

- photo_demo/ et fox_demo/ : images de démonstration


**Fonctionnement** :
- Pour démarrer : Faire un exec de tous les fichiers .sci (sauf get_demo). L'interface graphique se lance toute seule.
- Pour charger une image, aller dans Picture -> File -> Load picture. Il faut bien sélectioner le format de fichier voulu. (formats supportés : jpeg et png)
- Vous pouvez ensuite choisir un filtre à appliquer, avec, au besoin, des paramètres supplémentaires à définir.
- Les boutons : "Apply" sert à appliquer un filtre. "Show" permet de réouvrir le visionneur d'image s'il a été fermé par erreur. "Refresh" permet de revenir à l'image de base.
- Pour sauver une image modifiée, aller dans Picture -> File -> Save picture.
**Pour quitter** : Bouton "Quit" et fermer le visionneur d'image éventuellement ouvert.