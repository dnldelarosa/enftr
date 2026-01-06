#' Población en edad de trabajar (PET)
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'  variable \code{pet} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_pet(enft)
#' }
ft_pet <- function(tbl, min_edad = 15) {
  tbl %>%
    dplyr::mutate(
      pet = dplyr::case_when(
        EFT_EDAD >= min_edad ~ 1,
        EFT_EDAD < min_edad ~ 0
      )
    )
}



#' Población ocupada
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{ocupado} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ocupado(enft)
#' }
ft_ocupado <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_pet(min_edad) %>%
    dplyr::mutate(
      ocupado = dplyr::case_when(
        EFT_TRABAJO_SEM_ANT == 1 ~ 1,
        EFT_TUVO_ACT_ECON_SEM_ANT == 1 ~ 1,
        EFT_CULTIVO_SEM_ANT == 1 ~ 1,
        EFT_ELAB_PROD_SEM_ANT == 1 ~ 1,
        EFT_AYUDO_FAM_SEM_ANT == 1 ~ 1,
        EFT_COSIO_LAVO_SEM_ANT == 1 ~ 1,
        pet == 1 ~ 0
      ),
      ocupado = dplyr::case_when(
        pet == 1 ~ ocupado
      )
    )
}



#' Población en condición de desempleo abierto
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{desempleo_abierto} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_abierto(enft)
#' }
ft_desempleo_abierto <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_ocupado(min_edad) %>%
    dplyr::mutate(
      desempleo_abierto = dplyr::case_when(
        pet == 1 & EFT_BUSCO_TRAB_SEM_ANT == 1 ~ 1,
        pet == 1 & EFT_BUSCO_TRAB_MES_ANT == 1 ~ 1,
        ocupado == 1 ~ 0
      )
    )
}


#' Población censante en condición de desempleo abierto
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{desempleo_cesante_abierto} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_cesante_abierto(enft)
#' }
ft_desempleo_cesante_abierto <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_desempleo_abierto(min_edad) %>%
    dplyr::mutate(
      desempleo_cesante_abierto = dplyr::case_when(
        desempleo_abierto == 1 & EFT_TRABAJO_ANTES == 1 ~ 1,
        desempleo_abierto == 1 ~ 0
      )
    )
}


#' Población nueva en condición de desempleo abierto
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{desempleo_nuevo_abierto} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_nuevo_abierto(enft)
#' }
ft_desempleo_nuevo_abierto <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_desempleo_abierto(min_edad) %>%
    dplyr::mutate(
      desempleo_nuevo_abierto = dplyr::case_when(
        desempleo_abierto == 1 & EFT_TRABAJO_ANTES != 1 ~ 1,
        desempleo_abierto == 1 ~ 0
      )
    )
}


#' Población Económicamente Activa (PEA) abierta
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{pea_abierta} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_pea_abierta(enft)
#' }
ft_pea_abierta <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_ocupado(min_edad) %>%
    ft_desempleo_abierto(min_edad) %>%
    dplyr::mutate(
      pea_abierta = dplyr::case_when(
        ocupado == 1 ~ 1,
        desempleo_abierto == 1 ~ 1,
        pet == 1 ~ 0
      )
    )
}


#' Población en condición de desempleo ampliado
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{desempleo_ampliado} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_ampliado(enft)
#' }
ft_desempleo_ampliado <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_desempleo_abierto(min_edad) %>%
    dplyr::mutate(
      desempleo_ampliado = dplyr::case_when(
        desempleo_abierto == 1 ~ 1,
        EFT_TIENE_COND_JORNADA == 1 ~ 1,
        ocupado == 1 ~ 0
      ),
      desempleo_ampliado = dplyr::case_when(
        pet == 1 ~ desempleo_ampliado
      )
    )
}


#' Población censante en condición de desempleo ampliado
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'      variable \code{desempleo_cesante_ampliado} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_cesante_ampliado(enft)
#' }
ft_desempleo_cesante_ampliado <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_desempleo_ampliado(min_edad) %>%
    dplyr::mutate(
      desempleo_cesante_ampliado = dplyr::case_when(
        desempleo_ampliado == 1 & EFT_TRABAJO_ANTES != 1 ~ 0,
        desempleo_ampliado == 1 ~ 1
      )
    )
}


