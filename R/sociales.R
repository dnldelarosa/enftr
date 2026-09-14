#' Ingreso monetario laboral por salario ocupación principal para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT. 
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ocup_prin` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ocup_prin(enft)
#' }
ft_ing_ocup_prin <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_ocup_prin = dplyr::case_when(
        EFT_PERIODO_ING_OCUP_PRINC == 1 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_HORAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 2 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_DIAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 3 ~ EFT_ING_OCUP_PRINC * 4.3,
        EFT_PERIODO_ING_OCUP_PRINC == 4 ~ EFT_ING_OCUP_PRINC * 2,
        EFT_PERIODO_ING_OCUP_PRINC == 5 ~ EFT_ING_OCUP_PRINC,
        TRUE ~ 0
      )
    )
}


#' Ingreso monetario laboral por salario ocupación secundaria para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ocup_secun` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ocup_secun(enft)
#' }
ft_ing_ocup_secun <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>%
    dplyr::mutate(
      ing_ocup_secun = dplyr::case_when(
        ano >= 2005 ~ EFT_ING_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 1 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_HORAS_SEM_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 2 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_DIAS_SEM_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 3 ~ EFT_ING_OCUP_SECUN * 4.3,
        EFT_PERIODO_ING_OCUP_SECUN == 4 ~ EFT_ING_OCUP_SECUN * 2,
        EFT_PERIODO_ING_OCUP_SECUN == 5 ~ EFT_ING_OCUP_SECUN
      ),
      ing_ocup_secun = dplyr::case_when(
        is.na(ing_ocup_secun) ~ 0,
        TRUE ~ ing_ocup_secun
      )
    )
}


#' Ingreso monetario laboral por comisiones para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_comisiones` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_comisiones(enft)
#' }
ft_ing_comisiones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_comisiones = dplyr::case_when(
      is.na(EFT_MES_PASADO_COMISIONES) ~ 0,
      TRUE ~ EFT_MES_PASADO_COMISIONES
    )
    )
}


#' Ingreso monetario laboral por propinas para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl  [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_propinas` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_propinas(enft)
#' }
ft_ing_propinas <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_propinas = dplyr::case_when(
        is.na(EFT_MES_PASADO_PROPINAS) ~ 0,
        TRUE ~ EFT_MES_PASADO_PROPINAS
      )
      )
}


#' Ingreso monetario laboral por horas extras para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_horas_extras` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_horas_extras(enft)
#' }
ft_ing_horas_extras <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_horas_extras = dplyr::case_when(
        is.na(EFT_MES_PASADO_HORAS_EXTRAS) ~ 0,
        TRUE ~ EFT_MES_PASADO_HORAS_EXTRAS
      )
      )
}


#' Ingreso monetario laboral por vacaciones para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_vacaciones` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_vacaciones(enft)
#' }
ft_ing_vacaciones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_vacaciones = dplyr::case_when(
        is.na(EFT_ULT_DOCE_VACACIONES_PAGAS) ~ 0,
        TRUE ~ EFT_ULT_DOCE_VACACIONES_PAGAS / 12
      )
      )
}


#' Ingreso monetario laboral por dividendos para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_dividendos` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_dividendos(enft)
#' }
ft_ing_dividendos <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_dividendos = dplyr::case_when(
        is.na(EFT_ULT_DOCE_DIVIDENDOS) ~ 0,
        TRUE ~ EFT_ULT_DOCE_DIVIDENDOS / 12
      )
      )
}


#' Ingreso monetario laboral por bonificaciones para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_bonificaciones` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_bonificaciones(enft)
#' }
ft_ing_bonificaciones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_bonificaciones = dplyr::case_when(
        is.na(EFT_ULT_DOCE_BONIFICACION) ~ 0,
        TRUE ~ EFT_ULT_DOCE_BONIFICACION / 12
      )
      )
}


