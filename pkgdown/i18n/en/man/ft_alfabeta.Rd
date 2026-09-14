\name{ft_alfabeta}
\alias{ft_alfabeta}
\title{Literacy status}
\usage{
ft_alfabeta(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Literacy status. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ALFABETISMO, EFT_EDAD.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    ft_check_age(min_edad)
    EFT_ALFABETISMO <- NULL
    tbl \%>\% dplyr::mutate(alfabeta = dplyr::case_when(EFT_EDAD >= min_edad & EFT_ALFABETISMO \%in\% 1:2 ~ 
        EFT_ALFABETISMO))
\}}}