#' Población nueva en condición de desempleo ampliado
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'     variable \code{desempleo_nuevo_ampliado} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_desempleo_nuevo_ampliado(enft)
#' }
ft_desempleo_nuevo_ampliado <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_desempleo_ampliado(min_edad) %>%
    dplyr::mutate(
      desempleo_nuevo_ampliado = dplyr::case_when(
        desempleo_ampliado == 1 & EFT_TRABAJO_ANTES == 1 ~ 0,
        desempleo_ampliado == 1 ~ 1
      )
    )
}


#' Población Económicamente Activa (PEA) ampliada
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'    variable \code{pea_ampliada} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_pea_ampliada(enft)
#' }
ft_pea_ampliada <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_ocupado(min_edad) %>%
    ft_desempleo_ampliado(min_edad) %>%
    dplyr::mutate(
      pea_ampliada = dplyr::case_when(
        ocupado == 1 ~ 1,
        desempleo_ampliado == 1 ~ 1,
        pet == 1 ~ 0
      )
    )
}


#' Población inactiva (No PEA)
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'    variable \code{poblacion_inactiva} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_poblacion_inactiva(enft)
#' }
ft_poblacion_inactiva <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_pea_ampliada(min_edad) %>%
    dplyr::mutate(
      poblacion_inactiva = dplyr::case_when(
        pea_ampliada == 1 ~ 0,
        pet == 1 ~ 1
      )
    )
}


#' Categoría de la ocupación principal
#' `r lifecycle::badge('experimental')`
#'
#' Las encuestas levantadas entre 2000 y 2004 contemplaban 10 categorías de
#' ocupación, pero en 2005 se redujeron a 8. Vea los cuestionarios
#' correspondientes a esos periodos para más información.
#'
#' Esta función homologa las categorías de ocupación a las categorías de
#' menor frecuencia en la encuesta. Dígase las utilizadas a partir de 2005.
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'    variable \code{categoria_ocupacion_principal} agregada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_categoria_ocupacion_principal(enft)
#' }
ft_categoria_ocupacion_principal <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>%
    dplyr::mutate(
      categoria_ocupacion_principal = dplyr::case_when(
        dplyr::between(ano, 2000, 2004) &
          EFT_CATEGORIA_OCUP_PRINC %in% 7:8 ~ 7,
        dplyr::between(ano, 2000, 2004) &
          EFT_CATEGORIA_OCUP_PRINC %in% 9:10 ~ 8,
        TRUE ~ EFT_CATEGORIA_OCUP_PRINC
      )
    )
}


#' Cantidad de personas trabajan en la empresa
#' `r lifecycle::badge('experimental')`
#'
#' Esta función homologa los rangos de cantidad de personas que laboran en la
#' empresa. Para el período 2000-2003 se incluían solo 4 categorías, pero de
#' 2004 en adelante se incluyen 7 categorías. Vea los cuestionarios
#' correspondientes a esos periodos para más información.
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'  variable \code{cantidad_personas_trabajan} agregada.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_cantidad_personas_trabajan(enft)
#' }
ft_cantidad_personas_trabajan <- function(tbl) {
  tbl %>%
    ft_peri_vars() %>%
    dplyr::mutate(
      cantidad_personas_trabajan = dplyr::case_when(
        ano >= 2004 & EFT_CANT_PERS_TRAB %in% 1:2 ~ 1,
        ano >= 2004 & EFT_CANT_PERS_TRAB %in% 3:4 ~ EFT_CANT_PERS_TRAB - 1,
        ano >= 2004 & EFT_CANT_PERS_TRAB >= 5 ~ 4,
        EFT_CANT_PERS_TRAB != 0 ~ EFT_CANT_PERS_TRAB
      )
    )
}


