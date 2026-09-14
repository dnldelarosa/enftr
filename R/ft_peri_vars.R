#' Separar y validar el periodo semestral de la ENFT
#'
#' Acepta S/AAAA, AAAA/S o AAAAS; reconoce EFT_PERIODO o PERIALFA.
#' Valida cada fila incluso cuando se combinan formatos. No modifica la columna
#' original salvo que rm sea TRUE. Solo recalcula las salidas solicitadas.
#' @param tbl data.frame o tibble local.
#' @param rm Retirar la columna de periodo original.
#' @param ano,semestre,periodo Agregar o actualizar cada salida solicitada.
#' @return Tabla original con las salidas solicitadas, conservando orden y filas.
#' @export
#' @examples
#' ft_peri_vars(data.frame(EFT_PERIODO = c("1/2005", "2006/2", "20161")))
ft_peri_vars <- function(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE) {
  for (name in c("rm", "ano", "semestre", "periodo")) ft_check_flag(get(name), name)
  parts <- ft_period_parts(tbl)
  if (ano) tbl$ano <- parts$ano
  if (semestre) tbl$semestre <- parts$semestre
  if (periodo) tbl$periodo <- parts$periodo
  if (rm) tbl[[parts$column]] <- NULL
  tbl
}

#' @rdname ft_peri_vars
#' @export
ft_compute_peri_vars <- function(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE) {
  lifecycle::deprecate_warn("0.2.0", "ft_compute_peri_vars()", "ft_peri_vars()")
  ft_peri_vars(tbl, rm, ano, semestre, periodo)
}

#' @rdname ft_peri_vars
#' @export
ft_compute_ano <- function(tbl) {
  lifecycle::deprecate_warn("0.3.0", "ft_compute_ano()", "ft_peri_vars()")
  ft_peri_vars(tbl, ano = TRUE, semestre = FALSE, periodo = FALSE)
}

#' @rdname ft_peri_vars
#' @export
ft_ano <- function(tbl) {
  lifecycle::deprecate_warn("0.3.0", "ft_ano()", "ft_peri_vars()")
  ft_peri_vars(tbl, ano = TRUE, semestre = FALSE, periodo = FALSE)
}
