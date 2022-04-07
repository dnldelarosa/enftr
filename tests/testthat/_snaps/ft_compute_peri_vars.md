# multiplication works

    Code
      ft_peri_vars(enft_like) %>% dplyr::glimpse()
    Output
      Rows: 1,000
      Columns: 30
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ semestre                   <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ ano                        <int> 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2~
      $ periodo                    <dbl> 20001, 20001, 20001, 20001, 20001, 20001, 2~

---

    Code
      ft_peri_vars(enft_like, rm = TRUE) %>% dplyr::glimpse()
    Output
      Rows: 1,000
      Columns: 29
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ semestre                   <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ ano                        <int> 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2~
      $ periodo                    <dbl> 20001, 20001, 20001, 20001, 20001, 20001, 2~

---

    Code
      ft_peri_vars(enft_like, ano = FALSE, semestre = FALSE) %>% dplyr::glimpse()
    Output
      Rows: 1,000
      Columns: 28
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ periodo                    <dbl> 20001, 20001, 20001, 20001, 20001, 20001, 2~

---

    Code
      ft_compute_peri_vars(enft_like) %>% dplyr::glimpse()
    Warning <lifecycle_warning_deprecated>
      `ft_compute_peri_vars()` was deprecated in enftr 0.2.0.
      Please use `ft_peri_vars()` instead.
    Output
      Rows: 1,000
      Columns: 30
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ semestre                   <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ ano                        <int> 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2~
      $ periodo                    <dbl> 20001, 20001, 20001, 20001, 20001, 20001, 2~

---

    Code
      ft_compute_ano(enft_like) %>% dplyr::glimpse()
    Warning <lifecycle_warning_deprecated>
      `ft_compute_ano()` was deprecated in enftr 0.3.0.
      Please use `ft_peri_vars()` instead.
    Output
      Rows: 1,000
      Columns: 28
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ ano                        <int> 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2~

---

    Code
      ft_ano(enft_like) %>% dplyr::glimpse()
    Warning <lifecycle_warning_deprecated>
      `ft_ano()` was deprecated in enftr 0.3.0.
      Please use `ft_peri_vars()` instead.
    Output
      Rows: 1,000
      Columns: 28
      $ EFT_PERIODO                <chr> "1/2000", "1/2000", "1/2000", "1/2000", "1/~
      $ EFT_VIVIENDA               <dbl> 151, 334, 512, 651, 854, 868, 1354, 1376, 1~
      $ EFT_HOGAR                  <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1~
      $ EFT_MIEMBRO                <dbl> 1, 1, 4, 1, 3, 3, 2, 3, 2, 2, 2, 3, 3, 7, 4~
      $ EFT_EDAD                   <dbl> 58, 28, 5, 28, 41, 11, 3, 21, 40, 21, 30, 2~
      $ EFT_TRABAJO_SEM_ANT        <dbl> 1, 1, NA, 1, 1, 2, NA, 2, 1, 1, 1, 2, 1, NA~
      $ EFT_TUVO_ACT_ECON_SEM_ANT  <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_CULTIVO_SEM_ANT        <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_ELAB_PROD_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_AYUDO_FAM_SEM_ANT      <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_COSIO_LAVO_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_SEM_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 2, 0, NA~
      $ EFT_BUSCO_TRAB_MES_ANT     <dbl> 0, 0, NA, 0, 0, 2, NA, 2, 0, 0, 0, 1, 0, NA~
      $ EFT_TRABAJO_ANTES          <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 1, 0, NA~
      $ EFT_TIENE_COND_JORNADA     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,~
      $ EFT_OCUPACION_PRINC        <dbl> 242, 713, NA, 341, 514, 0, NA, 0, 522, 721,~
      $ EFT_CATEGORIA_OCUP_PRINC   <dbl> 3, 5, NA, 3, 3, 0, NA, 0, 5, 3, 3, 1, 5, NA~
      $ EFT_CANT_PERS_TRAB         <dbl> 1, 1, NA, 4, 2, 0, NA, 0, 1, 2, 4, 4, 1, NA~
      $ EFT_HORAS_SEM_OCUP_PRINC   <dbl> 35, 50, NA, 50, 28, 0, NA, 0, 25, 50, 40, 0~
      $ EFT_PERIODO_ING_OCUP_PRINC <dbl> 5, 4, NA, 4, 4, 0, NA, 0, 3, 5, 5, 0, 2, NA~
      $ EFT_ING_OCUP_PRINC         <dbl> 12000, 5000, NA, 6000, 1500, 0, NA, 0, 600,~
      $ EFT_DIAS_SEM_OCUP_PRINC    <dbl> 0, 0, NA, 0, 0, 0, NA, 0, 0, 0, 0, 0, 6, NA~
      $ EFT_PROVINCIA              <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 27, 6, 13, 14, 2~
      $ EFT_ZONA                   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1~
      $ EFT_FACTOR_EXP_ANUAL       <dbl> 180.0, 122.5, 206.5, 110.0, 128.0, 98.5, 12~
      $ EFT_FACTOR_EXP             <dbl> 360, 245, 413, 220, 256, 197, 250, 286, 273~
      $ EFT_SEXO                   <dbl> 2, 1, 2, 1, 2, 1, 2, 2, 2, 1, 2, 1, 1, 2, 2~
      $ ano                        <int> 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2~

