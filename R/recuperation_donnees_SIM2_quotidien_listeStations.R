#' Récupération des données SIM2 Météo France quotidiennes d'une liste de points de grille
#'
#' @param liste_LAMBXLAMBY_meteoFrance une chaine de caractère où LAMBX et LAMBY sont séparées par un espace
#'
#' @returns les données météorologiques des points de grille identifiés, depuis le 1er du mois précédent
#' @export
#' @import purrr
#' @import dplyr
#' @import httr2
#' @import sf
#' @import ggspatial
#'
#' @examples
#' # Identifiant des points de grille situés dans la vallée du Grésivaudan : LAMBX LAMBY
#' data_list <- recuperation_donnees_SIM2_quotidien_listeStations(c("760 24170", "8680 20250"))
recuperation_donnees_SIM2_quotidien_listeStations <- function(liste_LAMBXLAMBY_meteoFrance) {
  data <- purrr::map_dfr(
    liste_LAMBXLAMBY_meteoFrance,
    ~ recuperation_donnees_SIM2_quotidiennes(.x)  # .x = un élément de la liste
  )
  return(data)
}
