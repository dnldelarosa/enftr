\name{ft_dominios_inferencia1}
\alias{ft_dominios_inferencia1}
\title{Inference domains for 2000/1 to 2003/1}
\usage{
ft_dominios_inferencia1(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Inference domains for 2000/1 to 2003/1. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO + EFT_ZONA or PERIALFA + S1_P4, EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_zona() \%>\% dplyr::mutate(dominios_inferencia1 = dplyr::case_when(EFT_PROVINCIA \%in\% c(1, 
        32) ~ 1, zona == 1 ~ 2, zona == 2 ~ 3))
\}}}
