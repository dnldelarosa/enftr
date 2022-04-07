#' Pobreza monetaria (Metodología oficial) de la República Dominicana
#' `r lifecycle::badge('experimental')`
#' 
#' Esta función utiliza los datos de la Encuesta Nacional (tradicional) de Fuerza
#' de Trabajo (ENFT) de la República Dominicana para calcular la pobreza monetaria
#' siguiendo la metodología oficial. 
#' 
#' Argumentos \code{ing_ext} y \code{remesas}: En las primeras versiones de la encuesta,
#' las variables de ingresos del exterior y remesas venían en tablas separadas,
#' por lo que se presentan argumentos para suministrar dichas tablas. Sin embargo,
#' estos argumentos apuntan por defecto a la tabla principal, por lo que de tener 
#' esta información integrada en una única tabla, se puede omitir estos argumentos.
#' 
#' NOTA: Por el momento, esta función solo calcula la pobreza monetaria en el período 2005-2016.
#' A pesar de que se han publicado documentos metodológicos para el cálculo de la pobreza
#' monetaria, la formula como tal no es pública, por lo que no se puede asegurar que los
#' resultados sean los mismos que aquellos que se obtienen con la formula oficial.
#' Aunque los resultados son bastante aproximados.
#'
#' @param tbl [data.frame]: datos de la ENFT. Puede ser conexión a base de datos.
#' @param ing_ext [data.frame]: datos de ingresos del exterior. Vea detalles.
#' @param remesas [data.frame]: datos de remesas. Vea detalles.
#' @param .keep indica si se deben mantener las variables intermedias en la data. 
#' Puede ser `TRUE` o `FALSE` (default), o un vector de characeter con las variables a mantener.
#' @param .reuse indica si se deben reutilizar las variables intermedias que estén disponibles en la data. 
#' Puede ser `TRUE` o `FALSE`(default). O un vector de characeter con las variables a reutilizar.
#'
#' @return [data.frame]: los datos del argumento `tbl` con la variable `pobreza_monetaria` agregada.
#'   Si .keep no es `FALSE` otras variables intermedias se mantienen.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#'  enft <- ft_pobreza_monetaria(enft, enft_ing_ext, enft_remesas)
#' }
ft_pobreza_monetaria <- function(tbl, ing_ext = tbl, remesas = tbl, .keep = FALSE, .reuse = FALSE) {
  ft_ing_pc_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse) %>% 
    dplyr::left_join(enftr::lineas_oficial_zona, copy = TRUE) %>% 
    dplyr::mutate(
      pobreza_monetaria = dplyr::case_when(
        ing_pc_pobreza_monetaria <= lindigencia ~ 1,
        ing_pc_pobreza_monetaria <= lpobreza ~ 2,
        TRUE ~ 3
      )
    )
}


