#' Asigna etiquetas de datos a las variables especificadas
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param dict [Dict]: Diccionario con las etiquetas de las variables
#' @param subset [character]: Si especificado, solo se asignaran las etiquetas a esas variables.
#' @param vars [character]: Alias deprecated de `subset` mantenido por compatibilidad.
#' @param ... argumentos adicionales de \code{labeler::set_Dict}
#' @param version,at,con Seleccion opcional de revision; ver [ft_dict()].
#'
#' @return Los datos introducidos en el argumento \code{tbl} pero con etiquetas de datos
#'
#' @seealso
#'   Etiquetas de datos \code{vignette("labeler", package = "labeler")}
#'
#' @export
ft_set_Dict <- function(tbl, dict = NULL, subset = NULL, ..., version = NULL, at = NULL, con = NULL) {
  if (!is.null(dict) && (!is.null(version) || !is.null(con))) stop("Especifique dict o version/con, no ambos.", call. = FALSE)
  if (is.null(dict)) dict <- ft_dict(version = version, at = at, con = con)
  labeler::set_Dict(tbl, dict, subset, ..., at = at)
}

#' Utiliza las etiquetas de datos de una variable/dataset
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param dict [Dict]: Diccionario con las etiquetas de las variables
#' @param subset [character]: Si especificado, solo se asignaran las etiquetas a esas variables.
#' @param vars [character]: Alias deprecated de `subset` mantenido por compatibilidad.
#' @param ... argumentos adicionales de \code{labeler::with_Dict}
#'
#' @return El dataset modificado
#'
#' @export
ft_with_Dict <- function(tbl, dict = NULL, subset = NULL, ...) {
  labeler::with_Dict(tbl, dict, subset, ...)
}



#' @rdname ft_set_Dict
#' @export
ft_set_labels <- function(tbl, dict = NULL, vars = NULL) {
  ft_set_Dict(tbl, if (is.null(dict)) NULL else labeler::as.Dict(dict), subset = vars)
}

#' @rdname ft_set_Dict
#' @export
ft_setLabels <- function(tbl, dict = NULL, vars = NULL) {
  lifecycle::deprecate_warn("0.1.0", "ft_setLabels()", "ft_set_labels()")
  ft_set_labels(tbl, dict, vars)
}

#' @rdname ft_with_Dict
#' @export
ft_use_labels <- function(tbl, dict = NULL, vars = NULL, ...) {
  if (is.null(dict)) dict <- ft_dict() else dict <- labeler::as.Dict(dict)
  ft_with_Dict(tbl, dict, subset = vars, use_label = FALSE, use_labels = TRUE, ...)
}

#' @rdname ft_with_Dict
#' @export
ft_useLabels <- function(tbl, dict = NULL, vars = NULL, ...) {
  lifecycle::deprecate_warn("0.1.0", "ft_useLabels()", "ft_use_labels()")
  ft_use_labels(tbl, dict, vars, ...)
}

#' Consultar el diccionario ENFT
#' @param dict Diccionario opcional; por defecto la revisión incluida.
#' @param ... Argumentos adicionales para labeler::browse_dict.
#' @return Tabla o widget interactivo según los argumentos de labeler.
#' @export
ft_browse_dict <- function(dict = NULL, ...) {
  if (is.null(dict)) dict <- ft_dict() else dict <- labeler::as.Dict(dict)
  args <- list(...)
  if (isTRUE(args$testing)) return(as.data.frame(dict))
  labeler::dict_browser(dict, .interactive = if (is.null(args$.interactive)) interactive() else args$.interactive)
}
