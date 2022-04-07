# etiquetas

    Code
      str(ft_set_labels(enft_like, dict))
    Message <cliMessage>
      ! EFT_CATEGORIA_OCUP_PRINC: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2004 y 2005-2016. Vea `enftr::ft_categoria_ocupacion_principal` para más información.
      ! EFT_CANT_PERS_TRAB: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2003 y 2004-2016. Vea `enftr::ft_cantidad_personas_trabajan` para más información.
      ! EFT_DIAS_SEM_OCUP_PRINC: Esta variable imputa cero (0) en los casos que no aplica para el periodo 2000-2005. Vea `enftr::ft_dias_semana_ocupacion_principal` para más información.
    Output
      tibble [1,000 x 27] (S3: tbl_df/tbl/data.frame)
       $ EFT_PERIODO               : chr [1:1000] "1/2000" "1/2000" "1/2000" "1/2000" ...
       $ EFT_VIVIENDA              : num [1:1000] 151 334 512 651 854 ...
       $ EFT_HOGAR                 : num [1:1000] 1 1 1 1 1 1 1 1 1 1 ...
       $ EFT_MIEMBRO               : num [1:1000] 1 1 4 1 3 3 2 3 2 2 ...
       $ EFT_EDAD                  : num [1:1000] 58 28 5 28 41 11 3 21 40 21 ...
       $ EFT_TRABAJO_SEM_ANT       : num [1:1000] 1 1 NA 1 1 2 NA 2 1 1 ...
        ..- attr(*, "label")= chr "¿Trabajó o realizó una actividad económica por lo menos una hora la semana pasada?"
        ..- attr(*, "labels")= Named num [1:2] 1 2
        .. ..- attr(*, "names")= chr [1:2] "Sí" "No"
       $ EFT_TUVO_ACT_ECON_SEM_ANT : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "Aunque no trabajó la semana pasada ¿tenía algún empleo, negocio o actividad?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica (Trabajó)" "Sí" "No"
       $ EFT_CULTIVO_SEM_ANT       : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Cultivó, cosechó, o cuidó ganado?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_ELAB_PROD_SEM_ANT     : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Elaboró algún producto (artesanía,comida) para la venta?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_AYUDO_FAM_SEM_ANT     : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Ayudó algún familiar en su negocio,empresa o finca?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_COSIO_LAVO_SEM_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿Buscó trabajo la semana pasada o estuvo tratando de establecer su propio negocio, actividad económica o empresa?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_BUSCO_TRAB_SEM_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Buscaría un trabajo?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_BUSCO_TRAB_MES_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿En el mes pasado, ¿Buscaría un trabajo?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_TRABAJO_ANTES         : num [1:1000] 0 0 NA 0 0 0 NA 0 0 0 ...
        ..- attr(*, "label")= chr "¿Ha trabajado antes?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_TIENE_COND_JORNADA    : num [1:1000] NA NA NA NA NA NA NA NA NA NA ...
        ..- attr(*, "label")= chr "¿La semana pasada habría tenido el tiempo y las condiciones necesarias para salir a trabajar?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_OCUPACION_PRINC       : num [1:1000] 242 713 NA 341 514 0 NA 0 522 721 ...
       $ EFT_CATEGORIA_OCUP_PRINC  : num [1:1000] 3 5 NA 3 3 0 NA 0 5 3 ...
        ..- attr(*, "label")= chr "En esa ocupación, ¿usted es? (o usted era, para los desempleados)"
        ..- attr(*, "labels")= Named num [1:8] 1 2 3 4 5 6 7 8
        .. ..- attr(*, "names")= chr [1:8] "Empleado u obrero del Gobierno general" "Empleado u obrero de empresas públicas" "Empleado u obrero de empresas privadas" "Trabajador por cuenta propia profesional" ...
       $ EFT_CANT_PERS_TRAB        : num [1:1000] 1 1 NA 4 2 0 NA 0 1 2 ...
        ..- attr(*, "label")= chr "¿Cuántas personas trabajan o trabajaban en ese negocio, actividad económica o empresa?"
        ..- attr(*, "labels")= Named num [1:7] 1 2 3 4 5 6 7
        .. ..- attr(*, "names")= chr [1:7] "1 persona" "2 a 4 personas" "5 a 10 personas" "11 a 19 personas" ...
       $ EFT_HORAS_SEM_OCUP_PRINC  : num [1:1000] 35 50 NA 50 28 0 NA 0 25 50 ...
       $ EFT_PERIODO_ING_OCUP_PRINC: num [1:1000] 5 4 NA 4 4 0 NA 0 3 5 ...
        ..- attr(*, "label")= chr "Periodo de ingreso en su ocupación principal"
        ..- attr(*, "labels")= Named num [1:5] 1 2 3 4 5
        .. ..- attr(*, "names")= chr [1:5] "Hora" "Día" "Semana" "Quincena" ...
       $ EFT_ING_OCUP_PRINC        : num [1:1000] 12000 5000 NA 6000 1500 0 NA 0 600 5000 ...
       $ EFT_DIAS_SEM_OCUP_PRINC   : num [1:1000] 0 0 NA 0 0 0 NA 0 0 0 ...
       $ EFT_PROVINCIA             : num [1:1000] 1 1 1 1 1 1 1 1 1 27 ...
        ..- attr(*, "label")= chr "Provincia"
        ..- attr(*, "labels")= Named num [1:32] 1 2 3 4 5 6 7 8 9 10 ...
        .. ..- attr(*, "names")= chr [1:32] "Distrito Nacional" "Azua" "Bahoruco" "Barahona" ...
       $ EFT_ZONA                  : num [1:1000] 0 0 0 0 0 0 0 0 0 0 ...
        ..- attr(*, "label")= chr "Zona de residencia"
        ..- attr(*, "labels")= Named num [1:2] 0 1
        .. ..- attr(*, "names")= chr [1:2] "Zona urbana" "Zona rural"
       $ EFT_FACTOR_EXP_ANUAL      : num [1:1000] 180 122 206 110 128 ...
       $ EFT_FACTOR_EXP            : num [1:1000] 360 245 413 220 256 197 250 286 273 480 ...
       $ EFT_SEXO                  : num [1:1000] 2 1 2 1 2 1 2 2 2 1 ...
        ..- attr(*, "label")= chr "Sexo de la persona"
        ..- attr(*, "labels")= Named num [1:2] 1 2
        .. ..- attr(*, "names")= chr [1:2] "Hombre" "Mujer"