#' Ingreso total hogares para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @inheritParams ft_pobreza_monetaria
#'
#' @return [data.frame]: los datos del argumento `tbl` con la variable `ing_total_pobreza_monetaria` agregada.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_pobreza_monetaria(enft, enft_ing_ext, enft_remesas)
#' }
ft_ing_total_pobreza_monetaria <- function(tbl, ing_ext = tbl, remesas = tbl, .keep = FALSE, .reuse = FALSE){
ing_ocup_prin <- NULL
ing_comisiones <- NULL
ing_propinas <- NULL
ing_horas_extras <- NULL
ing_vacaciones <- NULL
ing_dividendos <- NULL
ing_bonificaciones <- NULL
ing_regalia_pascual <- NULL
ing_utilidades_empresariales <- NULL
ing_beneficios_marginales <- NULL
ing_especie_alimentos <- NULL
ing_especie_viviendas <- NULL
ing_especie_transporte <- NULL
ing_especie_vestido <- NULL
ing_especie_otros <- NULL
ing_especie_celulares <- NULL
ing_ocup_secun <- NULL
ing_pension_anual <- NULL
ing_pension_jubilacion <- NULL
ing_intereses_dividendo <- NULL
ing_interes_anual <- NULL
ing_alqui_renta_propiedades <- NULL
ing_alquiler_anual <- NULL
ing_remesas_nac <- NULL
ing_remesas_anual <- NULL
ing_ayuda_gobierno <- NULL
ing_gobierno_anual <- NULL
ing_especie_ayuda_ong <- NULL
ing_especie_auto <- NULL
ing_ext_pension <- NULL
ing_ext_intereses_alquiler <- NULL
ing_regalos_ext <- NULL
ing_imputado_vivienda_propia <- NULL
ing_remesas_ext <- NULL
  ingresos <- c(
    'ing_ocup_prin',
    'ing_comisiones',
    'ing_propinas',
    'ing_horas_extras',
    'ing_vacaciones',
    'ing_dividendos',
    'ing_bonificaciones',
    'ing_regalia_pascual',
    'ing_utilidades_empresariales',
    'ing_beneficios_marginales',
    'ing_especie_alimentos',
    'ing_especie_viviendas',
    'ing_especie_transporte',
    'ing_especie_vestido',
    'ing_especie_otros',
    'ing_especie_celulares',
    'ing_ocup_secun',
    'ing_pension_anual',
    'ing_pension_jubilacion',
    'ing_intereses_dividendo',
    'ing_interes_anual',
    'ing_alqui_renta_propiedades',
    'ing_alquiler_anual',
    'ing_remesas_nac',
    'ing_remesas_anual',
    'ing_ayuda_gobierno',
    'ing_gobierno_anual',
    'ing_especie_ayuda_ong',
    'ing_especie_auto',
    'ing_ext_pension',
    'ing_ext_intereses_alquiler',
    'ing_regalos_ext',
    'ing_imputado_vivienda_propia',
    'ing_remesas_ext'
  )
  if(is.logical(.reuse)){
    if(.reuse){
      for (ingreso in ingresos) {
        if(ingreso %in% dplyr::tbl_vars(tbl)){
          ingresos <- ingresos[ingresos != ingreso]
        }
      }
    }
  } else {
    for (ingreso in .reuse) {
      ingresos <- ingresos[ingresos != ingreso]
    }
  }
  cli::cli_progress_bar("Calculando ingresos faltantes", total = length(ingresos))
  for (ingreso in ingresos) {
    if(ingreso %in% c(
      "ing_ext_pension", 
      "ing_ext_intereses_alquiler",
      "ing_regalos_ext"
      )){
      tbl <- get(paste0("ft_", ingreso))(tbl, ing_ext)
    } else if(ingreso == "ing_remesas_ext"){
      tbl <- get(paste0("ft_", ingreso))(tbl, remesas, ing_ext)
    } else {
      tbl <- get(paste0("ft_", ingreso))(tbl)
    }
    cli::cli_progress_update()
  }
  tbl <- dplyr::mutate(
    tbl,
    ing_total_pobreza_monetaria = 
      ing_ocup_prin + 
      ing_comisiones +
      ing_propinas +
      ing_horas_extras +
      ing_vacaciones +
      ing_dividendos +
      ing_bonificaciones + 
      ing_regalia_pascual + 
      ing_utilidades_empresariales +
      ing_beneficios_marginales +
      ing_especie_alimentos +           #2014
      ing_especie_viviendas + 
      ing_especie_transporte +
      ing_especie_vestido +
      ing_especie_otros +
      ing_especie_celulares +
      ing_ocup_secun +
      ing_pension_jubilacion +
      ing_pension_anual +
      ing_intereses_dividendo +
      ing_interes_anual +
      ing_alqui_renta_propiedades +
      ing_alquiler_anual +
      ing_remesas_nac +
      ing_remesas_anual +
      ing_ayuda_gobierno +           #2014
      ing_gobierno_anual +
      ing_especie_ayuda_ong +        #2014
      ing_especie_auto +             #2014, 2015, 2016
      ing_imputado_vivienda_propia + #2005, 2014, 2015
      ing_ext_pension +              #2009, 2011
      ing_ext_intereses_alquiler +
      ing_regalos_ext +
      ing_remesas_ext
  )
  if(is.logical(.keep)){
    if(.keep){
      ingresos <- c()
    }
  } else {
    for (ingreso in .keep) {
      ingresos <- ingresos[ingresos != ingreso]
    }
  }
  tbl %>% 
    dplyr::select(-dplyr::all_of(ingresos)) %>% 
    dplyr::mutate(
      ing_total_pobreza_monetaria = dplyr::case_when(
        periodo >= 20051 ~ ing_total_pobreza_monetaria
      )
    )
  }

