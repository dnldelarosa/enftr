#' Cálculo de pobreza monetaria con metodología oficial
#' `r lifecycle::badge('experimental')`
#'
#' @param conn conexión a la base de datos
#' @param name nombre de la tabla en la base de datos
#'
#' @return data.frame con los datos de la tabla
#'
#' @export
#'
#' @details Por el momento, carga los datos desde una tabla
#' en la base de datos.
#'
#' @examples
#' \dontrun{
#' pobreza_monetaria <- pobreza_monetaria(conn, "pobreza_monetaria")
#' }
ft_pobreza_monetaria <- function(tbl, ing_ext, remesas, .keep = FALSE, .reuse = FALSE) {
  ft_ing_pc_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse) %>% 
    dplyr::left_join(lineas_oficial_zona, copy = TRUE) %>% 
    dplyr::mutate(
      pobreza_monetaria = case_when(
        ing_pc_pobreza_monetaria <= lindigencia ~ 1,
        ing_pc_pobreza_monetaria <= lpobreza ~ 2,
        TRUE ~ 3
      )
    )
}


ft_ing_total_pobreza_monetaria <- function(tbl, ing_ext, remesas, .keep = FALSE, .reuse = FALSE){
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
    dplyr::select(-dplyr::all_of(ingresos))
  }

ft_ing_pc_pobreza_monetaria <- function(tbl, ing_ext, remesas, .keep = FALSE, .reuse = FALSE){
  tbl <- ft_ing_total_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse) %>% 
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>% 
    dplyr::mutate(ing_pc_pobreza_monetaria = sum(ing_total_pobreza_monetaria, na.rm = TRUE) / n()) %>% 
    dplyr::ungroup()
  cli::cli_progress_done()
  tbl
}


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


ft_ing_comisiones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_comisiones = dplyr::case_when(
      is.na(EFT_MES_PASADO_COMISIONES) ~ 0,
      TRUE ~ EFT_MES_PASADO_COMISIONES
    )
    )
}


ft_ing_propinas <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_propinas = dplyr::case_when(
        is.na(EFT_MES_PASADO_PROPINAS) ~ 0,
        TRUE ~ EFT_MES_PASADO_PROPINAS
      )
      )
}


ft_ing_horas_extras <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_horas_extras = dplyr::case_when(
        is.na(EFT_MES_PASADO_HORAS_EXTRAS) ~ 0,
        TRUE ~ EFT_MES_PASADO_HORAS_EXTRAS
      )
      )
}


ft_ing_vacaciones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_vacaciones = dplyr::case_when(
        is.na(EFT_ULT_DOCE_VACACIONES_PAGAS) ~ 0,
        TRUE ~ EFT_ULT_DOCE_VACACIONES_PAGAS / 12
      )
      )
}


ft_ing_dividendos <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_dividendos = dplyr::case_when(
        is.na(EFT_ULT_DOCE_DIVIDENDOS) ~ 0,
        TRUE ~ EFT_ULT_DOCE_DIVIDENDOS / 12
      )
      )
}


ft_ing_bonificaciones <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_bonificaciones = dplyr::case_when(
        is.na(EFT_ULT_DOCE_BONIFICACION) ~ 0,
        TRUE ~ EFT_ULT_DOCE_BONIFICACION / 12
      )
      )
}


ft_ing_regalia_pascual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_regalia_pascual = dplyr::case_when(
        is.na(EFT_ULT_DOCE_REGALIA_PASCUAL) ~ 0,
        TRUE ~ EFT_ULT_DOCE_REGALIA_PASCUAL / 12
      )
      )
}


ft_ing_utilidades_empresariales <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_utilidades_empresariales = dplyr::case_when(
        is.na(EFT_ULT_DOCE_UTILIDADES_EMP) ~ 0,
        TRUE ~ EFT_ULT_DOCE_UTILIDADES_EMP / 12
      )
      )
}


ft_ing_beneficios_marginales <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_beneficios_marginales = dplyr::case_when(
        is.na(EFT_ULT_DOCE_BENEFICIOS_MARG) ~ 0,
        TRUE ~ EFT_ULT_DOCE_BENEFICIOS_MARG / 12
      )
      )
}


