\name{ft_regiones_desarrollo_685_00}
\alias{ft_regiones_desarrollo_685_00}
\title{Historical development regions: decree 685-00}
\usage{
ft_regiones_desarrollo_685_00(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Historical development regions: decree 685-00. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(regiones_desarrollo_685_00 = dplyr::case_when(EFT_PROVINCIA \%in\% c(1, 32) ~ 
        1, EFT_PROVINCIA \%in\% c(17, 21, 29, 31) ~ 2, EFT_PROVINCIA \%in\% c(23, 12, 11, 30, 8) ~ 3, EFT_PROVINCIA \%in\% 
        c(19, 6, 14, 20) ~ 4, EFT_PROVINCIA \%in\% c(28, 13, 24) ~ 5, EFT_PROVINCIA \%in\% c(25, 18, 9) ~ 
        6, EFT_PROVINCIA \%in\% c(27, 26, 15, 5) ~ 7, EFT_PROVINCIA \%in\% c(2, 22, 7) ~ 8, EFT_PROVINCIA \%in\% 
        c(4, 3, 16, 10) ~ 9))
\}}}