#' Ingreso monetario laboral por regalía pascual para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_regalia_pascual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_regalia_pascual(enft)
#' }
ft_ing_regalia_pascual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_regalia_pascual = dplyr::case_when(
        is.na(EFT_ULT_DOCE_REGALIA_PASCUAL) ~ 0,
        TRUE ~ EFT_ULT_DOCE_REGALIA_PASCUAL / 12
      )
      )
}


#' Ingreso monetario laboral por utilidades empresariales para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_utilidades_empresariales` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_utilidades_empresariales(enft)
#' }
ft_ing_utilidades_empresariales <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_utilidades_empresariales = dplyr::case_when(
        is.na(EFT_ULT_DOCE_UTILIDADES_EMP) ~ 0,
        TRUE ~ EFT_ULT_DOCE_UTILIDADES_EMP / 12
      )
      )
}


#' Ingreso monetario laboral por beneficios marginales para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_beneficios_marginales` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_beneficios_marginales(enft)
#' }
ft_ing_beneficios_marginales <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_beneficios_marginales = dplyr::case_when(
        is.na(EFT_ULT_DOCE_BENEFICIOS_MARG) ~ 0,
        TRUE ~ EFT_ULT_DOCE_BENEFICIOS_MARG / 12
      )
      )
}


#' Ingreso no monetario laboral en alimentos para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_alimentos` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_alimentos(enft)
#' }
ft_ing_especie_alimentos <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_alimentos = dplyr::case_when(
         is.na(EFT_PAGO_ALIMENTOS_MONTO) ~ 0,
        !is.na(EFT_PAGO_ALIMENTOS_MONTO) ~ EFT_PAGO_ALIMENTOS_MONTO
      )
      )
}


#' Ingreso no monetario laboral en vivienda para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_vivienda` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_vivienda(enft)
#' }
ft_ing_especie_viviendas <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_viviendas = dplyr::case_when(
        is.na(EFT_PAGO_VIVIENDAS_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_VIVIENDAS_MONTO
      )
      )
}


#' Ingreso no monetario laboral en transporte para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_transporte` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_transporte(enft)
#' }
ft_ing_especie_transporte <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_transporte = dplyr::case_when(
        is.na(EFT_PAGO_TRANSPORTE_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_TRANSPORTE_MONTO
      )
      )
}


#' Ingreso no monetario laboral en vestido o calzado para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_vestido` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_vestido(enft)
#' }
ft_ing_especie_vestido <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_vestido = dplyr::case_when(
        is.na(EFT_PAGO_VESTIDO_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_VESTIDO_MONTO / 12
      )
      )
}


#' Ingreso no monetario laboral en celulares para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_celulares` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_celulares(enft)
#' }
ft_ing_especie_celulares <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_celulares = dplyr::case_when(
        is.na(EFT_PAGO_COMUNICACION_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_COMUNICACION_MONTO
      )
      )
}


#' Ingreso no monetario laboral en otros servicios para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_otros` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_otros(enft)
#' }
ft_ing_especie_otros <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_otros = dplyr::case_when(
        is.na(EFT_PAGO_OTROS_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_OTROS_MONTO
      )
      )
}


#' Ingreso no monetario no laboral por autoconsumo o autosuministro para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_auto` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_auto(enft)
#' }
ft_ing_especie_auto <- function(tbl) {
  EFT_BIENES_CONSUMO_MENSUAL <- NULL
  EFT_BIENES_CONSUMO_ANUAL <- NULL
  tbl %>%
    dplyr::mutate(
      ing_especie_auto = dplyr::if_else(is.na(EFT_BIENES_CONSUMO_MENSUAL), 0, EFT_BIENES_CONSUMO_MENSUAL) + dplyr::if_else(is.na(EFT_BIENES_CONSUMO_ANUAL), 0, EFT_BIENES_CONSUMO_ANUAL) / 12
    )
}


