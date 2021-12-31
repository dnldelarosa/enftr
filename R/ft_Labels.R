#' Navegar el diccionario de la base de datos
#' `r lifecycle::badge('experimental')`
#'
#' @param dict [list] diccionario de la base de datos
#' @param ... Otros argumentos pasados a \code{labeler::\link[labeler:browse_dict]{browse_dict}}
#'
#' @return widget html interactivo con el diccionario de la encuesta
#' @export
#'
#' @examples
#' \dontrun{
#' ft_browse_dict()
#' }
ft_browse_dict <- function(dict = enftr::dict, ...) {
  labeler::browse_dict(dict, ...)
}



#' Asigna etiquetas de datos a las variables especificadas
#' `r lifecycle::badge("experimental")`
#' Vea \code{labeler::\link[labeler:set_labels]{set_labels}}
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param dict [list]: Diccionario de la base de datos
#' @param vars [character]: Si especificado, solo se asignaran las etiquetas a esas variables.
#'
#' @return Los datos introducidos en el argumento \code{tbl} pero con etiquetas de datos
#'
#' @details
#'   Esta función permite asignar etiquetas de datos a las variables de un data.frame
#'   o equivalente, a partir del diccionario de la encuesta.
#'
#' @seealso
#'   Etiquetas de datos \code{vignette("labeler", package = "labeler")}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   enft <- data.frame(S2_P8 = c(1, 2))
#'   str(enft)
#'   str(ft_set_labels(enft))
#'}
ft_set_labels <- function(tbl, dict = enftr::dict, vars = NULL) {
  labeler::set_labels(tbl, dict, vars = vars)
}


#' @rdname ft_set_labels
#' @export
ft_setLabels <- function(tbl, dict = enftr::dict, vars = NULL) {
  lifecycle::deprecate_warn('0.1.0', 'ft_setLabels()', 'ft_set_labels()')
  ft_set_labels(tbl, dict, vars)
}



#' Utiliza las etiquetas de datos de una variable
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param vars [character]: Si especificado, solo se asignaran las etiquetas a esas variables.
#' @param dict [list]: Diccionario de la base de datos
#'
#' @return Los datos suministrados en el argumento \code{tbl}, pero en lugar de
#'   valores utilizando las etiquetas de datos correspondientes
#'
#' @seealso
#'   Etiquetas de datos \code{vignette("labeler", package = "labeler")}
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   enft <- data.frame(S2_P8 = c(1, 2))
#'   enft
#'   ft_use_labels(enft)
#'}
ft_use_labels <- function(tbl, dict = enftr::dict, vars = NULL) {
  labeler::use_labels(tbl, dict, vars)
}


#' @rdname ft_use_labels
#' @export
ft_useLabels <- function(tbl, dict = enftr::dict, vars = NULL) {
  lifecycle::deprecate_warn('0.1.0', 'ft_useLabels()', 'ft_use_labels()')
  ft_use_labels(tbl, dict, vars = vars)
}