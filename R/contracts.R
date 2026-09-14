# Internal local-table contracts shared by ENFT calculations.
ft_check_age <- function(value) {
  if (!is.numeric(value) || length(value) != 1L || !is.finite(value) || value < 0 || value != floor(value))
    stop("min_edad debe ser un entero no negativo.", call. = FALSE)
}

ft_check_table <- function(tbl, required = character()) {
  if (!is.data.frame(tbl)) stop("Use un data.frame o tibble local; materialice la consulta antes de calcular.", call. = FALSE)
  if (anyDuplicated(names(tbl)) || anyNA(names(tbl)) || any(!nzchar(names(tbl))))
    stop("Los nombres de columnas deben ser unicos y no vacios.", call. = FALSE)
  missing <- setdiff(required, names(tbl))
  if (length(missing)) stop("Faltan columnas requeridas: ", paste(missing, collapse = ", "), call. = FALSE)
  invisible(tbl)
}

ft_check_flag <- function(value, name) {
  if (!is.logical(value) || length(value) != 1L || is.na(value))
    stop(name, " debe ser TRUE o FALSE.", call. = FALSE)
}

ft_period_parts <- function(tbl) {
  ft_check_table(tbl)
  column <- c("EFT_PERIODO", "PERIALFA")
  column <- column[column %in% names(tbl)]
  if (length(column) != 1L) stop("Se requiere exactamente una columna de periodo: EFT_PERIODO o PERIALFA.", call. = FALSE)
  value <- tbl[[column]]
  if (is.logical(value) || !(is.character(value) || is.factor(value) || is.numeric(value)))
    stop("El periodo debe ser texto o un codigo numerico AAAAS.", call. = FALSE)
  text <- gsub("\\s+", "", as.character(value))
  text <- gsub("^['\"]|['\"]$", "", text)
  first <- grepl("^[12]/[0-9]{4}$", text)
  last <- grepl("^[0-9]{4}/[12]$", text)
  code <- grepl("^[0-9]{4}[12]$", text)
  if (anyNA(value) || any(!(first | last | code)))
    stop("Periodo invalido; use S/AAAA, AAAA/S o AAAAS con semestre 1 o 2.", call. = FALSE)
  year <- integer(length(text)); semester <- integer(length(text))
  year[first] <- as.integer(substr(text[first], 3, 6)); semester[first] <- as.integer(substr(text[first], 1, 1))
  year[last | code] <- as.integer(substr(text[last | code], 1, 4))
  semester[last] <- as.integer(substr(text[last], 6, 6)); semester[code] <- as.integer(substr(text[code], 5, 5))
  if (any(year < 1000L)) stop("El ano debe tener cuatro digitos.", call. = FALSE)
  list(column = column, ano = year, semestre = semester, periodo = year * 10L + semester,
       canonical = if (length(year)) paste0(semester, "/", year) else character())
}

ft_member_keys <- function(tbl) {
  keys <- c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
  ft_check_table(tbl, keys)
  if (anyNA(tbl[keys])) stop("Las claves de periodo, vivienda, hogar y miembro no pueden faltar.", call. = FALSE)
  if (any(vapply(tbl[keys], function(x) any(!nzchar(trimws(as.character(x)))), logical(1)))) stop("Las claves no pueden estar vacias.", call. = FALSE)
  keys
}

ft_canonical_table <- function(tbl, member = FALSE) {
  parts <- ft_period_parts(tbl)
  if (parts$column != "EFT_PERIODO")
    stop("Este calculo requiere la estructura EFT_ de la ENFT; no se infieren equivalencias de cuestionario.", call. = FALSE)
  tbl <- as.data.frame(tbl)
  tbl$EFT_PERIODO <- parts$canonical
  if (member) ft_member_keys(tbl)
  tbl
}
