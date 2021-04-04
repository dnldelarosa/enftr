ft_version <- function(tbl){
  if ("tbl" %in% class(tbl)){
    nombres <- dplyr::tbl_vars(tbl)
  } else {
    nombres <- names(tbl)
  }
  if(any(c("PERIALFA", "perialfa") %in% nombres)){
    1
  } else if("EFT_PERIODO" %in% nombres){
    2
  } else {
    stop("\n Ninguna de las variables PERIALFA o EFT_PERIODO fue encontrada en los datos.
         \n \u00BFSon estos los datos de la ENFT?\n ")
  }
}