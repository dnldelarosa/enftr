ipc99 <- read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/Pages from td-13-medicion-de-la-pobreza-monetaria-en-rd (IPC).xlsx",
  skip = 4,
  col_names = F
)[, c(1, 2, 4)] %>%
  dplyr::mutate(
    ...1 = dplyr::case_when(
      stringr::str_detect(...1, "[^0-9]") ~ NA_character_,
      as.numeric(...1) < 1998 ~ NA_character_,
      TRUE ~ ...1
    )
  ) %>%
  tidyr::fill(...1) %>%
  tidyr::drop_na() %>%
  setNames(c("ano", "mes", "ipc")) %>% 
  type.convert() %>%
  Dmisc::vars_to_date(year = 1, month = 2)


ipc10 <- readxl::read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/ipc_base_2010.xls", skip = 7, col_names = F)[, 1:3] %>%
  setNames(c("ano", "mes", "ipc")) %>%
  tidyr::fill(ano) %>%
  tidyr::drop_na() %>%
  dplyr::filter(dplyr::between(ano, 1999, 2016)) %>%
  Dmisc::vars_to_date(year = 1, month = 2) %>% 
  dplyr::filter(date > max(ipc99$date)) %>% 
  dplyr::mutate(
    ipc = ipc/0.2841 # Llevando a base 1999
  )

ipc <- dplyr::bind_rows(ipc99, ipc10)

usethis::use_data(ipc, overwrite = TRUE)
