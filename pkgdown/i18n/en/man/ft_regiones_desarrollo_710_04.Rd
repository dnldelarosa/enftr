\name{ft_regiones_desarrollo_710_04}
\alias{ft_regiones_desarrollo_710_04}
\alias{ft_regiones_desarrollo}
\title{Historical development regions: decree 710-04}
\usage{
ft_regiones_desarrollo_710_04(tbl)

ft_regiones_desarrollo(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Historical development regions: decree 710-04. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(regiones_desarrollo_710_04 = dplyr::case_when(EFT_PROVINCIA \%in\% c(25, 18, 
        9) ~ 1, EFT_PROVINCIA \%in\% c(13, 24, 28) ~ 2, EFT_PROVINCIA \%in\% c(6, 19, 14, 20) ~ 3, EFT_PROVINCIA \%in\% 
        c(27, 15, 5, 26) ~ 4, EFT_PROVINCIA \%in\% c(21, 2, 17, 31) ~ 5, EFT_PROVINCIA \%in\% c(4, 3, 16, 
        10) ~ 6, EFT_PROVINCIA \%in\% c(22, 7) ~ 7, EFT_PROVINCIA \%in\% c(12, 11, 8) ~ 8, EFT_PROVINCIA \%in\% 
        c(23, 30, 29) ~ 9, EFT_PROVINCIA \%in\% c(1, 32) ~ 10))
\}}}