ft_ing_especie_alimentos <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_alimentos = dplyr::case_when(
         is.na(EFT_PAGO_ALIMENTOS_MONTO) ~ 0,
        !is.na(EFT_PAGO_ALIMENTOS_MONTO) ~ EFT_PAGO_ALIMENTOS_MONTO
      )
      )
}


ft_ing_especie_viviendas <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_viviendas = dplyr::case_when(
        is.na(EFT_PAGO_VIVIENDAS_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_VIVIENDAS_MONTO
      )
      )
}


ft_ing_especie_transporte <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_transporte = dplyr::case_when(
        is.na(EFT_PAGO_TRANSPORTE_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_TRANSPORTE_MONTO
      )
      )
}


ft_ing_especie_vestido <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_vestido = dplyr::case_when(
        is.na(EFT_PAGO_VESTIDO_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_VESTIDO_MONTO / 12
      )
      )
}


ft_ing_especie_celulares <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_celulares = dplyr::case_when(
        is.na(EFT_PAGO_COMUNICACION_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_COMUNICACION_MONTO
      )
      )
}


ft_ing_especie_otros <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_otros = dplyr::case_when(
        is.na(EFT_PAGO_OTROS_MONTO) ~ 0,
        TRUE ~ EFT_PAGO_OTROS_MONTO
      )
      )
}


ft_ing_especie_auto <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_auto = dplyr::if_else(is.na(EFT_BIENES_CONSUMO_MENSUAL), 0, EFT_BIENES_CONSUMO_MENSUAL) + dplyr::if_else(is.na(EFT_BIENES_CONSUMO_ANUAL), 0, EFT_BIENES_CONSUMO_ANUAL) / 12
    )
}


ft_ing_imputado_vivienda_propia <- function(tbl) {
  tbl %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>%
    dplyr::summarise(ing_imputado_vivienda_propia = mean(EFT_MONTO_PROBABLE_ALQ, na.rm = T)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(EFT_PARENTESCO_CON_JEFE = 1) %>%
    dplyr::right_join(tbl) %>%
    dplyr::mutate(ing_imputado_vivienda_propia = dplyr::if_else(is.na(ing_imputado_vivienda_propia), 0, ing_imputado_vivienda_propia))
}


ft_ing_alqui_renta_propiedades <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_alqui_renta_propiedades = dplyr::if_else(is.na(EFT_MONTO_ALQUILER_ING_NAC), 0, EFT_MONTO_ALQUILER_ING_NAC)
      )
}


ft_ing_ext_intereses_alquiler <- function(tbl, ing_ext, metodo = "o") {
  if (metodo == "m") {
    tipo_de_cambio <- tdc_morillo
  } else if (metodo == "o") {
    tipo_de_cambio <- tdc_oficial
  }
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
      copy = TRUE
    ) %>%
    dplyr::mutate(ing_ext_intereses_alquiler = EFT_MONTO_ING_INTERES_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_intereses_alquiler = sum(ing_ext_intereses_alquiler, na.rm = T)) %>%
    dplyr::right_join(tbl, copy = TRUE) %>%
    dplyr::mutate(ing_ext_intereses_alquiler = dplyr::if_else(is.na(ing_ext_intereses_alquiler), 0, ing_ext_intereses_alquiler)) %>%
    dplyr::ungroup()
}


ft_ing_intereses_dividendo <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_intereses_dividendo =  dplyr::case_when(
        is.na(EFT_MONTO_INTERES_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_INTERES_ING_NAC
      )
      )
}


ft_ing_pension_jubilacion <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_pension_jubilacion = dplyr::case_when(
        is.na(EFT_MONTO_PENSION_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_PENSION_ING_NAC
      )
      )
}