---

    Code
      str(ft_setLabels(enft_like, dict))
    Warning <lifecycle_warning_deprecated>
      `ft_setLabels()` was deprecated in enftr 0.1.0.
      Please use `ft_set_labels()` instead.
    Message <cliMessage>
      ! EFT_CATEGORIA_OCUP_PRINC: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2004 y 2005-2016. Vea `enftr::ft_categoria_ocupacion_principal` para más información.
      ! EFT_CANT_PERS_TRAB: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2003 y 2004-2016. Vea `enftr::ft_cantidad_personas_trabajan` para más información.
      ! EFT_DIAS_SEM_OCUP_PRINC: Esta variable imputa cero (0) en los casos que no aplica para el periodo 2000-2005. Vea `enftr::ft_dias_semana_ocupacion_principal` para más información.
    Output
      tibble [1,000 x 27] (S3: tbl_df/tbl/data.frame)
       $ EFT_PERIODO               : chr [1:1000] "1/2000" "1/2000" "1/2000" "1/2000" ...
       $ EFT_VIVIENDA              : num [1:1000] 151 334 512 651 854 ...
       $ EFT_HOGAR                 : num [1:1000] 1 1 1 1 1 1 1 1 1 1 ...
       $ EFT_MIEMBRO               : num [1:1000] 1 1 4 1 3 3 2 3 2 2 ...
       $ EFT_EDAD                  : num [1:1000] 58 28 5 28 41 11 3 21 40 21 ...
       $ EFT_TRABAJO_SEM_ANT       : num [1:1000] 1 1 NA 1 1 2 NA 2 1 1 ...
        ..- attr(*, "label")= chr "¿Trabajó o realizó una actividad económica por lo menos una hora la semana pasada?"
        ..- attr(*, "labels")= Named num [1:2] 1 2
        .. ..- attr(*, "names")= chr [1:2] "Sí" "No"
       $ EFT_TUVO_ACT_ECON_SEM_ANT : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "Aunque no trabajó la semana pasada ¿tenía algún empleo, negocio o actividad?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica (Trabajó)" "Sí" "No"
       $ EFT_CULTIVO_SEM_ANT       : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Cultivó, cosechó, o cuidó ganado?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_ELAB_PROD_SEM_ANT     : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Elaboró algún producto (artesanía,comida) para la venta?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_AYUDO_FAM_SEM_ANT     : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Ayudó algún familiar en su negocio,empresa o finca?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_COSIO_LAVO_SEM_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿Buscó trabajo la semana pasada o estuvo tratando de establecer su propio negocio, actividad económica o empresa?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_BUSCO_TRAB_SEM_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿La semana pasada, ¿Buscaría un trabajo?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_BUSCO_TRAB_MES_ANT    : num [1:1000] 0 0 NA 0 0 2 NA 2 0 0 ...
        ..- attr(*, "label")= chr "¿En el mes pasado, ¿Buscaría un trabajo?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_TRABAJO_ANTES         : num [1:1000] 0 0 NA 0 0 0 NA 0 0 0 ...
        ..- attr(*, "label")= chr "¿Ha trabajado antes?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_TIENE_COND_JORNADA    : num [1:1000] NA NA NA NA NA NA NA NA NA NA ...
        ..- attr(*, "label")= chr "¿La semana pasada habría tenido el tiempo y las condiciones necesarias para salir a trabajar?"
        ..- attr(*, "labels")= Named num [1:3] 0 1 2
        .. ..- attr(*, "names")= chr [1:3] "No aplica" "Sí" "No"
       $ EFT_OCUPACION_PRINC       : num [1:1000] 242 713 NA 341 514 0 NA 0 522 721 ...
       $ EFT_CATEGORIA_OCUP_PRINC  : num [1:1000] 3 5 NA 3 3 0 NA 0 5 3 ...
        ..- attr(*, "label")= chr "En esa ocupación, ¿usted es? (o usted era, para los desempleados)"
        ..- attr(*, "labels")= Named num [1:8] 1 2 3 4 5 6 7 8
        .. ..- attr(*, "names")= chr [1:8] "Empleado u obrero del Gobierno general" "Empleado u obrero de empresas públicas" "Empleado u obrero de empresas privadas" "Trabajador por cuenta propia profesional" ...
       $ EFT_CANT_PERS_TRAB        : num [1:1000] 1 1 NA 4 2 0 NA 0 1 2 ...
        ..- attr(*, "label")= chr "¿Cuántas personas trabajan o trabajaban en ese negocio, actividad económica o empresa?"
        ..- attr(*, "labels")= Named num [1:7] 1 2 3 4 5 6 7
        .. ..- attr(*, "names")= chr [1:7] "1 persona" "2 a 4 personas" "5 a 10 personas" "11 a 19 personas" ...
       $ EFT_HORAS_SEM_OCUP_PRINC  : num [1:1000] 35 50 NA 50 28 0 NA 0 25 50 ...
       $ EFT_PERIODO_ING_OCUP_PRINC: num [1:1000] 5 4 NA 4 4 0 NA 0 3 5 ...
        ..- attr(*, "label")= chr "Periodo de ingreso en su ocupación principal"
        ..- attr(*, "labels")= Named num [1:5] 1 2 3 4 5
        .. ..- attr(*, "names")= chr [1:5] "Hora" "Día" "Semana" "Quincena" ...
       $ EFT_ING_OCUP_PRINC        : num [1:1000] 12000 5000 NA 6000 1500 0 NA 0 600 5000 ...
       $ EFT_DIAS_SEM_OCUP_PRINC   : num [1:1000] 0 0 NA 0 0 0 NA 0 0 0 ...
       $ EFT_PROVINCIA             : num [1:1000] 1 1 1 1 1 1 1 1 1 27 ...
        ..- attr(*, "label")= chr "Provincia"
        ..- attr(*, "labels")= Named num [1:32] 1 2 3 4 5 6 7 8 9 10 ...
        .. ..- attr(*, "names")= chr [1:32] "Distrito Nacional" "Azua" "Bahoruco" "Barahona" ...
       $ EFT_ZONA                  : num [1:1000] 0 0 0 0 0 0 0 0 0 0 ...
        ..- attr(*, "label")= chr "Zona de residencia"
        ..- attr(*, "labels")= Named num [1:2] 0 1
        .. ..- attr(*, "names")= chr [1:2] "Zona urbana" "Zona rural"
       $ EFT_FACTOR_EXP_ANUAL      : num [1:1000] 180 122 206 110 128 ...
       $ EFT_FACTOR_EXP            : num [1:1000] 360 245 413 220 256 197 250 286 273 480 ...
       $ EFT_SEXO                  : num [1:1000] 2 1 2 1 2 1 2 2 2 1 ...
        ..- attr(*, "label")= chr "Sexo de la persona"
        ..- attr(*, "labels")= Named num [1:2] 1 2
        .. ..- attr(*, "names")= chr [1:2] "Hombre" "Mujer"

