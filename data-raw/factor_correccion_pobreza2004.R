factor_correccion_pobreza2004 <- data.frame(
  ventil = c(1:20),
  factor_correccion = c(3.1822, 0.4518, 0.2814, 0.2131, 0.1953, 0.1790, 0.1879,
                        0.1601, 0.1584, 0.1310, 0.1314, 0.1469, 0.1135, 0.1073, 
                        0.1292, 0.1038, 0.0994, 0.0922, 0.0997, 0.0912)
)

usethis::use_data(factor_correccion_pobreza2004, overwrite = TRUE)