#' Ingreso per cápita de los hogares para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @inheritParams ft_ing_total_pobreza_monetaria
#'
#' @return [data.frame] los datos del argumento `tbl` con la columna `ing_pc_pobreza_monetaria`
#' @export
#'
#' @examples
#' \dontrun{
#'  enft <- ft_ing_pc_pobreza_monetaria(enft, enft_ing_ext, enft_remesas)
#' }
ft_ing_pc_pobreza_monetaria <- function(tbl, ing_ext, remesas, .keep = FALSE, .reuse = FALSE){
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  ing_total_pobreza_monetaria <- NULL
  tbl <- ft_ing_total_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse) %>% 
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>% 
    dplyr::mutate(ing_pc_pobreza_monetaria = sum(ing_total_pobreza_monetaria, na.rm = TRUE) / dplyr::n()) %>% 
    dplyr::ungroup()
  cli::cli_progress_done()
  tbl
}


#' Ingreso monetario laboral por salario ocupación principal para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT. 
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
  EFT_PERIODO <- NULL
  EFT_VIVIENDA  <- NULL
  EFT_HOGAR <- NULL
  EFT_MONTO_PROBABLE_ALQ <- NULL
  . <- NULL
  ing_imputado_vivienda_propia <- NULL
  tbl %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>%
    dplyr::summarise(ing_imputado_vivienda_propia = mean(EFT_MONTO_PROBABLE_ALQ, na.rm = T)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(EFT_PARENTESCO_CON_JEFE = 1) %>%
    dplyr::left_join(
      tbl, 
      .,
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_PARENTESCO_CON_JEFE")
      ) %>%
    dplyr::mutate(ing_imputado_vivienda_propia = dplyr::if_else(is.na(ing_imputado_vivienda_propia), 0, ing_imputado_vivienda_propia))
}


#' Ingreso monetario no laboral por alquiler o renta de prepiedades para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
ft_ing_ext_intereses_alquiler <- function(tbl, ing_ext) {
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  EFT_MONEDA_ING_INTERES_MES <- NULL
  EFT_MONTO_ING_INTERES_MES <- NULL
  value <- NULL
  cod_moneda2 <- NULL
  ing_ext_intereses_alquiler <- NULL
  . <- NULL
  tipo_cambio <- NULL
  tipo_de_cambio <- enftr::tdc_oficial
  
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_ING_INTERES_MES, EFT_MONTO_ING_INTERES_MES) %>%
    dplyr::filter(!is.na(EFT_MONTO_ING_INTERES_MES)) %>%
    dplyr::filter(EFT_MONTO_ING_INTERES_MES > 0) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        dplyr::filter(!is.na(value)) %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_ING_INTERES_MES = cod_moneda2, tipo_cambio = value),
      copy = TRUE,
      by = c("EFT_PERIODO", "EFT_MONEDA_ING_INTERES_MES")
    ) %>%
    dplyr::mutate(ing_ext_intereses_alquiler = EFT_MONTO_ING_INTERES_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_intereses_alquiler = sum(ing_ext_intereses_alquiler, na.rm = T)) %>%
    dplyr::left_join(
      tbl, 
      .,
      copy = TRUE,
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
      ) %>%
    dplyr::mutate(ing_ext_intereses_alquiler = dplyr::if_else(is.na(ing_ext_intereses_alquiler), 0, ing_ext_intereses_alquiler)) %>%
    dplyr::ungroup()
}


#' Ingreso monetario no laboral por intereses o dividendos para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
ft_ing_ext_pension <- function(tbl, ing_ext) {
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  EFT_MONEDA_ING_PENSION_MES <- NULL
  EFT_MONTO_ING_PENSION_MES <- NULL
  value <- NULL
  cod_moneda2 <- NULL
  ing_ext_pension <- NULL
  tipo_cambio <- NULL
  . <- NULL
    tipo_de_cambio <- enftr::tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_ING_PENSION_MES, EFT_MONTO_ING_PENSION_MES) %>%
    dplyr::filter(!is.na(EFT_MONTO_ING_PENSION_MES)) %>%
    dplyr::filter(EFT_MONTO_ING_PENSION_MES > 0) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        dplyr::filter(!is.na(value)) %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_ING_PENSION_MES = cod_moneda2, tipo_cambio = value),
      copy = TRUE,
      by = c("EFT_PERIODO", "EFT_MONEDA_ING_PENSION_MES")
    ) %>%
    dplyr::mutate(ing_ext_pension = EFT_MONTO_ING_PENSION_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_pension = sum(ing_ext_pension, na.rm = T)) %>%
    dplyr::left_join(
      tbl,
      .,
      copy = TRUE,
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
      ) %>%
    dplyr::mutate(ing_ext_pension = dplyr::if_else(is.na(ing_ext_pension), 0, ing_ext_pension)) %>%
    dplyr::ungroup()
}


