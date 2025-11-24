#' Récupération des identifiants des points de grille SAFRAN
#'
#' @returns la localisation de tous les points de grille disponibles
#' @export
#'
#' @import purrr
#' @import dplyr
#' @import httr2
#' @import sf
#' @import ggspatial
#'
#' @examples
#' # Récupération de tous les points de grille disponibles
#' points_de_grille <- recuperation_points_de_grille_SAFRAN()
recuperation_points_de_grille_SAFRAN <- function() {
  sim2_points <- read_csv2(
    "https://object.files.data.gouv.fr/meteofrance/data/synchro_ftp/REF_CC/SIM/coordonnees_grille_safran_lambert-2-etendu.csv"
  ) %>%
    # Delete space in column name
    rename(LAMBX_hm = `LAMBX (hm)`, LAMBY_hm = `LAMBY (hm)`) %>%
    # Delete columns
    select(-LAT_DG, -LON_DG) %>%
    # Coordinates are given in hm : 1 hm = 100 m
    mutate(LAMBX_m = 100 * LAMBX_hm, LAMBY_m = 100 * LAMBY_hm,
           ID = paste(LAMBX_hm, LAMBY_hm)) %>%
    # Convert points to sf (spatial) objects
    st_as_sf(
      coords = c("LAMBX_m", "LAMBY_m"),
      crs = 27572,
      remove = TRUE
    ) %>%
    # Coordinate System Reference transformation to WSG:4326
    st_transform(crs = 4326)
  return(sim2_points)
}

