ft_compute_pobreza_monetaria <- function(tbl, ing_ext, remesas) { 
  tbl <- ft_compute_factor_onaplan(tbl)
  ft_compute_ing_total_pobreza(tbl, ing_ext, remesas) %>%
    dplyr::left_join(lineas_morillo_zona, copy = T) %>%
    dplyr::mutate(
      pobreza_monetaria = dplyr::case_when(
        ingreso_percapita <= lindigencia ~ 2,
        ingreso_percapita <= lpobreza ~ 1,
        ingreso_percapita > lpobreza ~ 0
      )
    )
}


ft_compute_factor_onaplan <- function(tbl) {
  tbl %>%
    dplyr::left_join(poblacion_onaplan, copy = T, by = "EFT_PERIODO") %>%
    dplyr::group_by(EFT_PERIODO) %>%
    dplyr::mutate(factor_onaplan = EFT_FACTOR_EXP / sum(EFT_FACTOR_EXP, na.rm = T) * poblacion_onaplan) %>%
    dplyr::select(-poblacion_onaplan)
}

ft_compute_ing_ocup_prin_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_ocup_prin_mensual = dplyr::case_when(
        EFT_PERIODO_ING_OCUP_PRINC == 1 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_HORAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 2 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_DIAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 3 ~ EFT_ING_OCUP_PRINC * 4.3,
        EFT_PERIODO_ING_OCUP_PRINC == 4 ~ EFT_ING_OCUP_PRINC * 2,
        EFT_PERIODO_ING_OCUP_PRINC == 5 ~ EFT_ING_OCUP_PRINC,
        TRUE ~ 0
      )
    )
}

ft_compute_ing_ocup_secun_mensual <- function(tbl) {
  tbl %>%
    ft_compute_ano() %>%
    dplyr::mutate(
      ing_ocup_secun_mensual = dplyr::case_when(
        ano >= 2005 ~ EFT_ING_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 1 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_HORAS_SEM_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 2 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_DIAS_SEM_OCUP_SECUN,
        EFT_PERIODO_ING_OCUP_SECUN == 3 ~ EFT_ING_OCUP_SECUN * 4.3,
        EFT_PERIODO_ING_OCUP_SECUN == 4 ~ EFT_ING_OCUP_SECUN * 2,
        EFT_PERIODO_ING_OCUP_SECUN == 5 ~ EFT_ING_OCUP_SECUN
      ),
      ing_ocup_secun_mensual = tidyr::replace_na(ing_ocup_secun_mensual, 0)
    )
}

ft_compute_ing_comisiones_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_comisiones_mensual = tidyr::replace_na(EFT_MES_PASADO_COMISIONES, 0))
}

ft_compute_ing_propinas_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_propinas_mensual = tidyr::replace_na(EFT_MES_PASADO_PROPINAS, 0))
}

ft_compute_ing_horas_extras_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_horas_extras_mensual = tidyr::replace_na(EFT_MES_PASADO_HORAS_EXTRAS, 0))
}

ft_compute_ing_vacaciones_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_vacaciones_mensual = tidyr::replace_na(EFT_ULT_DOCE_VACACIONES_PAGAS, 0)/12)
}

ft_compute_ing_dividendos_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_dividendos_mensual = tidyr::replace_na(EFT_ULT_DOCE_DIVIDENDOS, 0)/12)
}

ft_compute_ing_bonificaciones_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_bonificaciones_mensual = tidyr::replace_na(EFT_ULT_DOCE_BONIFICACION, 0)/12)
}

ft_compute_ing_regalia_pascual_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_regalia_pascual_mensual = tidyr::replace_na(EFT_ULT_DOCE_REGALIA_PASCUAL, 0)/12)
}

ft_compute_ing_utilidades_empresariales_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_utilidades_empresariales_mensual = tidyr::replace_na(EFT_ULT_DOCE_UTILIDADES_EMP, 0)/12)
}

ft_compute_ing_beneficios_marginales_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_beneficios_marginales_mensual = tidyr::replace_na(EFT_ULT_DOCE_BENEFICIOS_MARG, 0)/12)
}

