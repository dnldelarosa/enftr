\name{ft_grupo_ocupacion}
\alias{ft_grupo_ocupacion}
\title{Occupational group}
\usage{
ft_grupo_ocupacion(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Occupational group. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDO_FAM_SEM_ANT, EFT_BUSCO_TRAB_MES_ANT, EFT_BUSCO_TRAB_SEM_ANT, EFT_COSIO_LAVO_SEM_ANT, EFT_CULTIVO_SEM_ANT, EFT_EDAD, EFT_ELAB_PROD_SEM_ANT, EFT_OCUPACION_PRINC, EFT_TIENE_COND_JORNADA, EFT_TRABAJO_SEM_ANT, EFT_TUVO_ACT_ECON_SEM_ANT.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_pea_ampliada(min_edad) \%>\% dplyr::mutate(grupo_ocupacion = dplyr::case_when(EFT_OCUPACION_PRINC < 
        12 ~ 5, dplyr::between(EFT_OCUPACION_PRINC, 12, 199) ~ 1, EFT_OCUPACION_PRINC < 300 ~ 2, EFT_OCUPACION_PRINC < 
        400 ~ 3, EFT_OCUPACION_PRINC < 500 ~ 4, EFT_OCUPACION_PRINC < 600 ~ 5, EFT_OCUPACION_PRINC < 
        700 ~ 6, EFT_OCUPACION_PRINC < 800 ~ 7, EFT_OCUPACION_PRINC < 900 ~ 8, EFT_OCUPACION_PRINC > 
        900 ~ 9, pea_ampliada == 1 ~ 10))
\}}}
