\name{ft_dominios_inferencia2}
\alias{ft_dominios_inferencia2}
\title{Inference domains for 2003/2 to 2007/2}
\usage{
ft_dominios_inferencia2(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Inference domains for 2003/2 to 2007/2. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PROVINCIA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    regiones_desarrollo_685_00 <- NULL
    tbl \%>\% ft_regiones_desarrollo_685_00() \%>\% dplyr::mutate(dominios_inferencia2 = regiones_desarrollo_685_00)
\}}}
