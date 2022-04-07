lineas_morillo_zona <- read_excel("Files/Datos/Lineas de pobreza Morillo.xlsx")

###usethis::use_data(lineas_morillo_zona, overwrite = TRUE)

lineas_oficial_zona <- read_excel("Files/Datos/Lineas de pobreza Oficial.xlsx", skip = 3)[,c(1,3,4)] %>% 
  tidyr::drop_na() %>% 
  setNames(c("periodo", 0, 1)) %>% 
  tidyr::separate(periodo, c("ano", "semestre")) %>% 
  tidyr::pivot_longer(-c(ano, semestre), names_to = "EFT_ZONA", values_to = "lpobreza") %>% 
  dplyr::mutate(
    semestre = dplyr::if_else(semestre == "marzo", 1, 2)
  ) %>% 
  left_join(
    read_excel("Files/Datos/Lineas de pobreza Oficial.xlsx", skip = 3)[,c(1,6,7)] %>% 
  tidyr::drop_na() %>% 
  setNames(c("periodo", 0, 1)) %>% 
  tidyr::separate(periodo, c("ano", "semestre")) %>% 
  tidyr::pivot_longer(-c(ano, semestre), names_to = "EFT_ZONA", values_to = "lindigencia") %>% 
  dplyr::mutate(
    semestre = dplyr::if_else(semestre == "marzo", 1, 2)
  )
) %>% 
  dplyr::mutate(
    EFT_PERIODO = paste0(semestre, "/", ano)
  ) %>% 
  dplyr::select(-ano, -semestre) %>% 
  type.convert()

usethis::use_data(lineas_oficial_zona, overwrite = TRUE)