ft_ing_ext_pension <- function(tbl, ing_ext) {
    tipo_de_cambio <- tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_ING_PENSION_MES, EFT_MONTO_ING_PENSION_MES) %>%
    dplyr::filter(!is.na(EFT_MONTO_ING_PENSION_MES)) %>%
    dplyr::filter(EFT_MONTO_ING_PENSION_MES > 0) %>%
    left_join(
      tipo_de_cambio %>%
        dplyr::filter(!is.na(value)) %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_ING_PENSION_MES = cod_moneda2, tipo_cambio = value),
      copy = TRUE
    ) %>%
    dplyr::mutate(ing_ext_pension = EFT_MONTO_ING_PENSION_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_pension = sum(ing_ext_pension, na.rm = T)) %>%
    dplyr::right_join(tbl, copy = TRUE) %>%
    dplyr::mutate(ing_ext_pension = dplyr::if_else(is.na(ing_ext_pension), 0, ing_ext_pension)) %>%
    dplyr::ungroup()
}


ft_ing_ayuda_gobierno <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_ayuda_gobierno = dplyr::if_else(is.na(EFT_MONTO_GOBIERNO_ING_NAC), 0, EFT_MONTO_GOBIERNO_ING_NAC))
}


ft_ing_remesas_nac <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_remesas_nac = dplyr::case_when(
        is.na(EFT_MONTO_REMESAS_ING_NAC) ~ 0,
        TRUE ~ EFT_MONTO_REMESAS_ING_NAC
      )
      )
}


ft_ing_remesas_ext <- function(tbl, remesas, ing_ext) {
  tbl %>%
    dplyr::left_join(
      ft_ing_remesas_ext_20001(ing_ext)
    ) %>%
    dplyr::left_join(
      ft_ing_remesas_ext_20002_20162(remesas)
    ) %>%
    dplyr::mutate(
      ing_remesas_ext = dplyr::if_else(is.na(remesas_a), 0, remesas_a) +
        dplyr::if_else(is.na(remesas_b), 0, remesas_b)
    )
}

ft_ing_remesas_ext_20001 <- function(ing_ext) {
    tipo_de_cambio <- tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_RECIBIO_ING_REMESA_SEM, EFT_FREC_ING_REMESA_SEM, EFT_MONTO_ING_REMESA_SEM, EFT_MONEDA_ING_REMESA_SEM) %>%
    dplyr::filter(EFT_PERIODO == "1/2000", EFT_RECIBIO_ING_REMESA_SEM == 1) %>%
    left_join(
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

ft_ing_remesas_ext_20002_20162 <- function(remesas) {
    tipo_de_cambio <- tdc_oficial
    ipc <- ipc_oficial
  
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
    left_join(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONEDA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_MONEDA"), values_to = "moneda", names_prefix = "EFT_MONEDA_") %>%
        dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, name) %>% 
        dplyr::mutate(moneda = dplyr::first(moneda)) %>% 
        dplyr::distinct() %>% 
        dplyr::ungroup()
      ) %>%
    left_join(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_FRECUENCIA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_FRECUENCIA"), values_to = "frecuencia", names_prefix = "EFT_FRECUENCIA_") %>%
        dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, name) %>% 
        dplyr::mutate(frecuencia = dplyr::first(frecuencia)) %>% 
        dplyr::distinct() %>% 
        dplyr::ungroup()
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
      copy = TRUE
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(periodo = as.double(paste0(lubridate::year(date), lubridate::semester(date)))) %>%
        dplyr::select(periodo, ipc_mes_encuesta = ipc),
      copy = TRUE
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(-date),
      copy = TRUE
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


ft_ing_pension_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_pension_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_PENSION) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_PENSION / 12
      )
      )
}


ft_ing_interes_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_interes_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_INTERES) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_INTERES / 12
      )
      )
}

ft_ing_alquiler_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_alquiler_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_ALQUILER) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_ALQUILER / 12
      )
      )
}

ft_ing_remesas_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_remesas_anual = dplyr::case_when(
        is.na(EFT_ANIO_PASADO_MONTO_REMESAS) ~ 0,
        TRUE ~ EFT_ANIO_PASADO_MONTO_REMESAS / 12
      )
      )
}

ft_ing_ocasion_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_ocasion_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_OCASION), 0, EFT_ANIO_PASADO_MONTO_OCASION))
}

ft_ing_gobierno_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_gobierno_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_GOBIERNO), 0, EFT_ANIO_PASADO_MONTO_GOBIERNO/12))
}

