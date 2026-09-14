\name{ft_perceptores_ingresos}
\alias{ft_perceptores_ingresos}
\title{Labour income recipients}
\usage{
ft_perceptores_ingresos(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Labour income recipients. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDO_FAM_SEM_ANT, EFT_CATEGORIA_OCUP_PRINC, EFT_COSIO_LAVO_SEM_ANT, EFT_CULTIVO_SEM_ANT, EFT_EDAD, EFT_ELAB_PROD_SEM_ANT, EFT_TRABAJO_SEM_ANT, EFT_TUVO_ACT_ECON_SEM_ANT.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_ocupado(min_edad) \%>\% dplyr::mutate(perceptores_ingresos = dplyr::case_when(ocupado == 
        1 & EFT_CATEGORIA_OCUP_PRINC != 7 ~ 1, ocupado == 1 ~ 0))
\}}}