---

    Code
      ft_use_labels(enft_like, dict) %>% dplyr::glimpse()
    Message <cliMessage>
      ! EFT_CATEGORIA_OCUP_PRINC: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2004 y 2005-2016. Vea `enftr::ft_categoria_ocupacion_principal` para más información.
      ! EFT_CANT_PERS_TRAB: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2003 y 2004-2016. Vea `enftr::ft_cantidad_personas_trabajan` para más información.
      ! EFT_DIAS_SEM_OCUP_PRINC: Esta variable imputa cero (0) en los casos que no aplica para el periodo 2000-2005. Vea `enftr::ft_dias_semana_ocupacion_principal` para más información.
      The following (3) variables were not labeled since they contain values not
      present in the dictionary:
      * EFT_CATEGORIA_OCUP_PRINC
      * EFT_CANT_PERS_TRAB
      * EFT_PERIODO_ING_OCUP_PRINC
      Please visit
      <https://adatar-do.github.io/labeler/articles/labeler.html#checking-labels> for
      more details.
    Output
      Rows: 1,000
      Columns: 27
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <fct> Sí, Sí, NA, Sí, Sí, No, NA, No, Sí, Sí, Sí,~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <fct> No aplica (Trabajó), No aplica (Trabajó), N~
      $ EFT_CULTIVO_SEM_ANT        <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_ELAB_PROD_SEM_ANT      <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_AYUDO_FAM_SEM_ANT      <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_COSIO_LAVO_SEM_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_BUSCO_TRAB_SEM_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_BUSCO_TRAB_MES_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_TRABAJO_ANTES          <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_TIENE_COND_JORNADA     <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <fct> Distrito Nacional, Distrito Nacional, Distr~
      $ EFT_ZONA                   <fct> Zona urbana, Zona urbana, Zona urbana, Zona~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <fct> Mujer, Hombre, Mujer, Hombre, Mujer, Hombre~