#' Ingreso monetario no laboral por ayuda del gobierno para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
ft_ing_remesas_ext <- function(tbl, remesas, ing_ext) {
  remesas_a <- NULL
  remesas_b <- NULL
  tbl %>%
    dplyr::left_join(
      ft_ing_remesas_ext_20001(ing_ext),
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
    ) %>%
    dplyr::left_join(
      ft_ing_remesas_ext_20002_20162(remesas),
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
    ) %>%
    dplyr::mutate(
      ing_remesas_ext = dplyr::if_else(is.na(remesas_a), 0, remesas_a) +
        dplyr::if_else(is.na(remesas_b), 0, remesas_b)
    )
}

#' Ingreso monetario no laboral por remesas del exterior 2000/1 para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param ing_ext [data.frame] el data.frame con los datos de la tabla de ingresos externos.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `ing_ext` con la columna `remesas_a` agregrada.
ft_ing_remesas_ext_20001 <- function(ing_ext) {
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  EFT_RECIBIO_ING_REMESA_SEM <- NULL
  EFT_FREC_ING_REMESA_SEM <- NULL
  EFT_MONTO_ING_REMESA_SEM <- NULL
  EFT_MONEDA_ING_REMESA_SEM <- NULL
  value <- NULL
  cod_moneda2 <- NULL
  remesas <- NULL
  tipo_cambio <- NULL
    tipo_de_cambio <- enftr::tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_RECIBIO_ING_REMESA_SEM, EFT_FREC_ING_REMESA_SEM, EFT_MONTO_ING_REMESA_SEM, EFT_MONEDA_ING_REMESA_SEM) %>%
    dplyr::filter(EFT_PERIODO == "1/2000", EFT_RECIBIO_ING_REMESA_SEM == 1) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        dplyr::filter(date == as.Date("2000-03-31")) %>%
        dplyr::select(tipo_cambio = value, cod_moneda2) %>%
        dplyr::mutate(EFT_PERIODO = "1/2000") %>%
        tidyr::drop_na(),
      by = c("EFT_PERIODO", "EFT_MONEDA_ING_REMESA_SEM" = "cod_moneda2"),
      copy = TRUE
    ) %>%
    dplyr::mutate(remesas = EFT_MONTO_ING_REMESA_SEM * tipo_cambio / 6) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(remesas_a = sum(remesas, na.rm = TRUE)) %>% 
    dplyr::ungroup()
}

