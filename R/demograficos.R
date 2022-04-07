#' Zona de residencia
#' `r lifecycle::badge("stable")`
#'
#'  La base de datos de ne ENFT en su primera versión imputaba las zonas de
#'  residencia con los valores de 0 y 1, para compatibilidad con la segunda
#'  versión y la encuesta continua (ENCFT) se crea una variable zona que imputa
#'  los valores como 1 y 2.
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable \code{ano}
#'   adicionada.
#'
#' @export
#'
#' @examples
#' (
#'   enft1 <- data.frame(
#'     PERIALFA = rep("1/2016", 5),
#'     S1_P4 = sample(c(0, 1), 5, replace = TRUE)
#'   )
#' )
#' ft_zona(enft1)
#'
#' (
#'   enft2 <- data.frame(
#'     EFT_PERIODO = rep("1/2016", 5),
#'     EFT_ZONA = sample(c(0, 1), 5, replace = TRUE)
#'   )
#' )
#' ft_zona(enft1)
ft_zona <- function(tbl) {
  S1_P4 <- NULL
  EFT_ZONA <- NULL
  if (ft_version(tbl) == 1) {
    tbl %>%
      dplyr::mutate(
        zona = S1_P4 + 1
      )
  } else {
    tbl %>%
      dplyr::mutate(
        zona = EFT_ZONA + 1
      )
  }
}


#' @rdname ft_zona
#' @export
ft_compute_zona <- function(tbl) {
  lifecycle::deprecate_warn("0.1.0", "ft_compute_zona()", "ft_zona()")
  ft_zona(tbl)
}


#' Regiones de desarrollo según decreto 710-04
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#'   \code{regiones_desarrollo_710_04} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_regiones_desarrollo_710_04(enft)
#' }
ft_regiones_desarrollo_710_04 <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      regiones_desarrollo_710_04 = dplyr::case_when(
        EFT_PROVINCIA %in% c(25, 18, 9) ~ 1,
        EFT_PROVINCIA %in% c(13, 24, 28) ~ 2,
        EFT_PROVINCIA %in% c(6, 19, 14, 20) ~ 3,
        EFT_PROVINCIA %in% c(27, 15, 5, 26) ~ 4,
        EFT_PROVINCIA %in% c(21, 2, 17, 31) ~ 5,
        EFT_PROVINCIA %in% c(4, 3, 16, 10) ~ 6,
        EFT_PROVINCIA %in% c(22, 7) ~ 7,
        EFT_PROVINCIA %in% c(12, 11, 8) ~ 8,
        EFT_PROVINCIA %in% c(23, 30, 29) ~ 9,
        EFT_PROVINCIA %in% c(1, 32) ~ 10
      )
    )
}


#' @rdname ft_regiones_desarrollo_710_04
#' @export
ft_regiones_desarrollo <- function(tbl) {
  lifecycle::deprecate_warn(
    "0.6.1",
    "ft_regiones_desarrollo()",
    "ft_regiones_desarrollo_710_04()"
  )
  ft_regiones_desarrollo_710_04(tbl)
}


#' Regiones de desarrollo según decreto 685-00
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] con los datos de la encuesta
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#'  \code{regiones_desarrollo_685_00} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_regiones_desarrollo_685_00(enft)
#' }
ft_regiones_desarrollo_685_00 <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      regiones_desarrollo_685_00 = dplyr::case_when(
        EFT_PROVINCIA %in% c(1, 32) ~ 1,
        EFT_PROVINCIA %in% c(17, 21, 29, 31) ~ 2,
        EFT_PROVINCIA %in% c(23, 12, 11, 30, 8) ~ 3,
        EFT_PROVINCIA %in% c(19, 6, 14, 20) ~ 4,
        EFT_PROVINCIA %in% c(28, 13, 24) ~ 5,
        EFT_PROVINCIA %in% c(25, 18, 9) ~ 6,
        EFT_PROVINCIA %in% c(27, 26, 15, 5) ~ 7,
        EFT_PROVINCIA %in% c(2, 22, 7) ~ 8,
        EFT_PROVINCIA %in% c(4, 3, 16, 10) ~ 9
      )
    )
}



#' Zona Especial de Desarrollo Fronterizo de la República Dominicana
#' `r lifecycle::badge('stable')`
#'
#' Vea Ley 28-01 de la República Dominicana.
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#'  \code{zona_desarrollo_fronterizo} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_zona_desarrollo_fronterizo(enft)
#' }
ft_zona_desarrollo_fronterizo <- function(tbl) {
  tbl %>%
    ft_regiones_desarrollo_710_04() %>%
    dplyr::mutate(
      zona_desarrollo_fronterizo = dplyr::case_when(
        as.numeric(EFT_PROVINCIA) %in% as.numeric(c("16", "10", "07", "05", "15", "26", "03")) ~ 1,
        TRUE ~ 0
      )
    )
}


