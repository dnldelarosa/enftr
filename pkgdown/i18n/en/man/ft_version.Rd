\name{ft_version}
\alias{ft_version}
\title{Identify ENFT column structure}
\usage{
ft_version(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Identify ENFT column structure. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO or PERIALFA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