#' Sector de ocupación
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'   variable \code{sector_ocupacion} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_sector_ocupacion(enft)
#' }
ft_sector_ocupacion <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_ocupado(min_edad) %>%
    ft_grupo_ocupacion(min_edad) %>%
    dplyr::mutate(
      sector_ocupacion = dplyr::case_when(
        EFT_CATEGORIA_OCUP_PRINC <= 3 &
          dplyr::between(EFT_CANT_PERS_TRAB, 3, 7) ~ 0,
        EFT_CATEGORIA_OCUP_PRINC %in% 4:6 &
          grupo_ocupacion == 1 ~ 0,
        EFT_CATEGORIA_OCUP_PRINC %in% 4:6 &
          grupo_ocupacion == 2 ~ 0,
        EFT_CATEGORIA_OCUP_PRINC %in% 4:6 &
          EFT_OCUPACION_PRINC == 341 ~ 0,
        .default = 1
      ),
      sector_ocupacion = dplyr::case_when(ocupado == 1 ~ sector_ocupacion)
    )
}


#' Grupo de ocupación
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#'  variable \code{grupo_ocupacion} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_grupo_ocupacion(enft)
#' }
ft_grupo_ocupacion <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_pea_ampliada(min_edad) %>%
    dplyr::mutate(
      grupo_ocupacion = dplyr::case_when(
        EFT_OCUPACION_PRINC < 12 ~ 5,
        dplyr::between(EFT_OCUPACION_PRINC, 12, 199) ~ 1,
        EFT_OCUPACION_PRINC < 300 ~ 2,
        EFT_OCUPACION_PRINC < 400 ~ 3,
        EFT_OCUPACION_PRINC < 500 ~ 4,
        EFT_OCUPACION_PRINC < 600 ~ 5,
        EFT_OCUPACION_PRINC < 700 ~ 6,
        EFT_OCUPACION_PRINC < 800 ~ 7,
        EFT_OCUPACION_PRINC < 900 ~ 8,
        EFT_OCUPACION_PRINC > 900 ~ 9,
        pea_ampliada == 1 ~ 10
      )
    )
}


#' Perceptores de ingresos
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{perceptores_ingresos} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_perceptores_ingresos(enft)
#' }
ft_perceptores_ingresos <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_ocupado(min_edad) %>%
    dplyr::mutate(
      perceptores_ingresos = dplyr::case_when(
        ocupado == 1 & EFT_CATEGORIA_OCUP_PRINC != 7 ~ 1,
        ocupado == 1 ~ 0
      )
    )
}


#' Horas trabajadas a la semana
#' `r lifecycle::badge('stable')`
#'
#' En el periodo 2000-2005 se imputó cero (0) para algunos casos que no aplicaban
#' esta función toma cuenta de esa situación eliminando todos los valores
#' asignados en cero (0).
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{horas_semanal} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_horas_semanal(enft)
#' }
ft_horas_semanal <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_perceptores_ingresos(min_edad) %>%
    dplyr::mutate(
      horas_semanal = dplyr::case_when(
        EFT_HORAS_SEM_OCUP_PRINC > 0 &
          perceptores_ingresos == 1 ~ EFT_HORAS_SEM_OCUP_PRINC
      )
    )
}


#' Número de días trabajados a la semana por ocupación principal
#' `r lifecycle::badge('stable')`
#'
#' @param tbl  [data.frame] Data.frame con los datos de la encuesta
#'
#' @return[data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{dias_semana_ocupacion_principal} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- dias_semana_ocupacion_principal(enft)
#' }
ft_dias_semana_ocupacion_principal <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      dias_semana_ocupacion_principal = dplyr::case_when(
        EFT_DIAS_SEM_OCUP_PRINC > 0 ~ EFT_DIAS_SEM_OCUP_PRINC
      )
    )
}



