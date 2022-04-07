#' Diccionario para los datos de la ENFT
#' `r lifecycle::badge('stable')`
#' 
#'   Contiene las etiquetas tanto para las variables como para los valores de estas.
#'
#' @format [list]
#'
#' @source \url{https://github.com/endomer/enftr/tree/main/Files/Cuestionarios/}
"dict"


#' Conjunto de datos que simula la encuesta de fuerza de trabajo
#' `r lifecycle::badge('stable')`
#' 
#' @format [data.frame]
"enft_like"


#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL




ft_factor_onaplan <- function(tbl, factor_base = "EFT_FACTOR_EXP") {
  EFT_PERIODO <- NULL
  poblacion_onaplan <- NULL
  tbl %>%
    dplyr::left_join(enftr::poblacion_onaplan, copy = T, by = "EFT_PERIODO") %>%
    dplyr::group_by(EFT_PERIODO) %>%
    dplyr::mutate(
      factor_onaplan = !!as.name(factor_base) / 
        sum(!!as.name(factor_base), na.rm = T) * 
        poblacion_onaplan
    ) %>%
    dplyr::select(-poblacion_onaplan) %>% 
    dplyr::ungroup()
}