ft_ing_otros_anual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_otros_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_OTROS), 0, EFT_ANIO_PASADO_MONTO_OTROS) / 12 +
        dplyr::if_else(is.na(EFT_ANIO_PASADO_AYUD_INS_MONTO), 0, EFT_ANIO_PASADO_AYUD_INS_MONTO) / 12
    )
}


ft_ing_adicionales <- function(tbl) {
  tbl %>%
    ft_ing_pension_anual() %>%
    ft_ing_interes_anual() %>%
    ft_ing_alquiler_anual() %>%
    ft_ing_remesas_anual() %>%
    ft_ing_ocasion_anual() %>%
    ft_ing_gobierno_anual() %>%
    ft_ing_otros_anual() %>%
    dplyr::mutate(
      ing_adicionales = ing_pension_anual +
        ing_interes_anual +
        ing_alquiler_anual +
        ing_remesas_anual +
        ing_ocasion_anual +
        ing_gobierno_anual +
        ing_otros_anual
    )
}


ft_ing_especie_ayuda_ong <- function(tbl) {
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


ft_ing_ocasional_nac <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>% 
    dplyr::mutate(ing_ocasional_nac = dplyr::case_when(
      ano <= 2004 ~ dplyr::if_else(is.na(EFT_MONTO_OTROS_ING_NAC), 0, EFT_MONTO_OTROS_ING_NAC),
      TRUE ~ dplyr::if_else(is.na(EFT_MONTO_OCASIONAL_ING_NAC), 0, EFT_MONTO_OCASIONAL_ING_NAC)
    ))
}


ft_ing_ocasional_ext <- function(tbl, ing_ext) {
    tipo_de_cambio <- tdc_oficial
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_OTROS_ING_SEM, EFT_MONTO_OTROS_ING_SEM) %>%
    tidyr::drop_na() %>%
    dplyr::filter(EFT_MONTO_OTROS_ING_SEM > 0) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        tidyr::drop_na() %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_OTROS_ING_SEM = cod_moneda2, tipo_cambio = value)
    ) %>%
    dplyr::mutate(ing_ocasional_ext = EFT_MONTO_OTROS_ING_SEM * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ocasional_ext = dplyr::if_else(EFT_PERIODO == "1/2000", sum(ing_ocasional_ext, na.rm = T) / 6, sum(ing_ocasional_ext, na.rm = T))) %>%
    dplyr::right_join(tbl) %>%
    plyr::mutate(ing_ocasional_ext = tidyr::replace_na(ing_ocasional_ext, 0)) %>%
    dplyr::ungroup()
}


ft_ing_regalos_ext <- function(tbl, ing_ext) {
  tbl %>% 
    left_join(
  ing_ext %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_regalos_ext = sum(EFT_MONTO_EQUIV_REGALO, na.rm = TRUE)) %>%
    dplyr::ungroup()
    ) %>% 
    mutate(ing_regalos_ext = dplyr::if_else(is.na(ing_regalos_ext), 0, ing_regalos_ext))
}


ft_ing_otros <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>% 
    dplyr::mutate(ing_otros = dplyr::case_when(
      ano >= 2005 ~ dplyr::if_else(is.na(EFT_MONTO_OTROS_ING_NAC), 0, EFT_MONTO_OTROS_ING_NAC) +
        dplyr::if_else(is.na(EFT_GOB_AYUDA_INST_MONTO), 0, EFT_GOB_AYUDA_INST_MONTO),
      TRUE ~ 0
    ))
}


