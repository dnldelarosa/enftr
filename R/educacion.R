
#' Años de educación
#'`r lifecycle::badge("experimental")`
#'
#' @param tbl [data.frame] una conexión a base de datos o data.frame con los datos
#' 
#' @return [data.frame]: Los datos suministrados en el argumento \code{tbl} con
#'   la variable \code{anos_educacion} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   enft <- ft_anos_educacion(enft)
#' }
ft_anos_educacion <- function(tbl) {
  EFT_EDAD <- NULL
  EFT_ULT_NIVEL_ALCANZADO <- NULL
  EFT_ULT_ANO_APROBADO <- NULL
  tbl %>%
    dplyr::mutate(
      anos_educacion = dplyr::case_when(
        EFT_EDAD <= 3 ~ NA_integer_,
        EFT_ULT_NIVEL_ALCANZADO %in% c(1, 7) ~ 0,
        EFT_ULT_NIVEL_ALCANZADO == 2 ~ EFT_ULT_ANO_APROBADO,
        EFT_ULT_NIVEL_ALCANZADO %in% c(3, 4) ~ 8 + EFT_ULT_ANO_APROBADO,
        EFT_ULT_NIVEL_ALCANZADO == 5 ~ 12 + EFT_ULT_ANO_APROBADO,
        EFT_ULT_NIVEL_ALCANZADO == 6 ~ 16 + EFT_ULT_ANO_APROBADO
      )
    )
}


#' Alfabetismo de la persona (Sabe leer y escribir)
#' `r lifecycle::badge("experimental")`
#' 
#' Entre 2000 y 2005, se incluyó cero (0) en la variable para identificar aquellos
#' casos en que la pregunta no aplicaba. Esta variable omite esos valores.
#' 
#' @param tbl [data.frame] una conexión a base de datos o data.frame con los datos
#' @param min_edad [integer] la edad mínima para el cálculo de la variable
#' 
#' @return [data.frame]: Los datos suministrados en el argumento \code{tbl} con
#'  la variable \code{alfabeta} adicionada.
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#'  enft <- ft_alfabeta(enft)
#' }
ft_alfabeta <- function(tbl, min_edad = 15){
  EFT_ALFABETISMO <- NULL
  tbl %>%
    dplyr::mutate(
      alfabeta = dplyr::case_when(
        EFT_EDAD >= min_edad & EFT_ALFABETISMO %in% 1:2 ~ EFT_ALFABETISMO
      )
    )
}