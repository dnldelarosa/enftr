\name{ft_dias_semana_ocupacion_principal}
\alias{ft_dias_semana_ocupacion_principal}
\title{Main-job working days per week}
\usage{
ft_dias_semana_ocupacion_principal(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Main-job working days per week. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_DIAS_SEM_OCUP_PRINC.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(dias_semana_ocupacion_principal = dplyr::case_when(EFT_DIAS_SEM_OCUP_PRINC > 
        0 ~ EFT_DIAS_SEM_OCUP_PRINC))
\}}}
