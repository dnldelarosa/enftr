\name{ft_horas_semanal}
\alias{ft_horas_semanal}
\title{Weekly hours worked}
\usage{
ft_horas_semanal(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Weekly hours worked. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDO_FAM_SEM_ANT, EFT_CATEGORIA_OCUP_PRINC, EFT_COSIO_LAVO_SEM_ANT, EFT_CULTIVO_SEM_ANT, EFT_EDAD, EFT_ELAB_PROD_SEM_ANT, EFT_HORAS_SEM_OCUP_PRINC, EFT_TRABAJO_SEM_ANT, EFT_TUVO_ACT_ECON_SEM_ANT.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_perceptores_ingresos(min_edad) \%>\% dplyr::mutate(horas_semanal = dplyr::case_when(EFT_HORAS_SEM_OCUP_PRINC > 
        0 & perceptores_ingresos == 1 ~ EFT_HORAS_SEM_OCUP_PRINC))
\}}}
