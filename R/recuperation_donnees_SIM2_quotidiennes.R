#' Récupération des données SIM2 Météo France quotidiennes d'un point de grille
#'
#' @param LAMBXLAMBY_meteoFrance une chaine de caractère où LAMBX et LAMBY sont séparées par un espace
#'
#' @returns les données météorologiques du point de grille identifié, depuis le 1er du mois précédent
#' @keywords internal
#'
#' @import httr2
#' @import readr
#' @import dplyr
#' @import sf
#' @import ggspatial
#' @importFrom stringr str_split
#'
#' @examples
#' # Identifiant du point de grille situé sur Grenoble : LAMBX LAMBY
#' recuperation_donnees_SIM2_quotidiennes("8680 20250")
recuperation_donnees_SIM2_quotidiennes <- function(LAMBXLAMBY_meteoFrance) {
  data_src <-
    # Construction de la requête de base
    request(
      "https://tabular-api.data.gouv.fr/api/resources/adcca99a-6db0-495a-869f-40c888174a57/data/csv/"
    ) %>%
    # Complétion de la requête avec les variables
    req_url_query(
      LAMBX__in = str_split("8680 20250", " ")[[1]][1],
      LAMBY__in = str_split("8680 20250", " ")[[1]][2]
    ) %>%
    # Ajout des paramètres de sécurité
    req_headers("accept" = "text/csv") %>%
    req_perform() %>%
    # Récupération des données CSV
    resp_body_string()


  data <- read_csv(data_src) %>%
    # Sélection et renommage des colonnes d'intérêt
    select(
      LAMBX,
      LAMBY,
      DATE,
      PRECIPITATIONS_mm = PRELIQ,
      PLUIE_EFFICACES_mm = PE,
      TMOY_C = `T`,
      TMIN_C = TINF_H,
      TMAX_C = TSUP_H,
      ETR_mm = EVAP,
      ETP_mm = ETP,
      EAU_SOL_prct = WG_RACINE
    ) %>%
    # Création de l'identifiant pour chaque point
    mutate(ID = paste0(LAMBX, LAMBY)) %>%
    relocate(ID, .before = LAMBX)

  return(data)
}