#' Ingreso monetario no laboral por remesas del exterior 2000/2 a 2016/2 para el cálculo de la pobreza monetaria
#' `r lifecycle::badge('experimental')`
#'
#' @param remesas [data.frame] el data.frame con los datos de la tabla de remesas.
#' Vea detalles en la función \link{ft_pobreza_monetaria}.
#'
#' @return [data.frame] los datos del argumento `remesas` con la columna `remesas_b` agregrada.
ft_ing_remesas_ext_20002_20162 <- function(remesas) {
  periodo <- NULL
  EFT_RECIBIO_REMESA <- NULL
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  name <- NULL
  monto <- NULL
  moneda <- NULL
  frecuencia <- NULL
  ano <- NULL
  mes <- NULL
  cod_moneda2 <- NULL
  value <- NULL
    tipo_de_cambio <- enftr::tdc_oficial
    ipc <- enftr::ipc_oficial
  
  remesas <- remesas %>%
    ft_peri_vars() %>%
    dplyr::filter(
      periodo >= 20002,
      EFT_RECIBIO_REMESA == 1
      )
  

  remesas %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONTO")) %>%
    tidyr::pivot_longer(dplyr::starts_with("EFT_MONTO"), values_to = "monto", names_prefix = "EFT_MONTO_") %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, name) %>% 
    dplyr::mutate(monto = dplyr::first(monto)) %>% 
    dplyr::distinct() %>% 
    dplyr::ungroup() %>% 
    dplyr::left_join(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONEDA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_MONEDA"), values_to = "moneda", names_prefix = "EFT_MONEDA_") %>%
        dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, name) %>% 
        dplyr::mutate(moneda = dplyr::first(moneda)) %>% 
        dplyr::distinct() %>% 
        dplyr::ungroup(),
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO", "name")
      ) %>%
    dplyr::left_join(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_FRECUENCIA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_FRECUENCIA"), values_to = "frecuencia", names_prefix = "EFT_FRECUENCIA_") %>%
        dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, name) %>% 
        dplyr::mutate(frecuencia = dplyr::first(frecuencia)) %>% 
        dplyr::distinct() %>% 
        dplyr::ungroup(),
      by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO", "name")
      ) %>%
    dplyr::filter(!is.na(monto), monto > 0) %>% 
    ft_peri_vars() %>% 
    dplyr::mutate(
      mes = dplyr::case_when(
        semestre == 1 & name == "SEP" ~ 3,
        semestre == 1 & name == "AGO" ~ 2,
        semestre == 1 & name == "JUL" ~ 1,
        semestre == 1 & name == "PER4" ~ 12,
        semestre == 1 & name == "PER5" ~ 11,
        semestre == 1 & name == "PER6" ~ 10,
        semestre == 2 & name == "SEP" ~ 9,
        semestre == 2 & name == "AGO" ~ 8,
        semestre == 2 & name == "JUL" ~ 7,
        semestre == 2 & name == "PER4" ~ 6,
        semestre == 2 & name == "PER5" ~ 5,
        semestre == 2 & name == "PER6" ~ 4
      )
    ) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(ano, mes, moneda = cod_moneda2, tipo_cambio = value),
      copy = TRUE,
      by = c("moneda", "ano", "mes")
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(periodo = as.double(paste0(lubridate::year(date), lubridate::semester(date)))) %>%
        dplyr::select(periodo, ipc_mes_encuesta = ipc),
      copy = TRUE,
      by = "periodo"
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(-date),
      copy = TRUE,
      by = c("ano", "mes")
    ) %>%
    dplyr::mutate(
      remesas = dplyr::case_when(
        periodo == 20001 ~ as.double(NA),
        periodo <= 20071 ~ (monto * frecuencia * tipo_cambio * (ipc_mes_encuesta / ipc)) / 12,
        periodo >= 20072 ~  monto * tipo_cambio * (ipc_mes_encuesta / ipc) / 6
      ) 
      ) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(remesas_b = sum(remesas, na.rm = T)) %>%
    dplyr::ungroup()
}


#' Ingreso monetario no laboral anual por pensión para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
#' Puede ser conexión a base de datos.
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
ft_ing_regalos_ext <- function(tbl, ing_ext) {
  EFT_PERIODO <- NULL
  EFT_VIVIENDA <- NULL
  EFT_HOGAR <- NULL
  EFT_MIEMBRO <- NULL
  EFT_MONTO_EQUIV_REGALO <- NULL
  ing_regalos_ext <- NULL
  tbl %>% 
    dplyr::left_join(
  ing_ext %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_regalos_ext = sum(EFT_MONTO_EQUIV_REGALO, na.rm = TRUE)) %>%
    dplyr::ungroup(),
  by = c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")
    ) %>% 
    dplyr::mutate(ing_regalos_ext = dplyr::if_else(is.na(ing_regalos_ext), 0, ing_regalos_ext))
}


#' Ingreso monetario no laboral por otros ingresos para el cálculo de pobreza monetaria
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] el data.frame con los datos de la ENFT.
#' Puede ser conexión a base de datos.
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


