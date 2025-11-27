# sim2MeteoFrance
⏳en cours de construction ... 

## Utilisation du package
Pour importer ce package dans votre projet sous R : 
```{r}
  install.packages("remotes")
  remotes::install_github("maeldey/sim2meteoFrance")
```
Package R pour récupérer les données quotidiennes du modèle SIM2 de Météo-France disponibles sur : https://www.data.gouv.fr/datasets/donnees-changement-climatique-sim-quotidienne/. 

Il comporte 2 fonctions : 
- une qui permet de récupérer l'ensemble des points de la grille SAFRAN dont les données météorologiques récentes sont disponibles,
- une qui permet de récupérer les données météorologiques pour un ou une liste de points de grille SAFRAN.
  
⚠️ Ce package ne permet que de récupérer les données les plus récentes, allant d'hier au 1er du mois précédent...  

## Structure du dossier
Les fichiers et dossiers présents dans ce package ont été créés automatiquement par le générateur de package de R Studio et Devtools en suivant le tutoriel : https://thinkr.fr/creer-package-r-quelques-minutes/. 
Le dossier le plus intéressant est celui qui contient les fonctions 