#' Ingreso no monetario no laboral imputado por uso de vivienda propia para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_imputado_vivienda_propia` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_imputado_vivienda_propia(enft)
#' }
ft_ing_imputado_vivienda_propia <- function(tbl) {
  canonical <- ft_income_table(tbl, TRUE)
  ft_numeric(canonical, c("EFT_MONTO_PROBABLE_ALQ", "EFT_PARENTESCO_CON_JEFE"))
  ids <- ft_key_id(canonical, ft_keys[1:3])
  head <- canonical$EFT_PARENTESCO_CON_JEFE == 1
  if (anyNA(head) || any(vapply(split(head, ids), sum, numeric(1)) != 1)) stop("Se requiere exactamente un jefe por hogar.", call. = FALSE)
  value <- if (nrow(canonical)) stats::ave(canonical$EFT_MONTO_PROBABLE_ALQ, ids, FUN = function(x) if (all(is.na(x))) NA_real_ else mean(x, na.rm = TRUE)) else numeric()
  tbl$ing_imputado_vivienda_propia <- ifelse(head, value, 0)
  tbl
}


#' Ingreso monetario no laboral por alquiler o renta de prepiedades para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_alqui_renta_propiedades` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_alqui_renta_propiedades(enft)
#' }
ft_ing_alqui_renta_propiedades <- function(tbl) {
  EFT_MONTO_ALQUILER_ING_NAC <- NULL
  tbl %>%
    dplyr::mutate(
      ing_alqui_renta_propiedades = dplyr::if_else(is.na(EFT_MONTO_ALQUILER_ING_NAC), 0, EFT_MONTO_ALQUILER_ING_NAC)
      )
}


#' Ingreso monetario no laboral por intereses o alquileres del exterior para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#' @param ing_ext [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ext_intereses_alquiler` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ext_intereses_alquiler(enft, ing_ext)
#' }
ft_ing_ext_intereses_alquiler <- function(tbl, ing_ext = tbl) {
  ft_external_income(tbl, ing_ext, "EFT_MONTO_ING_INTERES_MES", "EFT_MONEDA_ING_INTERES_MES", "ing_ext_intereses_alquiler")
}


#' Ingreso monetario no laboral por intereses o dividendos para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_intereses_dividendo` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_intereses_dividendo(enft)
#' }
ft_ing_intereses_dividendo <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_intereses_dividendo =  dplyr::case_when(
        is.na(EFT_MONTO_INTERES_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_INTERES_ING_NAC
      )
      )
}


#' Ingreso monetario no laboral por pensión o jubilación para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_pension_jubilacion` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_pension_jubilacion(enft)
#' }
ft_ing_pension_jubilacion <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_pension_jubilacion = dplyr::case_when(
        is.na(EFT_MONTO_PENSION_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_PENSION_ING_NAC
      )
      )
}


#' Ingreso monetario no laboral por pensión del exterior para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#' @param ing_ext [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ext_pension` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ext_pension(enft, ing_ext)
#' }
ft_ing_ext_pension <- function(tbl, ing_ext = tbl) {
  ft_external_income(tbl, ing_ext, "EFT_MONTO_ING_PENSION_MES", "EFT_MONEDA_ING_PENSION_MES", "ing_ext_pension")
}


#' Ingreso monetario no laboral por ayuda del gobierno para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ayuda_gobierno` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ayuda_gobierno(enft)
#' }
ft_ing_ayuda_gobierno <- function(tbl) {
  EFT_MONTO_GOBIERNO_ING_NAC <- NULL
  tbl %>%
    dplyr::mutate(ing_ayuda_gobierno = dplyr::if_else(is.na(EFT_MONTO_GOBIERNO_ING_NAC), 0, EFT_MONTO_GOBIERNO_ING_NAC))
}


#' Ingreso monetario no laboral por remesas nacionales para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_remesas_nac` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_remesas_nac(enft)
#' }
ft_ing_remesas_nac <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_remesas_nac = dplyr::case_when(
        is.na(EFT_MONTO_REMESAS_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_REMESAS_ING_NAC
      )
      )
}