ft_ing_total_oficial <- function(tbl, ing_ext, remesas) {

  # Ingresos convencionales
  tbl <- ft_ing_ocup_prin(tbl)
  tbl <- ft_ing_ocup_secun(tbl)
  tbl <- ft_ing_alqui_renta_propiedades(tbl)
  tbl <- ft_ing_ext_intereses_alquiler(tbl, ing_ext, metodo = metodo)
  tbl <- ft_ing_intereses_dividendo(tbl)
  tbl <- ft_ing_pension_jubilacion(tbl)
  tbl <- ft_ing_ext_pension(tbl, ing_ext, metodo = metodo)
  tbl <- ft_ing_ayuda_gobierno(tbl)
  tbl <- ft_ing_remesas_nac(tbl)
  tbl <- ft_ing_remesas_ext(tbl, remesas, ing_ext, metodo = metodo)
  tbl <- ft_ing_ocasional_nac(tbl)
  tbl <- ft_ing_ocasional_ext(tbl, ing_ext, metodo = metodo)
  tbl <- ft_ing_regalos_ext(tbl, ing_ext)
  tbl <- ft_ing_otros(tbl)
  # Ingresos adicionales
  tbl <- ft_ing_comisiones(tbl)
  tbl <- ft_ing_propinas(tbl)
  tbl <- ft_ing_horas_extras(tbl)
  tbl <- ft_ing_vacaciones(tbl)
  tbl <- ft_ing_dividendos(tbl)
  tbl <- ft_ing_bonificaciones(tbl)
  tbl <- ft_ing_regalia_pascual(tbl)
  tbl <- ft_ing_utilidades_empresariales(tbl)
  tbl <- ft_ing_beneficios_marginales(tbl)
  tbl <- ft_ing_especie_alimentos(tbl)
  tbl <- ft_ing_especie_viviendas(tbl)
  tbl <- ft_ing_especie_celulares(tbl)
  tbl <- ft_ing_especie_transporte(tbl)
  tbl <- ft_ing_especie_vestido(tbl)
  tbl <- ft_ing_especie_otros(tbl)
  tbl <- ft_ing_especie_auto(tbl)
  tbl <- ft_ing_especie_ayuda_ong(tbl)
  tbl <- ft_ing_adicionales(tbl)

  tbl <- ft_ing_imputado_vivienda_propia(tbl)

  tbl <- tbl %>%
    dplyr::left_join(
      ipc_oficial %>%
        filter(lubridate::month(date) %in% c(4, 10)) %>%
        dplyr::mutate(
          semestre = lubridate::semester(date),
          ano = lubridate::year(date)
        ) %>%
        dplyr::select(-date) %>%
        dplyr::rename("ipc_mes_encuesta" = "ipc")
    ) %>%
    dplyr::left_join(
      ipc_oficial %>%
        filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(
          semestre = lubridate::semester(date),
          ano = lubridate::year(date)
        ) %>%
        dplyr::select(-date) %>%
        dplyr::rename("ipc_mes_anterior_encuesta" = "ipc")
    )

  tbl <- tbl %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::all_of(index),
        ~.x * (ipc_mes_anterior_encuesta/ipc_mes_encuesta)
      )
    )

  tbl <- tbl %>%
    dplyr::mutate(
      ing_convencional_pobreza = 
        ing_ocup_prin + 
        ing_ocup_secun +
        ing_alqui_renta_propiedades + 
        ing_ext_intereses_alquiler + 
        ing_intereses_dividendo +
        ing_pension_jubilacion + 
        ing_ext_pension + 
        ing_ayuda_gobierno +
        ing_remesas_nac + 
        ing_remesas_ext + 
        ing_ocasional_nac +
        ing_ocasional_ext + 
        tidyr::replace_na(ing_regalos_ext, 0) + 
        ing_otros
    )
  tbl <- tbl %>%
    dplyr::mutate(
      ing_adicional_pobreza = 
        ing_comisiones + 
        ing_propinas +
        ing_horas_extras + 
        ing_vacaciones + 
        ing_dividendos +
        ing_bonificaciones + 
        ing_regalia_pascual +
        ing_utilidades_empresariales + 
        ing_beneficios_marginales +
        ing_especie_alimentos + 
        ing_especie_viviendas + 
        ing_especie_transporte +
        ing_especie_vestido + 
        ing_especie_celulares + 
        ing_especie_otros + 
        ing_especie_auto +
        ing_adicionales + 
        ing_especie_ayuda_ong
    )
  tbl <- tbl %>%
    dplyr::mutate(
      ing_total_oficial = ing_convencional_pobreza +
        ing_imputado_vivienda_propia +
        ing_adicional_pobreza,
      ing_total_recomendado = ing_total_oficial -
        ing_ocasional_nac - ing_ocasional_ext
    )
  if (metodo == "m") {
    tbl <- tbl %>%
      dplyr::mutate(
        ing_total_recomendado = ing_total_recomendado - ing_especie_ayuda_ong -
          ing_regalos_ext - ing_otros
      )
  }
  tbl
}
