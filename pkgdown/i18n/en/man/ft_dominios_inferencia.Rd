\name{ft_dominios_inferencia}
\alias{ft_dominios_inferencia}
\title{Period-specific inference domains}
\usage{
ft_dominios_inferencia(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Period-specific inference domains. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO + EFT_ZONA or PERIALFA + S1_P4, EFT_PERIODO or PERIALFA, EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    dominios_inferencia1 <- NULL
    dominios_inferencia2 <- NULL
    dominios_inferencia3 <- NULL
    tbl \%>\% ft_peri_vars() \%>\% ft_dominios_inferencia1() \%>\% ft_dominios_inferencia2() \%>\% ft_dominios_inferencia3() \%>\% 
        dplyr::mutate(dominios_inferencia = dplyr::case_when(dplyr::between(periodo, 20001, 20031) ~ 
            dominios_inferencia1, dplyr::between(periodo, 20032, 20072) & dominios_inferencia2 == 1 ~ 
            1, dplyr::between(periodo, 20032, 20072) ~ dominios_inferencia2 + 2, dplyr::between(periodo, 
            20081, 20162) ~ dominios_inferencia3 + 11))
\}}}
