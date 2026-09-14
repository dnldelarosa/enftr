\name{ft_with_Dict}
\alias{ft_with_Dict}
\alias{ft_use_labels}
\alias{ft_useLabels}
\title{Use variable and value labels}
\usage{
ft_with_Dict(tbl, dict = NULL, subset = NULL, ...)

ft_use_labels(tbl, dict = NULL, vars = NULL, ...)

ft_useLabels(tbl, dict = NULL, vars = NULL, ...)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{dict}{Explicit dictionary; NULL selects the bundled edition where documented.}
\item{subset}{Optional selected column names.}
\item{...}{Additional arguments passed to the documented labeling, registry or connection helper.}
\item{vars}{Optional selected column names, retained for positional compatibility.}
}
\description{Use variable and value labels. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
