\name{ft_sector_ocupacion}
\alias{ft_sector_ocupacion}
\title{Occupational sector}
\usage{
ft_sector_ocupacion(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Occupational sector. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDO_FAM_SEM_ANT, EFT_BUSCO_TRAB_MES_ANT, EFT_BUSCO_TRAB_SEM_ANT, EFT_CANT_PERS_TRAB, EFT_CATEGORIA_OCUP_PRINC, EFT_COSIO_LAVO_SEM_ANT, EFT_CULTIVO_SEM_ANT, EFT_EDAD, EFT_ELAB_PROD_SEM_ANT, EFT_OCUPACION_PRINC, EFT_TIENE_COND_JORNADA, EFT_TRABAJO_SEM_ANT, EFT_TUVO_ACT_ECON_SEM_ANT.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_ocupado(min_edad) \%>\% ft_grupo_ocupacion(min_edad) \%>\% dplyr::mutate(sector_ocupacion = dplyr::case_when(EFT_CATEGORIA_OCUP_PRINC <= 
        3 & dplyr::between(EFT_CANT_PERS_TRAB, 3, 7) ~ 0, EFT_CATEGORIA_OCUP_PRINC \%in\% 4:6 & grupo_ocupacion == 
        1 ~ 0, EFT_CATEGORIA_OCUP_PRINC \%in\% 4:6 & grupo_ocupacion == 2 ~ 0, EFT_CATEGORIA_OCUP_PRINC \%in\% 
        4:6 & EFT_OCUPACION_PRINC == 341 ~ 0, .default = 1), sector_ocupacion = dplyr::case_when(ocupado == 
        1 ~ sector_ocupacion))
\}}}
