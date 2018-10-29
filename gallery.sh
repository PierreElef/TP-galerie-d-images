#!/bin/bash

#écrire les premières balises dans le fichier HTML en écrasant le contenu précédant
echo "Création de la page HTML"
echo '<!DOCTYPE HTML>' > gallery.html
echo '<html lang="fr-FR">' >> gallery.html
echo '<head>' >> gallery.html
echo '<link rel="stylesheet" href="./css/bootstrap.css">' >> gallery.html
echo '</head>' >> gallery.html
echo '<body>' >> gallery.html
echo '<div class="container">' >> gallery.html
echo '<h1 class="text-center">Ma galerie</h1>' >> gallery.html
echo '<div class="row">' >> gallery.html

#supprimer les anciennes thumbnail
echo "Suppression des anciennes miniatures"
minis=`find ./images/miniatures -type f  \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) | cut -c 21-`
for mini in $minis
do
	rm -f images/miniatures/$mini
done

#trouver les noms des images jpg dans le dossier images
echo "Recherche des images"
imgs=`find ./images -type f  \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) | cut -c 10-`

#créer les miniatures
echo "Création des miniatures"
cd images
sudo mogrify -path miniatures -thumbnail 200x200 *.jpg
sudo mogrify -path miniatures -thumbnail 200x200 *.png
sudo mogrify -path miniatures -thumbnail 200x200 *.gif
cd ..

#boucle for pour toutes les images trouvées
echo "Affichage des images dans la page HTML"
for img in $imgs
do
	#mettre balise <a href=image><img scr=miniature>
	echo '<div class="col" style="padding:5px">' >> gallery.html
	echo '<a href="./images/'$img'" target="_blank"><img src="./images/miniatures/'$img'"></a>' >> gallery.html
	echo '</div>' >> gallery.html
done

#écrire les dernières balises dans le fichiers HTML
echo '</div>' >> gallery.html
echo '</body>' >> gallery.html
echo '</html>' >> gallery.html

#archiver les images
echo "Archivage des images"
dateToday=`date '+%Y_%m_%d'`
archiveToday='vignettes-'$dateToday'.tgz'
sudo tar -czvf archives/$archiveToday images

echo 0
