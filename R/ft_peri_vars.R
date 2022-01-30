#' Divide la variable EFT_PERIODO en varias variables útiles
#' `r lifecycle::badge("stable")`
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param rm [logical]: Si es TRUE, elimina la variable EFT_PERIODO
#' @param ano [logical]: Si es TRUE, agrega la variable \code{ano}
#' @param semestre [logical]: Si es TRUE, agrega la variable \code{semestre}
#' @param periodo [logical]: Si es TRUE, agrega la variable \code{periodo}
#'
#' @return Los datos suministrados en el input \code{tbl} con las variables \code{semestre}
#'   \code{ano} y \code{periodo} adicionadas.
#'
#'
#' @details
#'   Las distintas versiones de la base de datos tradicional pueden contener
#'   formatos distintos para la variable perialfa (2000/1 vs 1/2000). Sin embargo,
#'   esta función está diseñada para trabajar con este problema aunque tengas
#'   estas bases en un mismo archivo.
#'
#'   La variable \code{periodo} es diferente a la variable \code{EFT_PERIODO},
#'   ya que esta primera está construida de la forma \code{ano+semestre}. Lo que
#'   la convierte en una variable numérica, y que trae con ello una mucho mayor
#'   facilidad de manipulación. Además de que se hace consistete para todo el
#'   período analizado.
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   (enft <- data.frame(EFT_PERIODO = "1/2016"))
#'   ft_peri_vars(enft)
#' }
ft_peri_vars <- function(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE) {
  EFT_PERIODO <- NULL
  nombres <- dplyr::tbl_vars(tbl)
  if("ano" %in% nombres){
    tbl <- dplyr::select(tbl, -"ano")
    ano <- TRUE
  }
  if("semestre" %in% nombres){
    tbl <- dplyr::select(tbl, -"semestre")
    semestre <- TRUE
  }
  if("periodo" %in% nombres){
    tbl <- dplyr::select(tbl, -"periodo")
    periodo <- TRUE
  }
  tbl <- tbl %>%
    dplyr::left_join(
      tbl %>%
        dplyr::select(
          EFT_PERIODO
        ) %>%
        dplyr::distinct() %>%
        dplyr::collect() %>%
        tidyr::separate(
          col = "EFT_PERIODO",
          into = c("semestre", "ano"),
          sep = "/",
          remove = F,
          convert = T
        ) %>%
    dplyr::mutate(
      semestre = stringr::str_remove(semestre, "\\'") %>% as.numeric()
    ),
    by = "EFT_PERIODO",
      copy = TRUE
    )

  if (periodo) {
    tbl <- tbl %>%
      dplyr::mutate(
        periodo = as.numeric(paste0(ano, semestre))
      )
  }

  if (!ano) {
    tbl <- tbl %>%
      dplyr::select(-"ano")
  }

  if (!semestre) {
    tbl <- tbl %>%
      dplyr::select(-"semestre")
  }

  if (rm) {
    tbl <- tbl %>%
      dplyr::select(-"EFT_PERIODO")
  }
  tbl
}


#' @rdname ft_peri_vars
#' @export
ft_compute_peri_vars <- function(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE) {
  lifecycle::deprecate_warn(
    "0.2.0",
    "ft_compute_peri_vars()",
    "ft_peri_vars()"
  )
  ft_peri_vars(tbl, rm, ano, semestre, periodo)
}



#' @rdname ft_peri_vars
#' @export
ft_compute_ano <- function(tbl) {
  lifecycle::deprecate_warn("0.3.0", "enftr::ft_compute_ano()", "ft_peri_vars()")
  ft_peri_vars(tbl, rm = FALSE, ano = TRUE, semestre = FALSE, periodo = FALSE)
}



#' @rdname ft_peri_vars
#' @export
ft_ano <- function(tbl) {
  lifecycle::deprecate_warn("0.3.0", "enftr::ft_ano()", "ft_peri_vars()")
  ft_peri_vars(tbl, rm = FALSE, ano = TRUE, semestre = FALSE, periodo = FALSE)
}