ft_compute_ing_especie_alimentos_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_especie_alimentos_mensual = tidyr::replace_na(EFT_PAGO_ALIMENTOS_MONTO, 0))
}

ft_compute_ing_especie_viviendas_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_especie_viviendas_mensual = tidyr::replace_na(EFT_PAGO_VIVIENDAS_MONTO, 0))
}

ft_compute_ing_especie_transporte <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_especie_transporte = tidyr::replace_na(EFT_PAGO_TRANSPORTE_MONTO, 0))
}

ft_compute_ing_especie_vestido_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_especie_vestido_mensual = tidyr::replace_na(EFT_PAGO_VESTIDO_MONTO, 0)/12)
}

# Falta ingresos por celulares de 2007 en adelante

ft_compute_ing_especie_otros_mensual <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_especie_otros_mensual = tidyr::replace_na(EFT_PAGO_OTROS_MONTO, 0))
}

ft_compute_ing_especie_auto <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_auto = dplyr::if_else(
        round(EFT_BIENES_CONSUMO_MENSUAL) == round(EFT_BIENES_CONSUMO_ANUAL / 12),
        EFT_BIENES_CONSUMO_MENSUAL,
        tidyr::replace_na(EFT_BIENES_CONSUMO_MENSUAL, 0) + tidyr::replace_na(EFT_BIENES_CONSUMO_ANUAL, 0) / 12
      ),
      ing_especie_auto = tidyr::replace_na(ing_especie_auto, 0)
    )
}

ft_compute_ing_imputado_vivienda_propia <- function(tbl) {
  tbl %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>% 
    dplyr::summarise(ing_imputado_vivienda_propia = mean(EFT_MONTO_PROBABLE_ALQ, na.rm = T)) %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(EFT_PARENTESCO_CON_JEFE = 1) %>% 
    dplyr::right_join(tbl) %>% 
    dplyr::mutate(ing_imputado_vivienda_propia = tidyr::replace_na(ing_imputado_vivienda_propia, 0))
}

ft_compute_ing_alqui_renta_propiedades <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_alqui_renta_propiedades = tidyr::replace_na(EFT_MONTO_ALQUILER_ING_NAC, 0))
}

ft_compute_ing_ext_intereses_alquiler <- function(tbl, ing_ext) {
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_ING_INTERES_MES, EFT_MONTO_ING_INTERES_MES) %>%
    tidyr::drop_na(EFT_MONTO_ING_INTERES_MES) %>%
    dplyr::filter(EFT_MONTO_ING_INTERES_MES > 0) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        tidyr::drop_na() %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_ING_INTERES_MES = cod_moneda2, tipo_cambio = value)
    ) %>%
    dplyr::mutate(ing_ext_intereses_alquiler = EFT_MONTO_ING_INTERES_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_intereses_alquiler = sum(ing_ext_intereses_alquiler, na.rm = T)) %>%
    dplyr::right_join(tbl) %>% 
    dplyr::mutate(ing_ext_intereses_alquiler = tidyr::replace_na(ing_ext_intereses_alquiler, 0))
}

ft_compute_ing_intereses_dividendo <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_intereses_dividendo = tidyr::replace_na(EFT_MONTO_INTERES_ING_NAC, 0))
}

ft_compute_ing_pension_jubilacion <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_pension_jubilacion = tidyr::replace_na(EFT_MONTO_PENSION_ING_NAC, 0))
}

ft_compute_ing_ext_pension <- function(tbl, ing_ext) {
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONEDA_ING_PENSION_MES, EFT_MONTO_ING_PENSION_MES) %>%
    tidyr::drop_na() %>%
    dplyr::filter(EFT_MONTO_ING_PENSION_MES > 0) %>%
    left_join(
      tipo_de_cambio %>%
        tidyr::drop_na() %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, EFT_MONEDA_ING_PENSION_MES = cod_moneda2, tipo_cambio = value)
    ) %>%
    dplyr::mutate(ing_ext_pension = EFT_MONTO_ING_PENSION_MES * tipo_cambio) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_ext_pension = sum(ing_ext_pension, na.rm = T)) %>%
    dplyr::right_join(tbl) %>% 
    dplyr::mutate(ing_ext_pension = tidyr::replace_na(ing_ext_pension, 0))
}

