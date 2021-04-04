lineas_morillo_zona <- read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/Lineas de pobreza morillo.xlsx")
lineas_morillo_nac <- read_excel("D:/MEGA/PARETO/DB/ENFTR/Pobreza Monetaria/Lineas de pobreza morillo.xlsx", sheet = "nacional")

usethis::use_data(lineas_morillo_zona, overwrite = TRUE)
usethis::use_data(lineas_morillo_nac, overwrite = TRUE)