---

    Code
      ft_useLabels(enft_like, dict) %>% dplyr::glimpse()
    Warning <lifecycle_warning_deprecated>
      `ft_useLabels()` was deprecated in enftr 0.1.0.
      Please use `ft_use_labels()` instead.
    Message <cliMessage>
      ! EFT_CATEGORIA_OCUP_PRINC: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2004 y 2005-2016. Vea `enftr::ft_categoria_ocupacion_principal` para más información.
      ! EFT_CANT_PERS_TRAB: Esta variable tiene un problema de compatibilidad entre los periodos 2000-2003 y 2004-2016. Vea `enftr::ft_cantidad_personas_trabajan` para más información.
      ! EFT_DIAS_SEM_OCUP_PRINC: Esta variable imputa cero (0) en los casos que no aplica para el periodo 2000-2005. Vea `enftr::ft_dias_semana_ocupacion_principal` para más información.
      The following (3) variables were not labeled since they contain values not
      present in the dictionary:
      * EFT_CATEGORIA_OCUP_PRINC
      * EFT_CANT_PERS_TRAB
      * EFT_PERIODO_ING_OCUP_PRINC
      Please visit
      <https://adatar-do.github.io/labeler/articles/labeler.html#checking-labels> for
      more details.
    Output
      Rows: 1,000
      Columns: 27
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <fct> Sí, Sí, NA, Sí, Sí, No, NA, No, Sí, Sí, Sí,~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <fct> No aplica (Trabajó), No aplica (Trabajó), N~
      $ EFT_CULTIVO_SEM_ANT        <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_ELAB_PROD_SEM_ANT      <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_AYUDO_FAM_SEM_ANT      <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_COSIO_LAVO_SEM_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_BUSCO_TRAB_SEM_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_BUSCO_TRAB_MES_ANT     <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_TRABAJO_ANTES          <fct> No aplica, No aplica, NA, No aplica, No apl~
      $ EFT_TIENE_COND_JORNADA     <fct> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <fct> Distrito Nacional, Distrito Nacional, Distr~
      $ EFT_ZONA                   <fct> Zona urbana, Zona urbana, Zona urbana, Zona~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <fct> Mujer, Hombre, Mujer, Hombre, Mujer, Hombre~