ft_compute_ing_ayuda_gobierno <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_ayuda_gobierno = tidyr::replace_na(EFT_MONTO_GOBIERNO_ING_NAC, 0))
}

ft_compute_ing_remesas_nac <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_remesas_nac = tidyr::replace_na(EFT_MONTO_REMESAS_ING_NAC, 0))
}

ft_compute_ing_remesas_ext <- function(tbl, remesas, ing_ext) {
  ft_compute_ing_remesas_ext_20001(ing_ext) %>%
    dplyr::bind_rows(ft_compute_ing_remesas_ext_20002_20071(remesas)) %>% 
    dplyr::bind_rows(ft_compute_ing_remesas_ext_20072_20162(remesas)) %>%
    dplyr::right_join(tbl) %>% 
    dplyr::mutate(ing_remesas_ext = tidyr::replace_na(ing_remesas_ext, 0))
}

ft_compute_ing_remesas_ext_20001 <- function(ing_ext) {
  ing_ext %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_FREC_ING_REMESA_SEM, EFT_MONTO_ING_REMESA_SEM, EFT_MONEDA_ING_REMESA_SEM) %>%
    dplyr::filter(EFT_PERIODO == "1/2000", EFT_MONTO_ING_REMESA_SEM > 0) %>%
    left_join(
      tipo_de_cambio %>%
        dplyr::filter(date == as.Date("2000-03-01")) %>%
        dplyr::select(tipo_cambio = value, cod_moneda2) %>%
        dplyr::mutate(EFT_PERIODO = "1/2000") %>%
        tidyr::drop_na(),
      by = c("EFT_PERIODO", "EFT_MONEDA_ING_REMESA_SEM" = "cod_moneda2")
    ) %>%
    dplyr::mutate(remesas = EFT_MONTO_ING_REMESA_SEM * tipo_cambio / 6) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_remesas_ext = sum(remesas, na.rm = T))
}

ft_compute_ing_remesas_ext_20002_20071 <- function(remesas) {
  remesas <- remesas %>%
    ft_compute_ano() %>%
    dplyr::filter(dplyr::between(periodo, 20002, 20071))

  remesas %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONTO")) %>%
    tidyr::pivot_longer(dplyr::starts_with("EFT_MONTO")) %>%
    tidyr::drop_na() %>%
    dplyr::filter(value > 0) %>%
    dplyr::mutate(name = trimws(stringr::str_remove(name, "EFT_MONTO_"))) %>%
    ft_compute_ano() %>%
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
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, ano, mes, monto = value) %>%
    dplyr::bind_cols(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONEDA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_MONEDA")) %>%
        tidyr::drop_na() %>%
        dplyr::filter(value > 0) %>%
        dplyr::select(moneda = value)
    ) %>%
    dplyr::bind_cols(
      remesas %>%
        dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_FRECUENCIA")) %>%
        tidyr::pivot_longer(dplyr::starts_with("EFT_FRECUENCIA")) %>%
        tidyr::drop_na() %>%
        dplyr::filter(value > 0) %>%
        dplyr::select(frecuencia = value)
    ) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        tidyr::drop_na() %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(ano, mes, moneda = cod_moneda2, tipo_cambio = value)
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, ipc_mes_encuesta = ipc)
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(-date)
    ) %>%
    dplyr::mutate(ing_remesas_ext = monto * frecuencia * tipo_cambio * (ipc_mes_encuesta / ipc)) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_remesas_ext = sum(ing_remesas_ext, na.rm = T) / 12) %>%
    dplyr::ungroup()
}

