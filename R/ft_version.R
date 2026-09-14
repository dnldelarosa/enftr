#' Identificar la estructura de los datos ENFT
#'
#' Distingue nombres de columnas, no revisiones del diccionario ni metodologias.
#' Una tabla con ambas columnas de periodo es ambigua y se rechaza.
#' @param tbl data.frame o tibble local.
#' @return 1 para PERIALFA; 2 para EFT_PERIODO.
#' @export
ft_version <- function(tbl) {
  ft_check_table(tbl)
  found <- c("PERIALFA", "EFT_PERIODO") %in% names(tbl)
  if (sum(found) != 1L) stop("Se requiere exactamente una columna de periodo: PERIALFA o EFT_PERIODO.", call. = FALSE)
  which(found)
}