#' Ingreso laboral mensual
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame] Data.frame con los datos de la encuesta
#' @param min_edad [integer] Edad mínima para considerar una persona en edad de trabajar
#'
#' @return [data.frame] los datos suministrados en el input tbl, pero con la
#' variable \code{ingreso_laboral_mensual} agregada.
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_ingreso_laboral_mensual(enft)
#' }
ft_ingreso_laboral_mensual <- function(tbl, min_edad = 15) {
  tbl %>%
    ft_perceptores_ingresos(min_edad) %>%
    dplyr::mutate(
      ingreso_laboral_mensual = dplyr::case_when(
        EFT_PERIODO_ING_OCUP_PRINC == 1 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_HORAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 2 ~ EFT_ING_OCUP_PRINC * 4.3 * EFT_DIAS_SEM_OCUP_PRINC,
        EFT_PERIODO_ING_OCUP_PRINC == 3 ~ EFT_ING_OCUP_PRINC * 4.3,
        EFT_PERIODO_ING_OCUP_PRINC == 4 ~ EFT_ING_OCUP_PRINC * 2,
        EFT_PERIODO_ING_OCUP_PRINC == 5 ~ EFT_ING_OCUP_PRINC,
        TRUE ~ 0
      ),
      ingreso_laboral_mensual = dplyr::case_when(
        perceptores_ingresos == 1 ~ ingreso_laboral_mensual
      )
    )
}


ft_ingreso_laboral_total <- function(tbl) {
  tbl %>%
    ft_ingreso_laboral_mensual() %>%
    dplyr::mutate(
      ingreso_laboral_total = ingreso_laboral_mensual +
        EFT_MES_PASADO_HORAS_EXTRAS +
        EFT_MES_PASADO_PROPINAS +
        EFT_MES_PASADO_COMISIONES +
        # EFT_ULT_DOCE_VACACIONES_PAGAS / 12 +
        # EFT_ULT_DOCE_BONIFICACION / 12 +
        # EFT_ULT_DOCE_REGALIA_PASCUAL / 12 +
        # EFT_ULT_DOCE_DIVIDENDOS / 12 +
        # EFT_ULT_DOCE_UTILIDADES_EMP / 12 +
        # EFT_ULT_DOCE_BENEFICIOS_MARG / 12 +
        0
    )
}

#' Grupos Ramas de actividad económica
#' `r lifecycle::badge('stable')`
#'
#' @param tbl [data.frame]: los datos de la ENFT.
#' Puede ser conexión a base de datos.
#'
#' @return Los datos suministrados en el argumento tbl con la variables \code{grupo_rama} agregada
#'
#' @export
#'
#' @examples
#' \dontrun{
#' enft <- ft_grupo_rama(enft)
#' }
ft_grupo_rama <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      grupo_rama = dplyr::case_when(
        EFT_RAMA_PRINC < 100 ~ 1,
        EFT_RAMA_PRINC < 150 ~ 2,
        EFT_RAMA_PRINC < 400 ~ 3,
        EFT_RAMA_PRINC < 450 ~ 4,
        EFT_RAMA_PRINC < 500 ~ 5,
        EFT_RAMA_PRINC < 550 ~ 6,
        EFT_RAMA_PRINC < 600 ~ 7,
        EFT_RAMA_PRINC < 650 ~ 8,
        EFT_RAMA_PRINC < 700 ~ 9,
        EFT_RAMA_PRINC < 750 ~ 11,
        EFT_RAMA_PRINC < 800 ~ 10,
        EFT_RAMA_PRINC >= 800 ~ 11
      )
    )
}



ft_grupo_rama_pib <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      grupo_rama_pib = dplyr::case_when(
        EFT_RAMA_PRINC < 100 ~ 1,
        EFT_RAMA_PRINC < 150 ~ 2,
        EFT_RAMA_PRINC < 400 ~ 3,
        EFT_RAMA_PRINC < 450 ~ 5,
        EFT_RAMA_PRINC < 500 ~ 4,
        EFT_RAMA_PRINC < 550 ~ 6,
        EFT_RAMA_PRINC < 600 ~ 7,
        EFT_RAMA_PRINC < 640 ~ 8,
        EFT_RAMA_PRINC < 650 ~ 9,
        EFT_RAMA_PRINC < 700 ~ 10,
        EFT_RAMA_PRINC < 720 ~ 11,
        EFT_RAMA_PRINC < 750 ~ 14,
        EFT_RAMA_PRINC < 800 ~ 15,
        EFT_RAMA_PRINC < 850 ~ 12,
        EFT_RAMA_PRINC < 900 ~ 13,
        EFT_RAMA_PRINC >= 900 ~ 15
      )
    )
}




