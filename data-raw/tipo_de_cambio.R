tdc_td13 <- readxl::read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/tipos de camio td-13.xlsx", skip = 1) %>% 
  tidyr::drop_na(`Peso Dominicano`) %>% 
  dplyr::filter(`Peso Dominicano` != "Peso Dominicano", `...2` != "Promedio") %>% 
  tidyr::fill(`Período`) %>% 
  Dmisc::vars_to_date(year = 1, month = 2) %>% 
  tidyr::pivot_longer(-date, names_to = "moneda") %>% 
  dplyr::mutate(value = as.numeric(value)) %>% 
  tidyr::drop_na() %>% 
  dplyr::mutate(
    cod_moneda = dplyr::case_when(
      moneda == "Dólar Canadiense" ~ "CAD",
      moneda == "Dólar Estadounidense" ~ "USD",
      moneda == "Euro" ~ "EUR",
      moneda == "Franco Suizo" ~ "CHF",
      moneda == "Libra Esterlina" ~ "GBP",
      moneda == "Lira Italiana" ~ "ITL",
      moneda == "Marco Alemán" ~ "DEM",
      moneda == "Peseta Española" ~ "ESP",
      moneda == "Peso Dominicano" ~ "DOP",
      moneda == "Yen Japonés" ~ "JPY"
    )
  )


tasas_de_cambio <- readxl::read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/TASAS_CONVERTIBLES_OTRAS_MONEDAS.xls", sheet = "Mensual", skip = 2) %>% 
  dplyr::filter(`Año` <= 2016) %>% 
  dplyr::mutate(`Peso Dominicano` = 1) %>% 
  Dmisc::vars_to_date(year = 1, month = 2) %>% 
  tidyr::pivot_longer(-date, names_to = "moneda", values_drop_na = TRUE) %>% 
  dplyr::mutate(
    moneda = stringr::str_to_title(moneda),
    cod_moneda = dplyr::case_when(
      moneda == "Peso Dominicano" ~ "DOP",
      moneda == "Bolivar Fuerte Venezolano" ~ "VES",
      moneda == "Corona Danesa" ~ "DKK",
      moneda == "Corona Noruega" ~ "NOK",
      moneda == "Corona Sueca" ~ "SEK",
      moneda == "Derecho Especial De Giro" ~ "XDR",
      moneda == "Dolar Canadiense" ~ "CAD",
      moneda == "Dolar Estadounidense" ~ "USD",
      moneda == "Euro" ~ "EUR",
      moneda == "Franco Suizo" ~ "CHF",
      moneda == "Libra Escocesa" ~ "GBPE", # Libra escocesa no está en el clasificador
      moneda == "Libra Esterlina" ~ "GBP",
      moneda == "Real Brasileno" ~ "BRL",
      moneda == "Yen Japones" ~ "JPY",
      moneda == "Yuan Chino" ~ "CNY"
      
    )
  ) %>% 
  dplyr::filter(date > max(tdc_td13$date))

#tdc_td13 %>% 
#  select(-moneda) %>% 
#  rename("morillo" = "value")%>% 
#  left_join(
#    tasas_de_cambio %>% 
#      select(-moneda)
#  ) %>% 
#  drop_na() %>% 
#  mutate(
#    diff = morillo - value
#  ) %>% 
#  summarise(sum(diff))%>% 
#  View()

tipo_de_cambio <- dplyr::bind_rows(tdc_td13, tasas_de_cambio) %>% 
  dplyr::mutate(
    cod_moneda2 = dplyr::case_when(
      cod_moneda == "DOP" ~ 1,
      cod_moneda == "USD" ~ 2,
      cod_moneda == "CAD" ~ 5,
      cod_moneda == "GBP" ~ 6,
      cod_moneda == "JPY" ~ 7,
      cod_moneda == "VES" ~ 12,
      cod_moneda == "CHF" ~ 13,
      cod_moneda == "EUR" ~ 14,
      cod_moneda == "BRL" ~ 21,
      cod_moneda == "CNY" ~ 22,
      cod_moneda == "XDR" ~ 23,
      cod_moneda == "DKK" ~ 24,
      cod_moneda == "NOK" ~ 25,
      cod_moneda == "GBPE" ~ 26,
      cod_moneda == "SEK" ~ 27
    )
  )


usethis::use_data(tipo_de_cambio, overwrite = TRUE)