#' Ingreso monetario no laboral por remesas del exterior para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#' @param remesas [data.frame] el data.frame con los datos de la tabla de remesas.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#' @param ing_ext [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_remesas_ext` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_remesas_ext(enft, remesas, ing_ext)
#' }
ft_ing_remesas_ext <- function(tbl, remesas = tbl, ing_ext = tbl) {
  ft_remittance_income(tbl, remesas, ing_ext)
}

#' Ingreso monetario no laboral anual por pensión para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_pension_anual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#'   enft <- ft_ing_pension_anual(enft)
#' }
ft_ing_pension_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_pension_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_PENSION) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_PENSION / 12
      )
      )
}


#' Ingreso monetario no laboral anual por intereses para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_interes_anual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#'  enft <- ft_ing_interes_anual(enft)
#' }
ft_ing_interes_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_interes_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_INTERES) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_INTERES / 12
      )
      )
}

#' Ingreso monetario no laboral anual por alquiler para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_alquiler_anual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_alquiler_anual(enft)
#' }
ft_ing_alquiler_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_alquiler_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_ALQUILER) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_ALQUILER / 12
      )
      )
}

#' Ingreso monetario no laboral anual por remesas para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_remesas_anual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_remesas_anual(enft)
#' }
ft_ing_remesas_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_remesas_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_REMESAS) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_REMESAS / 12
      )
      )
}

#' Ingreso monetario no laboral anual ocasionales para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ocasion_anual` agregrada.
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_ocasion_anual(enft)
#' }
ft_ing_ocasion_anual <- function(tbl) {
  EFT_ANIO_PASADO_MONTO_OCASION <- NULL
  tbl %>%
    dplyr::mutate(ing_ocasion_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_OCASION), 0, EFT_ANIO_PASADO_MONTO_OCASION))
}

#' Ingreso monetario no laboral anual por ayuda gobierno para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_gobierno_anual` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_gobierno_anual(enft)
#' }
ft_ing_gobierno_anual <- function(tbl) {
  EFT_ANIO_PASADO_MONTO_GOBIERNO <- NULL
  tbl %>%
    dplyr::mutate(ing_gobierno_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_GOBIERNO), 0, EFT_ANIO_PASADO_MONTO_GOBIERNO/12))
}

#' Ingreso monetario no laboral anual por otros ingresos para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_otros_anual` agregrada.
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_otros_anual(enft)
#' }
ft_ing_otros_anual <- function(tbl) {
  EFT_ANIO_PASADO_MONTO_OTROS <- NULL
  EFT_ANIO_PASADO_AYUD_INS_MONTO <- NULL
  tbl %>%
    dplyr::mutate(
      ing_otros_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_OTROS), 0, EFT_ANIO_PASADO_MONTO_OTROS) / 12 +
        dplyr::if_else(is.na(EFT_ANIO_PASADO_AYUD_INS_MONTO), 0, EFT_ANIO_PASADO_AYUD_INS_MONTO) / 12
    )
}


#ft_ing_adicionales <- function(tbl) {
#  tbl %>%
#    ft_ing_pension_anual() %>%
#    ft_ing_interes_anual() %>%
#    ft_ing_alquiler_anual() %>%
#    ft_ing_remesas_anual() %>%
#    ft_ing_ocasion_anual() %>%
#    ft_ing_gobierno_anual() %>%
#    ft_ing_otros_anual() %>%
#    dplyr::mutate(
#      ing_adicionales = ing_pension_anual +
#        ing_interes_anual +
#        ing_alquiler_anual +
#        ing_remesas_anual +
#        ing_ocasion_anual +
#        ing_gobierno_anual +
#        ing_otros_anual
#    )
#}


