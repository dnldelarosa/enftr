\name{ft_dominios_inferencia3}
\alias{ft_dominios_inferencia3}
\title{Inference domains from 2008/1}
\usage{
ft_dominios_inferencia3(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Inference domains from 2008/1. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(dominios_inferencia3 = dplyr::case_when(EFT_PROVINCIA == 1 ~ 1, EFT_PROVINCIA == 
        32 ~ 2, EFT_PROVINCIA == 25 ~ 3, EFT_PROVINCIA == 9 ~ 4, EFT_PROVINCIA == 18 ~ 5, EFT_PROVINCIA == 
        13 ~ 6, EFT_PROVINCIA == 24 ~ 7, EFT_PROVINCIA == 28 ~ 7, EFT_PROVINCIA == 6 ~ 8, EFT_PROVINCIA == 
        14 ~ 9, EFT_PROVINCIA == 20 ~ 10, EFT_PROVINCIA == 19 ~ 11, EFT_PROVINCIA == 27 ~ 12, EFT_PROVINCIA == 
        5 ~ 13, EFT_PROVINCIA == 15 ~ 13, EFT_PROVINCIA == 26 ~ 13, EFT_PROVINCIA == 21 ~ 14, EFT_PROVINCIA == 
        2 ~ 15, EFT_PROVINCIA == 17 ~ 15, EFT_PROVINCIA == 31 ~ 15, EFT_PROVINCIA == 22 ~ 16, EFT_PROVINCIA == 
        7 ~ 17, EFT_PROVINCIA == 4 ~ 18, EFT_PROVINCIA == 3 ~ 19, EFT_PROVINCIA == 10 ~ 19, EFT_PROVINCIA == 
        16 ~ 19, EFT_PROVINCIA == 23 ~ 20, EFT_PROVINCIA == 29 ~ 21, EFT_PROVINCIA == 30 ~ 21, EFT_PROVINCIA == 
        12 ~ 22, EFT_PROVINCIA == 11 ~ 23, EFT_PROVINCIA == 8 ~ 24))
\}}}