ft_grupo_rama_sector <- function(tbl) {
  tbl %>%
    ft_grupo_rama_pib() %>%
    dplyr::mutate(
      grupo_rama_sector = dplyr::case_when(
        grupo_rama_pib == 1 ~ 1,
        grupo_rama_pib %in% 2:4 ~ 2,
        TRUE ~ 3
      )
    )
}


ft_tiempo_total_empleo_dias <- function(tbl) {
  tbl %>%
    dplyr::mutate(
      tiempo_total_empleo_dias = EFT_TIEMPO_LAB_ANOS * 365.25 + EFT_TIEMPO_LAB_MESES * 365.25 / 12 + EFT_TIEMPO_LAB_DIAS
    )
}

ft_tiempo_total_empleo_meses <- function(tbl) {
  tbl %>%
    ft_tiempo_total_empleo_dias() %>%
    dplyr::mutate(
      tiempo_total_empleo_meses = tiempo_total_empleo_dias / (365.25 / 12)
    )
}

ft_tiempo_total_empleo_anos <- function(tbl) {
  tbl %>%
    ft_tiempo_total_empleo_meses() %>%
    dplyr::mutate(
      tiempo_total_empleo_anos = tiempo_total_empleo_meses / 12
    )
}



ft_pasivo_cesantia <- function(tbl) {
  tbl %>%
    ft_ingreso_laboral_mensual() %>%
    ft_tiempo_total_empleo_meses() %>%
    ft_empleado() %>%
    dplyr::mutate(
      pasivo_cesantia = dplyr::case_when(
        is.na(ingreso_laboral_mensual) ~ NA_real_,
        tiempo_total_empleo_meses < 3 ~ 0,
        tiempo_total_empleo_meses < 6 ~ (ingreso_laboral_mensual / 23.83) * 6,
        tiempo_total_empleo_meses < 12 ~ (ingreso_laboral_mensual / 23.83) * 13,
        tiempo_total_empleo_meses < 60 ~ (ingreso_laboral_mensual / 23.83) * 21 * EFT_TIEMPO_LAB_ANOS + dplyr::case_when(
          EFT_TIEMPO_LAB_MESES < 3 ~ 0,
          EFT_TIEMPO_LAB_MESES < 6 ~ (ingreso_laboral_mensual / 23.83) * 6,
          EFT_TIEMPO_LAB_MESES < 12 ~ (ingreso_laboral_mensual / 23.83) * 13,
          .default = 0
        ),
        tiempo_total_empleo_meses >= 60 ~ (ingreso_laboral_mensual / 23.83) * 23 * EFT_TIEMPO_LAB_ANOS + dplyr::case_when(
          EFT_TIEMPO_LAB_MESES < 3 ~ 0,
          EFT_TIEMPO_LAB_MESES < 6 ~ (ingreso_laboral_mensual / 23.83) * 6,
          EFT_TIEMPO_LAB_MESES < 12 ~ (ingreso_laboral_mensual / 23.83) * 13,
          .default = 0
        )
      ),
      pasivo_cesantia = dplyr::if_else(empleado == 1, pasivo_cesantia, NA_real_)
    )
}



ft_formalidad_afiliacion <- function(tbl) {
  tbl %>%
    ft_ocupado() |>
    dplyr::mutate(
      formalidad_afiliacion = dplyr::case_when(
        ocupado == 1 & EFT_AFILIADO_SEGURO_SALUD == 1 ~ 1,
        ocupado == 1 & EFT_AFILIADO_AFP == 1 ~ 1,
        ocupado == 1 ~ 0
      )
    )
}



ft_empleado <- function(tbl) {
  tbl |>
    ft_ocupado() |>
    dplyr::mutate(
      empleado = dplyr::case_when(
        ocupado == 1 & dplyr::between(EFT_CATEGORIA_OCUP_PRINC, 1, 3) ~ 1,
        ocupado == 1 ~ 0
      )
    )
}