ft_compute_ing_remesas_ext_20072_20162 <- function(remesas) {
  remesas <- remesas %>%
    ft_compute_ano() %>%
    dplyr::filter(periodo > 20071)
  
  remesas %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONTO")) %>% 
    tidyr::pivot_longer(dplyr::starts_with("EFT_MONTO")) %>% 
    tidyr::drop_na() %>% 
    dplyr::filter(value > 0) %>%
    dplyr::mutate(name = trimws(stringr::str_remove(name, "EFT_MONTO_"))) %>%
    ft_compute_ano() %>%
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
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, ano, mes, monto = value) %>% 
    dplyr::bind_cols(
      remesas %>%
    dplyr::select(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, dplyr::starts_with("EFT_MONEDA")) %>% 
    tidyr::pivot_longer(dplyr::starts_with("EFT_MONEDA")) %>% 
    tidyr::drop_na() %>% 
    dplyr::filter(value > 0) %>%
    dplyr::select(moneda = value)
    ) %>%
    dplyr::left_join(
      tipo_de_cambio %>%
        tidyr::drop_na() %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(ano, mes, moneda = cod_moneda2, tipo_cambio = value)
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::filter(lubridate::month(date) %in% c(3, 9)) %>%
        dplyr::mutate(EFT_PERIODO = paste0(lubridate::semester(date), "/", lubridate::year(date))) %>%
        dplyr::select(EFT_PERIODO, ipc_mes_encuesta = ipc)
    ) %>%
    dplyr::left_join(
      ipc %>%
        dplyr::mutate(ano = lubridate::year(date), mes = lubridate::month(date)) %>%
        dplyr::select(-date)
    ) %>%
    dplyr::mutate(ing_remesas_ext = monto * tipo_cambio * (ipc_mes_encuesta / ipc)) %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_remesas_ext = sum(ing_remesas_ext, na.rm = T) / 6) %>%
    dplyr::ungroup()
}

ft_compute_ing_adicionales <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_adicionales = tidyr::replace_na(EFT_ANIO_PASADO_MONTO_PENSION, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_INTERES, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_ALQUILER, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_REMESAS, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_OCASION, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_GOBIERNO, 0) / 12 +
        tidyr::replace_na(EFT_ANIO_PASADO_MONTO_OTROS, 0) / 12
    )
}

ft_compute_ing_especie_ayuda_ong <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      ing_especie_ayuda_ong = dplyr::if_else(
        EFT_AYUDA_FAMILIARES_ANUAL == (EFT_AYUDA_FAMILIARES_MENSUAL * 12),
        EFT_AYUDA_FAMILIARES_MENSUAL,
        tidyr::replace_na(EFT_AYUDA_FAMILIARES_MENSUAL, 0) + tidyr::replace_na(EFT_AYUDA_FAMILIARES_ANUAL, 0) / 12
      ),
      ing_especie_ayuda_ong = tidyr::replace_na(ing_especie_ayuda_ong, 0)
    )
}

ft_compute_ing_ocasional_nac <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_ocasional_nac = tidyr::replace_na(EFT_MONTO_OCASIONAL_ING_NAC, 0))
}

ft_compute_ing_ocasional_ext <- function(tbl, ing_ext) {
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
    dplyr::summarise(ing_ocasional_ext = dplyr::if_else(EFT_PERIODO == "1/2000", sum(ing_ocasional_ext, na.rm = T)/6, sum(ing_ocasional_ext, na.rm = T))) %>% 
    dplyr::right_join(tbl) %>% 
    plyr::mutate(ing_ocasional_ext = tidyr::replace_na(ing_ocasional_ext, 0))
}

ft_compute_ing_regalos_ext <- function(tbl, ing_ext) {
  ing_ext %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO) %>%
    dplyr::summarise(ing_regalos_ext = sum(EFT_MONTO_EQUIV_REGALO, na.rm = TRUE)) %>%
    dplyr::right_join(tbl) %>% 
    dplyr::mutate(ing_regalos_ext = tidyr::replace_na(ing_regalos_ext, 0))
}

ft_compute_ing_otros <- function(tbl) {
  tbl %>%
    dplyr::mutate(ing_otros = tidyr::replace_na(EFT_MONTO_OTROS_ING_NAC, 0))
}