##ft_ing_total_oficial <- function(tbl, ing_ext, remesas) {
##
##  # Ingresos convencionales
##  tbl <- ft_ing_ocup_prin(tbl)
##  tbl <- ft_ing_ocup_secun(tbl)
##  tbl <- ft_ing_alqui_renta_propiedades(tbl)
##  tbl <- ft_ing_ext_intereses_alquiler(tbl, ing_ext, metodo = metodo)
##  tbl <- ft_ing_intereses_dividendo(tbl)
##  tbl <- ft_ing_pension_jubilacion(tbl)
##  tbl <- ft_ing_ext_pension(tbl, ing_ext, metodo = metodo)
##  tbl <- ft_ing_ayuda_gobierno(tbl)
##  tbl <- ft_ing_remesas_nac(tbl)
##  tbl <- ft_ing_remesas_ext(tbl, remesas, ing_ext, metodo = metodo)
##  tbl <- ft_ing_ocasional_nac(tbl)
##  tbl <- ft_ing_ocasional_ext(tbl, ing_ext, metodo = metodo)
##  tbl <- ft_ing_regalos_ext(tbl, ing_ext)
##  tbl <- ft_ing_otros(tbl)
##  # Ingresos adicionales
##  tbl <- ft_ing_comisiones(tbl)
##  tbl <- ft_ing_propinas(tbl)
##  tbl <- ft_ing_horas_extras(tbl)
##  tbl <- ft_ing_vacaciones(tbl)
##  tbl <- ft_ing_dividendos(tbl)
##  tbl <- ft_ing_bonificaciones(tbl)
##  tbl <- ft_ing_regalia_pascual(tbl)
##  tbl <- ft_ing_utilidades_empresariales(tbl)
##  tbl <- ft_ing_beneficios_marginales(tbl)
##  tbl <- ft_ing_especie_alimentos(tbl)
##  tbl <- ft_ing_especie_viviendas(tbl)
##  tbl <- ft_ing_especie_celulares(tbl)
##  tbl <- ft_ing_especie_transporte(tbl)
##  tbl <- ft_ing_especie_vestido(tbl)
##  tbl <- ft_ing_especie_otros(tbl)
##  tbl <- ft_ing_especie_auto(tbl)
##  tbl <- ft_ing_especie_ayuda_ong(tbl)
##  tbl <- ft_ing_adicionales(tbl)
##
##  tbl <- ft_ing_imputado_vivienda_propia(tbl)
##
##  tbl <- tbl %>%
##    dplyr::left_join(
##      ipc_oficial %>%
##        filter(lubridate::month(date) %in% c(4, 10)) %>%
##        dplyr::mutate(
##          semestre = lubridate::semester(date),
##          ano = lubridate::year(date)
##        ) %>%
##        dplyr::select(-date) %>%
##        dplyr::rename("ipc_mes_encuesta" = "ipc")
##    ) %>%
##    dplyr::left_join(
##      ipc_oficial %>%
##        filter(lubridate::month(date) %in% c(3, 9)) %>%
##        dplyr::mutate(
##          semestre = lubridate::semester(date),
##          ano = lubridate::year(date)
##        ) %>%
##        dplyr::select(-date) %>%
##        dplyr::rename("ipc_mes_anterior_encuesta" = "ipc")
##    )
##
##  tbl <- tbl %>%
##    dplyr::mutate(
##      dplyr::across(
##        dplyr::all_of(index),
##        ~.x * (ipc_mes_anterior_encuesta/ipc_mes_encuesta)
##      )
##    )
##
##  tbl <- tbl %>%
##    dplyr::mutate(
##      ing_convencional_pobreza = 
##        ing_ocup_prin + 
##        ing_ocup_secun +
##        ing_alqui_renta_propiedades + 
##        ing_ext_intereses_alquiler + 
##        ing_intereses_dividendo +
##        ing_pension_jubilacion + 
##        ing_ext_pension + 
##        ing_ayuda_gobierno +
##        ing_remesas_nac + 
##        ing_remesas_ext + 
##        ing_ocasional_nac +
##        ing_ocasional_ext + 
##        tidyr::replace_na(ing_regalos_ext, 0) + 
##        ing_otros
##    )
##  tbl <- tbl %>%
##    dplyr::mutate(
##      ing_adicional_pobreza = 
##        ing_comisiones + 
##        ing_propinas +
##        ing_horas_extras + 
##        ing_vacaciones + 
##        ing_dividendos +
##        ing_bonificaciones + 
##        ing_regalia_pascual +
##        ing_utilidades_empresariales + 
##        ing_beneficios_marginales +
##        ing_especie_alimentos + 
##        ing_especie_viviendas + 
##        ing_especie_transporte +
##        ing_especie_vestido + 
##        ing_especie_celulares + 
##        ing_especie_otros + 
##        ing_especie_auto +
##        ing_adicionales + 
##        ing_especie_ayuda_ong
##    )
##  tbl <- tbl %>%
##    dplyr::mutate(
##      ing_total_oficial = ing_convencional_pobreza +
##        ing_imputado_vivienda_propia +
##        ing_adicional_pobreza,
##      ing_total_recomendado = ing_total_oficial -
##        ing_ocasional_nac - ing_ocasional_ext
##    )
##  if (metodo == "m") {
##    tbl <- tbl %>%
##      dplyr::mutate(
##        ing_total_recomendado = ing_total_recomendado - ing_especie_ayuda_ong -
##          ing_regalos_ext - ing_otros
##      )
##  }
##  tbl
##}
