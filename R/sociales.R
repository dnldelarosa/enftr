#' Cálculo de pobreza monetaria con metodología oficial
#' `r lifecycle::badge('experimental')`
#' 
#' @param conn conexión a la base de datos
#' @param name nombre de la tabla en la base de datos
#' 
#' @return data.frame con los datos de la tabla
#' 
#' @export 
#' 
#' @details Por el momento, carga los datos desde una tabla 
#' en la base de datos.
#' 
#' @examples 
#' \dontrun{
#'   pobreza_monetaria <- pobreza_monetaria(conn, "pobreza_monetaria")
#' }
ft_pobreza_monetaria <- function(conn, name = "pobreza_monetaria") {
  dplyr::tbl(conn, name)
}