---

    Code
      ft_browse_dict(testing = TRUE)
    Output
                                   var
      1     EFT_ACEPTARIA_TRAB_SEM_ANT
      2           EFT_AGUA_RED_PUBLICA
      3                EFT_ALFABETISMO
      4          EFT_AYUDO_FAM_SEM_ANT
      5         EFT_BUSCO_TRAB_SEM_ANT
      6         EFT_BUSCO_TRAB_MES_ANT
      7             EFT_CANT_PERS_TRAB
      8       EFT_CATEGORIA_OCUP_PRINC
      9         EFT_COSIO_LAVO_SEM_ANT
      10           EFT_CULTIVO_SEM_ANT
      11       EFT_DIAS_SEM_OCUP_PRINC
      12                      EFT_EDAD
      13         EFT_ELAB_PROD_SEM_ANT
      14      EFT_HORAS_SEM_OCUP_PRINC
      15            EFT_ING_OCUP_PRINC
      16    EFT_PERIODO_ING_OCUP_PRINC
      17                 EFT_PROVINCIA
      18           EFT_OCUPACION_PRINC
      19       EFT_PARENTESCO_CON_JEFE
      20                   EFT_PERIODO
      21                      EFT_SEXO
      22        EFT_TIENE_COND_JORNADA
      23             EFT_TRABAJO_ANTES
      24           EFT_TRABAJO_SEM_ANT
      25     EFT_TUVO_ACT_ECON_SEM_ANT
      26          EFT_ULT_ANO_APROBADO
      27       EFT_ULT_NIVEL_ALCANZADO
      28                      EFT_ZONA
      29                      PERIALFA
      30                        S1B_P2
      31                        S1B_P4
      32                        S2_P2A
      33                        S2_P2C
      34                        S2_P2D
      35                        S2_P7A
      36                         S2_P9
      37                        S3B_P4
      38                        S3B_P8
      39                        S3B_P9
      40                       S3B_P10
      41                      alfabeta
      42                           ano
      43    cantidad_personas_trabajan
      44 categoria_ocupacion_principal
      45             desempleo_abierto
      46            desempleo_ampliado
      47     desempleo_cesante_abierto
      48    desempleo_cesante_ampliado
      49       desempleo_nuevo_abierto
      50      desempleo_nuevo_ampliado
      51           dominios_inferencia
      52          dominios_inferencia1
      53          dominios_inferencia2
      54          dominios_inferencia3
      55               grupo_ocupacion
      56                    grupo_rama
      57                 horas_semanal
      58       ingreso_laboral_mensual
      59                       ocupado
      60                   pea_abierta
      61                  pea_ampliada
      62          perceptores_ingresos
      63                       periodo
      64                           pet
      65            poblacion_inactiva
      66                  pobreza_zona
      67    regiones_desarrollo_710_04
      68    regiones_desarrollo_685_00
      69              sector_ocupacion
      70                      semestre
      71                          zona
      72    zona_desarrollo_fronterizo
                                                                                                                       lab
      1                                   ¿Pudiera haber aceptado un trabajo la semana pasada si le hubieran ofrecido uno?
      2                       ¿Tiene esta vivienda instalación para agua corriente por tubería conectada a la red pública?
      3                                                                                             ¿Sabe leer y escribir?
      4                                            ¿La semana pasada, ¿Ayudó algún familiar en su negocio,empresa o finca?
      5                                                                           ¿La semana pasada, ¿Buscaría un trabajo?
      6                                                                           ¿En el mes pasado, ¿Buscaría un trabajo?
      7                             ¿Cuántas personas trabajan o trabajaban en ese negocio, actividad económica o empresa?
      8                                                  En esa ocupación, ¿usted es? (o usted era, para los desempleados)
      9  ¿Buscó trabajo la semana pasada o estuvo tratando de establecer su propio negocio, actividad económica o empresa?
      10                                                             ¿La semana pasada, ¿Cultivó, cosechó, o cuidó ganado?
      11                                                  ¿Cuántós días a la semana trabaja regularmente en esa ocupación?
      12                                                                                ¿Qué edad tiene en años cumplidos?
      13                                      ¿La semana pasada, ¿Elaboró algún producto (artesanía,comida) para la venta?
      14                                         ¿Cuántas horas trabaja regularmente por semana en su ocupación principal?
      15                          En su ocupación principal ¿cuánto ganó por concepto de sueldo bruto, jornal o ganancias?
      16                                                                      Periodo de ingreso en su ocupación principal
      17                                                                                                         Provincia
      18                              ¿Cuál es el oficio u ocupación principal que realiza o realizó en su último trabajo?
      19                                               ¿Cuál es la relación de parentesco que tiene con el jefe del hogar?
      20                                                                           Periodo de levantamiento de la encuesta
      21                                                                                                Sexo de la persona
      22                     ¿La semana pasada habría tenido el tiempo y las condiciones necesarias para salir a trabajar?
      23                                                                                              ¿Ha trabajado antes?
      24                                ¿Trabajó o realizó una actividad económica por lo menos una hora la semana pasada?
      25                                      Aunque no trabajó la semana pasada ¿tenía algún empleo, negocio o actividad?
      26                                                                        ¿Cuál es el último año o curso que aprobó?
      27                                                       ¿A qué nivel corresponde ese último año o curso que aprobó?
      28                                                                                                Zona de residencia
      29                                                                           Periodo de levantamiento de la encuesta
      30                                                                                                         Provincia
      31                                                                                                Zona de residencia
      32                                                                              Material predominante en las paredes
      33                                                                                 Material predominante en el techo
      34                                                                                  Material predominante en el piso
      35                                                ¿Qué tipo de alumbrado se utiliza principalmente en esta vivienda?
      36                                                                                                ¿La vivenda posee?
      37                                                                                ¿Qué edad tiene en años cumplidos?
      38                                                                        ¿Cuál es el último año o curso que aprobó?
      39                                                       ¿A qué nivel corresponde ese último año o curso que aprobó?
      40                                                      The link 'EFT_SE_MATRICULO' is not defined in the dictionary
      41                                                                                  Indica si la persona es alfabeta
      42                                                                                                        Año (YYYY)
      43                                                                   Cantidad de personas que trabajan en la empresa
      44                                                                               Categoría de la ocupación principal
      45                                                                     Población en condiciones de desempleo abierto
      46                                                                    Población en condiciones de desempleo ampliado
      47                                                               Población cesante en condición de desempleo abierto
      48                                                              Población cesante en condición de desempleo ampliado
      49                                                                 Población nueva en condición de desempleo abierto
      50                                                                Población nueva en condición de desempleo ampliado
      51                                                                                            Dominios de inferencia
      52                                                                     Dominios de inferencia 1 (ENFT 20001 - 20031)
      53                                                                     Dominios de inferencia 2 (ENFT 20032 - 20072)
      54                                                                     Dominios de inferencia 3 (ENFT 20081 - 20162)
      55                                                                                      Grupo ocupacional del empleo
      56                                                                            Grupos de Ramas de Actividad Económica
      57                                                                                      Horas trabajadas a la semana
      58                                            Ingreso laboral mensual de la población ocupada perceptora de ingresos
      59                                                                                                 Población ocupada
      60                                                                     Población Económicamente Activa (PEA) abierta
      61                                                                    Población Económicamente Activa (PEA) ampliada
      62                                                                          Población ocupada perceptora de ingresos
      63                                                                                                   Periodo (YYYYS)
      64                                                                                     Población en edad de trabajar
      65                                                                                                Población inactiva
      66                                                                          Pobreza monetaria por zona de residencia
      67                                                                           Regiones de desarrollo (Decreto 710-04)
      68                                                                           Regiones de desarrollo (Decreto 685-00)
      69                                                                                            Sector de la ocupación
      70                                                                                            Semestre en el año (S)
      71                                                                                                Zona de residencia
      72                                                                                     Zona de desarrollo fronterizo
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        labs
      1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Sí<br />2: No<br /></div>
      2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Sí<br />2: No<br /></div>
      3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: 1 persona<br />2: 2 a 4 personas<br />3: 5 a 10 personas<br />4: 11 a 19 personas<br />5: 20 a 30 personas<br />6: 31 a 50 personas<br />7: 51 y más personas<br /></div>
      8                                                                                                                                                                                                                                                                                                                                                                                                                                                                              <div>1: Empleado u obrero del Gobierno general<br />2: Empleado u obrero de empresas públicas<br />3: Empleado u obrero de empresas privadas<br />4: Trabajador por cuenta propia profesional<br />5: Trabajador por cuenta propia no profesional<br />6: Patrón de empresas no constituidas en sociedades<br />7: Ayudante familiar o no familiar no remunerado<br />8: Servicio doméstico<br /></div>
      9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      13                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      14                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      15                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Hora<br />2: Día<br />3: Semana<br />4: Quincena<br />5: Mes<br /></div>
      17                                                                                                                                                                                     <div>1: Distrito Nacional<br />2: Azua<br />3: Bahoruco<br />4: Barahona<br />5: Dajabón<br />6: Duarte<br />7: Elías Piña<br />8: El Seibo<br />9: Espaillat<br />10: Independencia<br />11: La Altagracia<br />12: La Romana<br />13: La Vega<br />14: María Trinidad Sánchez<br />15: Monte Cristi<br />16: Pedernales<br />17: Peravia<br />18: Puerto Plata<br />19: Salcedo<br />20: Samaná<br />21: San Cristóbal<br />22: San Juan<br />23: San Pedro de Macorís<br />24: Sánchez Ramírez<br />25: Santiago<br />26: Santiago Rodríguez<br />27: Valverde<br />28: Monseñor Nouel<br />29: Monte Plata<br />30: Hato Mayor<br />31: San José de Ocoa<br />32: Santo Domingo<br /></div>
      18                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      19                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>1: Jefe del hogar<br />2: Espesa(o) o compañera(o)<br />3: Hijo(a)<br />4: Hijastro(a)<br />5: Nieto(a)<br />6: Yerno o nuera<br />7: Padre o madre<br />8: Suegro(a)<br />9: Hermano(a)<br />10: Abuelo(a)<br />11: Otro pariente<br /></div>
      20                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      21                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            <div>1: Hombre<br />2: Mujer<br /></div>
      22                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>0: No aplica<br />1: Sí<br />2: No<br /></div>
      24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />2: No<br /></div>
      25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       <div>0: No aplica (Trabajó)<br />1: Sí<br />2: No<br /></div>
      26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      27                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <div>1: Preprimario<br />2: Primario<br />3: Secundario<br />4: Vocacional<br />5: Universitario<br />6: Post-universitario<br />7: Ninguno<br />8: Quisqueya Aprende<br />96: No aplica<br /></div>
      28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: Zona urbana<br />1: Zona rural<br /></div>
      29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      30                                                                                                                                                                                     <div>1: Distrito Nacional<br />2: Azua<br />3: Bahoruco<br />4: Barahona<br />5: Dajabón<br />6: Duarte<br />7: Elías Piña<br />8: El Seibo<br />9: Espaillat<br />10: Independencia<br />11: La Altagracia<br />12: La Romana<br />13: La Vega<br />14: María Trinidad Sánchez<br />15: Monte Cristi<br />16: Pedernales<br />17: Peravia<br />18: Puerto Plata<br />19: Salcedo<br />20: Samaná<br />21: San Cristóbal<br />22: San Juan<br />23: San Pedro de Macorís<br />24: Sánchez Ramírez<br />25: Santiago<br />26: Santiago Rodríguez<br />27: Valverde<br />28: Monseñor Nouel<br />29: Monte Plata<br />30: Hato Mayor<br />31: San José de Ocoa<br />32: Santo Domingo<br /></div>
      31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>0: Zona urbana<br />1: Zona rural<br /></div>
      32                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <div>1: Asbesto<br />2: Block<br />3: Cartón<br />4: Concreto Armado<br />5: Ladrillo<br />6: Madera<br />7: Mixto (block y madera)<br />8: Plywood<br />9: Tabla de Palma<br />10: Tejamanil<br />11: Yagua<br />12: Zinc<br />13: Materiales de desecho<br />99: Otro<br /></div>
      33                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          <div>1: Asbesto<br />2: Concreto Armado<br />3: Yagua<br />4: Zinc<br />5: Materiales de desecho<br />99: Otro<br /></div>
      34                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            <div>1: Cemento<br />2: Cerámica<br />3: Granito<br />4: Ladrillo<br />5: Madera<br />6: Mármol<br />7: Mosaico<br />8: Parquet<br />9: Tierra<br />99: Otro<br /></div>
      35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Electricidad de las empresas (CDEE/EDES)<br />2: Generación privada<br />3: Planta eléctrica<br />4: Lámpara de gas kerosén<br />5: Lámpara de gas propano<br />6: Panel solar<br />99: Otro<br /></div>
      36                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Inodoro conectado a alcantarillado<br />2: Inodoro conectado a pozo séptico<br />3: Letrina<br />4: No tiene<br /></div>
      37                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      38                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      39                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <div>1: Preprimario<br />2: Primario<br />3: Secundario<br />4: Vocacional<br />5: Universitario<br />6: Post-universitario<br />7: Ninguno<br />8: Quisqueya Aprende<br />96: No aplica<br /></div>
      40                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>999: The link 'EFT_SE_MATRICULO' is not defined in the dictionary<br /></div>
      41                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Si<br />2: No<br /></div>
      42                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      43                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       <div>1: 1 a 4 personas<br />2: 5 a 10 personas<br />3: 11 a 19 personas<br />4: 20 o más personas<br /></div>
      44                                                                                                                                                                                                                                                                                                                                                                                                                                                                             <div>1: Empleado u obrero del Gobierno general<br />2: Empleado u obrero de empresas públicas<br />3: Empleado u obrero de empresas privadas<br />4: Trabajador por cuenta propia profesional<br />5: Trabajador por cuenta propia no profesional<br />6: Patrón de empresas no constituidas en sociedades<br />7: Ayudante familiar o no familiar no remunerado<br />8: Servicio doméstico<br /></div>
      45                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      46                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      47                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      48                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      49                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      50                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      51 <div>1: Distrito Nacional (Ozama)<br />2: Resto urbano<br />3: Resto rural<br />4: Región Valdesia<br />5: Región Este<br />6: Región Nordeste<br />7: Región Cibao Central<br />8: Región Norcentral<br />9: Región Noroeste<br />10: Región El Valle<br />11: Región Enriquillo<br />12: Distrito Nacional<br />13: Santo Domingo<br />14: Santiago<br />15: Espaillat<br />16: Puerto Plata<br />17: La Vega<br />18: Resto Región Cibao Sur<br />19: Duarte<br />20: María Trinidad Sánchez<br />21: Samaná<br />22: Hermanas Mirabal<br />23: Valverde<br />24: Resto Región Cibao Noroeste<br />25: San Cristóbal<br />26: Resto Región Valdesia<br />27: San Juan<br />28: Elías Piña<br />29: Barahona<br />30: Resto Región Enriquillo<br />31: San Pedro de Macorís<br />32: Resto Región Higuamo<br />33: La Romana<br />34: La Altagracia<br />35: El Seibo<br /></div>
      52                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              <div>1: Distrito Nacional (Ozama)<br />2: Resto urbano<br />3: Resto rural<br /></div>
      53                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>1: Distrito Nacional (Ozama)<br />2: Región Valdesia<br />3: Región Este<br />4: Región Nordeste<br />5: Región Cibao Central<br />6: Región Norcentral<br />7: Región Noroeste<br />8: Región El Valle<br />9: Región Enriquillo<br /></div>
      54                                                                                                                                                                                                                                                                                            <div>1: Distrito Nacional<br />2: Santo Domingo<br />3: Santiago<br />4: Espaillat<br />5: Puerto Plata<br />6: La Vega<br />7: Resto Región Cibao Sur<br />8: Duarte<br />9: María Trinidad Sánchez<br />10: Samaná<br />11: Hermanas Mirabal<br />12: Valverde<br />13: Resto Región Cibao Noroeste<br />14: San Cristóbal<br />15: Resto Región Valdesia<br />16: San Juan<br />17: Elías Piña<br />18: Barahona<br />19: Resto Región Enriquillo<br />20: San Pedro de Macorís<br />21: Resto Región Higuamo<br />22: La Romana<br />23: La Altagracia<br />24: El Seibo<br /></div>
      55                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Gerentes y Administradores<br />2: Profesionales e Intelectuales<br />3: Técnicos del Nivel Medio<br />4: Empleados de oficina<br />5: Trabajadores de los Servicios<br />6: Agricultores y Ganaderos Calificados<br />7: Operarios y Artesanos<br />8: Operarios y Conductores<br />9: Trabajadores no Calificados<br />10: Población sin Grupo Ocupacional<br /></div>
      56                                                                                                                                                                                                                                                                                                                                                                                                                                                                           <div>1: Agricultura y Ganadería<br />2: Explotación de Minas y Canteras<br />3: Industrias Manufactureras<br />4: Electricidad, Gas y Agua<br />5: Construcción<br />6: Comercio al por Mayor y Menor<br />7: Hoteles, Bares y Restaurantes<br />8: Transporte y Comunicaciones<br />9: Intermediación Financiera y Seguros<br />10: Administración Pública y Defensa<br />11: Otros Servicio<br /></div>
      57                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      58                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      59                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      60                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      61                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      62                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      63                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      64                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      65                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <div>1: Sí<br />0: No<br /></div>
      66                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     <div>1: Pobre indigente<br />2: Pobre no indigente<br />3: No Pobre<br /></div>
      67                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    <div>1: Cibao Norte<br />2: Cibao Sur<br />3: Cibao Nordeste<br />4: Cibao Noroeste<br />5: Valdesia<br />6: Enriquillo<br />7: El Valle<br />8: Yuma<br />9: Higuamo<br />10: Ozama o Metropolitana<br /></div>
      68                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>1: Distrito Nacional (Ozama)<br />2: Región Valdesia<br />3: Región Este<br />4: Región Nordeste<br />5: Región Cibao Central<br />6: Región Norcentral<br />7: Región Noroeste<br />8: Región El Valle<br />9: Región Enriquillo<br /></div>
      69                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div>1: Formal<br />0: Informal<br /></div>
      70                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         <div></div>
      71                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  <div>1: Zona urbana<br />2: Zona rural<br /></div>
      72                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <div>1: Zona de desarrollo fronterizo<br />0: Resto país<br /></div>
                                                                                                                                                                    warn
      1                                                                                                                                                             <NA>
      2                                                                                                                                                             <NA>
      3                                                                                                                                                             <NA>
      4                                                                                                                                                             <NA>
      5                                                                                                                                                             <NA>
      6                                                                                                                                                             <NA>
      7     Esta variable tiene un problema de compatibilidad entre los periodos 2000-2003 y 2004-2016. Vea `enftr::ft_cantidad_personas_trabajan` para más información.
      8  Esta variable tiene un problema de compatibilidad entre los periodos 2000-2004 y 2005-2016. Vea `enftr::ft_categoria_ocupacion_principal` para más información.
      9                                                                                                                                                             <NA>
      10                                                                                                                                                            <NA>
      11       Esta variable imputa cero (0) en los casos que no aplica para el periodo 2000-2005. Vea `enftr::ft_dias_semana_ocupacion_principal` para más información.
      12                                                                                                                                                            <NA>
      13                                                                                                                                                            <NA>
      14                                                                                                                                                            <NA>
      15                                                                                                                                                            <NA>
      16                                                                                                                                                            <NA>
      17                                                                                                                                                            <NA>
      18                                                                                                                                                            <NA>
      19                                                                                                                                                            <NA>
      20                                                                                                                                                            <NA>
      21                                                                                                                                                            <NA>
      22                                                                                                                                                            <NA>
      23                                                                                                                                                            <NA>
      24                                                                                                                                                            <NA>
      25                                                                                                                                                            <NA>
      26                                                                                                                                                            <NA>
      27                                                                                                                                                            <NA>
      28                                                                                                                                                            <NA>
      29                                                                                                                                                            <NA>
      30                                                                                                                                                            <NA>
      31                                                                                                                                                            <NA>
      32                                                                                                                                                            <NA>
      33                                                                                                                                                            <NA>
      34                                                                                                                                                            <NA>
      35                                                                                                                                                            <NA>
      36                                                                                                                                                            <NA>
      37                                                                                                                                                            <NA>
      38                                                                                                                                                            <NA>
      39                                                                                                                                                            <NA>
      40                                                                                                                                                            <NA>
      41                                                                                                                                                            <NA>
      42                                                                                                                                                            <NA>
      43                                                                                                                                                            <NA>
      44                                                                                                                                                            <NA>
      45                                                                                                                                                            <NA>
      46                                                                                                                                                            <NA>
      47                                                                                                                                                            <NA>
      48                                                                                                                                                            <NA>
      49                                                                                                                                                            <NA>
      50                                                                                                                                                            <NA>
      51                                                                                                                                                            <NA>
      52                                                                                                                                                            <NA>
      53                                                                                                                                                            <NA>
      54                                                                                                                                                            <NA>
      55                                                                                                                                                            <NA>
      56                                                                                                                                                            <NA>
      57                                                                                                                                                            <NA>
      58                                                                                                                                                            <NA>
      59                                                                                                                                                            <NA>
      60                                                                                                                                                            <NA>
      61                                                                                                                                                            <NA>
      62                                                                                                                                                            <NA>
      63                                                                                                                                                            <NA>
      64                                                                                                                                                            <NA>
      65                                                                                                                                                            <NA>
      66                                                                                                                                                            <NA>
      67                                                                                                                                                            <NA>
      68                                                                                                                                                            <NA>
      69                                                                                                                                                            <NA>
      70                                                                                                                                                            <NA>
      71                                                                                                                                                            <NA>
      72                                                                                                                                                            <NA>

