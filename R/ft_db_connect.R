#' Conexión a base de datos
#' `r lifecycle::badge("experimental")`
#' Vea \code{Dmisc::\link[Dmisc:db_connect]{db_connect}}
#'
#' @param db_name Nombre de la base de datos
#' @param ... Others arguments to pass to \code{Dmisc::\link[Dmisc:db_connect]{db_connect}}
#'
#' @return Conexión a base de datos. 
#' @export
#'
#' @examples
#' \dontrun{
#'   conn <- ft_db_connect()
#' }
ft_db_connect <- function(db_name = 'enft', ...){
  Dmisc::db_connect(db_name = db_name, ...)
}


#' @rdname ft_db_connect
#' @export
ft_dbConnect <- function(db_name = 'enft', ...){
  lifecycle::deprecate_warn('0.1.0', 'ft_dbConnect()', 'ft_db_connect()')
  ft_db_connect(db_name = db_name, ...)
}