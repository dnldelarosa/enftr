\name{ft_zona_desarrollo_fronterizo}
\alias{ft_zona_desarrollo_fronterizo}
\title{Historical border-development area}
\usage{
ft_zona_desarrollo_fronterizo(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Historical border-development area. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_regiones_desarrollo_710_04() \%>\% dplyr::mutate(zona_desarrollo_fronterizo = dplyr::case_when(as.numeric(EFT_PROVINCIA) \%in\% 
        as.numeric(c("16", "10", "07", "05", "15", "26", "03")) ~ 1, TRUE ~ 0))
\}}}
