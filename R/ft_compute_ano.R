#' Año
#'
#' `r lifecycle::badge("stable")`
#'
#'   Crea la variable año.
#'
#'   Las distintas versiones de la base de datos tradicional pueden contener
#'   formatos distintos para la variable perialfa (2000/1 vs 1/2000). Sin embargo,
#'   esta función está diseñada para trabajar con este problema aunque tengas
#'   estas bases en un mismo archivo.
#'
#' @param tbl [data.frame]: Conexión a base de datos o dataframe con los datos
#'
#' @return Los datos suministrados en el input \code{tbl} con las variables \code{semestre}
#'   y \code{ano} adicionadas.
#'
#' @export
#'
#' @examples
#' (enft <- data.frame(EFT_PERIODO = "1/2016"))
#' ft_compute_ano(enft)
ft_compute_ano <- function(tbl, semestre = TRUE, periodo = TRUE) {
  tbl <- tbl %>%
    tidyr::separate(
      col = "EFT_PERIODO",
      into = c("semestre", "ano"),
      sep = "/",
      remove = F,
      convert = T
    )
  
  if(!semestre){
    tbl %>% 
      dplyr::select(-"semestre")
  }
  
  if(periodo){
    tbl %>% 
      dplyr::mutate(
        periodo = as.numeric(paste0(ano,semestre))
      )
  }
}