# TODO

# Definir grandes dominios geograficos
# Zona metro y zona urbana mucicipio de santiago
# resto urbano
# resto rural


#' Dominios de inferencia ENFT
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#'   \code{dominios_inferencia} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_dominios_inferencia(enft)
#' }
ft_dominios_inferencia <- function(tbl) {
  dominios_inferencia1 <- NULL
  dominios_inferencia2 <- NULL
  dominios_inferencia3 <- NULL
  tbl %>%
    ft_dominios_inferencia1() %>%
    ft_dominios_inferencia2() %>%
    ft_dominios_inferencia3() %>%
    dplyr::mutate(
      dominios_inferencia = dplyr::case_when(
        dplyr::between(periodo, 20001, 20031) ~ dominios_inferencia1,
        dplyr::between(periodo, 20032, 20072) &
          dominios_inferencia2 == 1 ~ 1,
        dplyr::between(periodo, 20032, 20072) ~ dominios_inferencia2 + 2,
        periodo >= 20081 ~ dominios_inferencia3 + 11
      )
    )
}


#' Dominios de inferencia ENFT (20001 - 20031)
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#'  \code{dominios_inferencia1} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_dominios_inferencia1(enft)
#' }
ft_dominios_inferencia1 <- function(tbl) {
  tbl %>%
    ft_zona() %>%
    dplyr::mutate(
      dominios_inferencia1 = dplyr::case_when(
        EFT_PROVINCIA %in% c(1, 32) ~ 1,
        zona == 1 ~ 2,
        zona == 2 ~ 3
      )
    )
}


#' Dominios de inferencia ENFT (20032 - 20072)
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#' \code{dominios_inferencia2} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_dominios_inferencia2(enft)
#' }
ft_dominios_inferencia2 <- function(tbl) {
  regiones_desarrollo_685_00 <- NULL
  tbl %>%
    ft_regiones_desarrollo_685_00() %>%
    dplyr::mutate(
      dominios_inferencia2 = regiones_desarrollo_685_00
    )
}


#' Dominios de inferencia ENFT (20081 - )
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] con datos de la base de datos
#'
#' @return Los datos suministrados en el input \code{tbl} con la variable
#' \code{dominios_inferencia3} adicionada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_dominios_inferencia3(enft)
#' }
ft_dominios_inferencia3 <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      dominios_inferencia3 = dplyr::case_when(
        EFT_PROVINCIA == 1 ~ 1,
        EFT_PROVINCIA == 32 ~ 2,
        EFT_PROVINCIA == 25 ~ 3,
        EFT_PROVINCIA == 9 ~ 4,
        EFT_PROVINCIA == 18 ~ 5,
        EFT_PROVINCIA == 13 ~ 6,
        EFT_PROVINCIA == 24 ~ 7,
        EFT_PROVINCIA == 28 ~ 7,
        EFT_PROVINCIA == 6 ~ 8,
        EFT_PROVINCIA == 14 ~ 9,
        EFT_PROVINCIA == 20 ~ 10,
        EFT_PROVINCIA == 19 ~ 11,
        EFT_PROVINCIA == 27 ~ 12,
        EFT_PROVINCIA == 5 ~ 13,
        EFT_PROVINCIA == 15 ~ 13,
        EFT_PROVINCIA == 26 ~ 13,
        EFT_PROVINCIA == 21 ~ 14,
        EFT_PROVINCIA == 2 ~ 15,
        EFT_PROVINCIA == 17 ~ 15,
        EFT_PROVINCIA == 31 ~ 15,
        EFT_PROVINCIA == 22 ~ 16,
        EFT_PROVINCIA == 7 ~ 17,
        EFT_PROVINCIA == 4 ~ 18,
        EFT_PROVINCIA == 3 ~ 19,
        EFT_PROVINCIA == 10 ~ 19,
        EFT_PROVINCIA == 16 ~ 19,
        EFT_PROVINCIA == 23 ~ 20,
        EFT_PROVINCIA == 29 ~ 21,
        EFT_PROVINCIA == 30 ~ 21,
        EFT_PROVINCIA == 12 ~ 22,
        EFT_PROVINCIA == 11 ~ 23,
        EFT_PROVINCIA == 8 ~ 24
      )
    )
}
