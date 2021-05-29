#' Divide la variable EFT_PERIODO en varias
#'
#' `r lifecycle::badge("stable")`
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#' @param rm 
#' @param ano 
#' @param semestre 
#' @param periodo 
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
#'   la convierte en una variable numérica, y que trae con ellos una mucho mayor 
#'   facilidad de manipulación. Además de que se hace consistete para todo el 
#'   período analizado.
#'  
#' @export
#'
#' @examples
#' (enft <- data.frame(EFT_PERIODO = "1/2016"))
#' ft_compute_peri_vars(enft)
ft_compute_peri_vars <- function(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE) {
  tbl <- tbl %>%
    tidyr::separate(
      col = "EFT_PERIODO",
      into = c("semestre", "ano"),
      sep = "/",
      remove = F,
      convert = T
    )
  
  if(periodo){
    tbl <- tbl %>% 
      dplyr::mutate(
        periodo = as.numeric(paste0(ano,semestre))
      )
  }
  
  if(!ano){
    tbl <- tbl %>% 
      dplyr::select(-"ano")
  }
  
  if(!semestre){
    tbl <- tbl %>% 
      dplyr::select(-"semestre")
  }
  
  if(rm){
    tbl <- tbl %>% 
      dplyr::select(-"EFT_PERIODO")
  }
  tbl
}

ft_compute_ano <- function(tbl, semestre = TRUE, periodo = TRUE) {
  deprecate_warn("0.3.0", "enftr::ft_compute_ano()", "ft_compute_peri_vars()")
  ft_compute_peri_vars(tbl, rm = FALSE, ano = TRUE, semestre, periodo)
}