#' Ingreso no monetario no laboral por ayuda de empresa, familiares u ONG para el cálculo de pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_especie_ayuda_ong` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_especie_ayuda_ong(enft)
#' }
ft_ing_especie_ayuda_ong <- function(tbl) {
  EFT_AYUDA_FAMILIARES_ANUAL <- NULL
  EFT_AYUDA_FAMILIARES_MENSUAL <- NULL
  EFT_ESPECIE_FAMILIARES_ANO_VAL <- NULL
  EFT_ESPECIE_FAMILIARES_MES_VAL <- NULL
  EFT_ESPECIE_EMPRESAS_ANO_VAL <- NULL
  EFT_ESPECIE_EMPRESAS_MES_VAL <- NULL
  EFT_ESPECIE_GOBIERNO_ANO_VAL <- NULL
  EFT_ESPECIE_GOBIERNO_MES_VAL <- NULL
  EFT_ESPECIE_OTROS_VAL <- NULL
  ing_ayuda_familiares <- NULL
  ing_ayuda_especie_familiares <- NULL
  ing_ayuda_especie_empresas <- NULL
  ing_ayuda_especie_gob <- NULL
  ing_ayuda_especie_otros <- NULL
  tbl %>%
    dplyr::mutate(
      ing_ayuda_familiares = dplyr::if_else(
        dplyr::if_else(
          is.na(EFT_AYUDA_FAMILIARES_ANUAL),
          0,
          EFT_AYUDA_FAMILIARES_ANUAL
        ) == (
          dplyr::if_else(
            is.na(EFT_AYUDA_FAMILIARES_MENSUAL),
            0,
            EFT_AYUDA_FAMILIARES_MENSUAL
          ) * 12
        ),
        dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_MENSUAL), 0, EFT_AYUDA_FAMILIARES_MENSUAL),
        dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_MENSUAL), 0, EFT_AYUDA_FAMILIARES_MENSUAL) + dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_ANUAL), 0, EFT_AYUDA_FAMILIARES_ANUAL) / 12
      ),
      ing_ayuda_especie_familiares = dplyr::if_else(
        dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_ANO_VAL), 0, EFT_ESPECIE_FAMILIARES_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 0, EFT_ESPECIE_FAMILIARES_MES_VAL) * 12),
        dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 0, EFT_ESPECIE_FAMILIARES_MES_VAL),
        dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 0, EFT_ESPECIE_FAMILIARES_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_ANO_VAL), 0, EFT_ESPECIE_FAMILIARES_ANO_VAL) / 12
      ),
      ing_ayuda_especie_empresas = dplyr::if_else(
        dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_ANO_VAL), 0, EFT_ESPECIE_EMPRESAS_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 0, EFT_ESPECIE_EMPRESAS_MES_VAL) * 12),
        dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 0, EFT_ESPECIE_EMPRESAS_MES_VAL),
        dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 0, EFT_ESPECIE_EMPRESAS_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_ANO_VAL), 0, EFT_ESPECIE_EMPRESAS_ANO_VAL) / 12
      ),
      ing_ayuda_especie_gob = dplyr::if_else(
        dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_ANO_VAL), 0, EFT_ESPECIE_GOBIERNO_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 0, EFT_ESPECIE_GOBIERNO_MES_VAL) * 12),
        dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 0, EFT_ESPECIE_GOBIERNO_MES_VAL),
        dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 0, EFT_ESPECIE_GOBIERNO_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_ANO_VAL), 0, EFT_ESPECIE_GOBIERNO_ANO_VAL) / 12
      ),
      ing_ayuda_especie_otros = dplyr::if_else(is.na(EFT_ESPECIE_OTROS_VAL), 0, EFT_ESPECIE_OTROS_VAL),
      ing_especie_ayuda_ong = dplyr::if_else(is.na(ing_ayuda_familiares), 0, ing_ayuda_familiares) +
        dplyr::if_else(is.na(ing_ayuda_especie_familiares), 0, ing_ayuda_especie_familiares) +
        dplyr::if_else(is.na(ing_ayuda_especie_empresas), 0, ing_ayuda_especie_empresas) +
        dplyr::if_else(is.na(ing_ayuda_especie_gob), 0, ing_ayuda_especie_gob) +
        dplyr::if_else(is.na(ing_ayuda_especie_otros), 0, ing_ayuda_especie_otros)
    )
}