ft_compute_ing_total_pobreza <- function(tbl, ing_ext, remesas){
  tbl <- ft_compute_ing_ocup_prin_mensual(tbl)
  tbl <- ft_compute_ing_ocup_secun_mensual(tbl)
  tbl <- ft_compute_ing_comisiones_mensual(tbl)
  tbl <- ft_compute_ing_propinas_mensual(tbl)
  tbl <- ft_compute_ing_horas_extras_mensual(tbl)
  tbl <- ft_compute_ing_vacaciones_mensual(tbl)
  tbl <- ft_compute_ing_dividendos_mensual(tbl)
  tbl <- ft_compute_ing_bonificaciones_mensual(tbl)
  tbl <- ft_compute_ing_regalia_pascual_mensual(tbl)
  tbl <- ft_compute_ing_utilidades_empresariales_mensual(tbl)
  tbl <- ft_compute_ing_beneficios_marginales_mensual(tbl)
  tbl <- ft_compute_ing_especie_alimentos_mensual(tbl)
  tbl <- ft_compute_ing_especie_viviendas_mensual(tbl)
  tbl <- ft_compute_ing_especie_transporte(tbl)
  tbl <- ft_compute_ing_especie_vestido_mensual(tbl)
  tbl <- ft_compute_ing_especie_otros_mensual(tbl)
  tbl <- ft_compute_ing_especie_auto(tbl)
  tbl <- ft_compute_ing_imputado_vivienda_propia(tbl)
  tbl <- ft_compute_ing_alqui_renta_propiedades(tbl)
  tbl <- ft_compute_ing_intereses_dividendo(tbl)
  tbl <- ft_compute_ing_pension_jubilacion(tbl)
  tbl <- ft_compute_ing_ayuda_gobierno(tbl)
  tbl <- ft_compute_ing_remesas_nac(tbl)
  tbl <- ft_compute_ing_adicionales(tbl)
  #tbl <- ft_compute_ing_especie_ayuda_ong(tbl)
  #tbl <- ft_compute_ing_ocasional_nac(tbl)
  #tbl <- ft_compute_ing_otros(tbl)
  tbl <- ft_compute_ing_ext_intereses_alquiler(tbl, ing_ext)
  tbl <- ft_compute_ing_ext_pension(tbl, ing_ext)
  #tbl <- ft_compute_ing_ocasional_ext(tbl, ing_ext)
  #tbl <- ft_compute_ing_regalos_ext(tbl, ing_ext)
  tbl <- ft_compute_ing_remesas_ext(tbl, remesas, ing_ext)
  tbl <- tbl %>%
    dplyr::mutate(
      ing_pobreza_total = ing_ocup_prin_mensual + ing_ocup_secun_mensual + 
        ing_comisiones_mensual + ing_propinas_mensual + ing_horas_extras_mensual + 
        ing_vacaciones_mensual + ing_dividendos_mensual + ing_bonificaciones_mensual + 
        ing_regalia_pascual_mensual + ing_utilidades_empresariales_mensual + 
        ing_beneficios_marginales_mensual + ing_especie_alimentos_mensual + 
        ing_especie_viviendas_mensual + ing_especie_transporte + 
        ing_especie_vestido_mensual + ing_especie_otros_mensual + ing_especie_auto + 
        ing_imputado_vivienda_propia + ing_alqui_renta_propiedades + 
        ing_ext_intereses_alquiler + ing_intereses_dividendo + ing_pension_jubilacion + 
        ing_ext_pension + ing_ayuda_gobierno + ing_remesas_nac + ing_remesas_ext + 
        ing_adicionales #+ ing_especie_ayuda_ong + ing_ocasional_nac + ing_ocasional_ext + 
        #ing_regalos_ext + ing_otros
    ) 
  
  tbl %>%
    dplyr::group_by(EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR) %>%
    dplyr::summarise(ingreso_percapita = sum(ing_pobreza_total / mean(EFT_CANT_MIEMBROS, na.rm = T), na.rm = T)) %>%
    dplyr::ungroup() %>% 
    dplyr::right_join(tbl)
}