#' Ingreso monetario no laboral ocasional nacional para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ocasional_nac` agregrada.
#'
#' @examples
#' \dontrun{
#'   enft <- ft_ing_ocasional_nac(enft)
#' }
ft_ing_ocasional_nac <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>% 
    dplyr::mutate(ing_ocasional_nac = dplyr::case_when(
      ano <= 2004 ~ dplyr::if_else(is.na(EFT_MONTO_OTROS_ING_NAC), 0, EFT_MONTO_OTROS_ING_NAC),
      TRUE ~ dplyr::if_else(is.na(EFT_MONTO_OCASIONAL_ING_NAC), 0, EFT_MONTO_OCASIONAL_ING_NAC)
    ))
}


#' Ingreso monetario no laboral ocasional del exterior para el cálculo de pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#' @param ing_ext  [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_ocasional_ext` agregrada.
#'
#' @examples
#' \dontrun{
#'  enft <- ft_ing_ocasional_ext(enft, ing_ext)
#' }
ft_ing_ocasional_ext <- function(tbl, ing_ext) {
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  EFT_MONEDA_OTROS_ING_SEM <- NULL
  EFT_MONTO_OTROS_ING_SEM <- NULL
  cod_moneda2 <- NULL
  value <- NULL
  tipo_cambio <- NULL
  ing_ocasional_ext <- NULL
  . <- NULL
    tipo_de_cambio <- enftr::tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_OTROS_ING_SEM, EFT_MONTO_OTROS_ING_SEM) %>%
    dplyr::filter(
      !is.na(EFT_MONEDA_OTROS_ING_SEM), 
      !is.na(EFT_MONTO_OTROS_ING_SEM)
    ) %>%
    dplyr::filter(EFT_MONTO_OTROS_ING_SEM > 0) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        #tidyr::drop_na() %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_OTROS_ING_SEM = cod_moneda2, tipo_cambio = value),
        copy = TRUE,
      by = c("EFT_PERIODO", "EFT_MONEDA_OTROS_ING_SEM")
    ) %>%
    dplyr::mutate(ing_ocasional_ext = EFT_MONTO_OTROS_ING_SEM * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ocasional_ext = dplyr::if_else(EFT_PERIODO == "1/2000", sum(ing_ocasional_ext, na.rm = T) / 6, sum(ing_ocasional_ext, na.rm = T))) %>%
    #plyr::mutate(ing_ocasional_ext = dplyr::if_else(is.na(ing_ocasional_ext), 0, ing_ocasional_ext)) %>%
    dplyr::left_join(
      tbl,
      .,
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
      ) %>%
    dplyr::ungroup()
}


#' Ingreso no monetario no laboral por regalos del exterior para el cálculo de pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#' @param ing_ext [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_regalos_ext` agregrada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_regalos_ext(enft, ing_ext)
#' }
ft_ing_regalos_ext <- function(tbl, ing_ext = tbl) {
  ft_external_income(tbl, ing_ext, "EFT_MONTO_EQUIV_REGALO", NULL, "ing_regalos_ext")
}


#' Ingreso monetario no laboral por otros ingresos para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Use datos locales; materialice previamente las consultas remotas.
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_otros` agregrada.
#'
#' @examples
#' \dontrun{
#' enft <- ft_ing_otros(enft)
#' }
ft_ing_otros <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>% 
    dplyr::mutate(ing_otros = dplyr::case_when(
      ano >= 2005 ~ dplyr::if_else(is.na(EFT_MONTO_OTROS_ING_NAC), 0, EFT_MONTO_OTROS_ING_NAC) +
        dplyr::if_else(is.na(EFT_GOB_AYUDA_INST_MONTO), 0, EFT_GOB_AYUDA_INST_MONTO),
      TRUE ~ 0
    ))
}
