\name{ft_set_Dict}
\alias{ft_set_Dict}
\alias{ft_set_labels}
\alias{ft_setLabels}
\title{Apply dictionary metadata}
\usage{
ft_set_Dict(
  tbl,
  dict = NULL,
  subset = NULL,
  ...,
  version = NULL,
  at = NULL,
  con = NULL
)

ft_set_labels(tbl, dict = NULL, vars = NULL)

ft_setLabels(tbl, dict = NULL, vars = NULL)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{dict}{Explicit dictionary; NULL selects the bundled edition where documented.}
\item{subset}{Optional selected column names.}
\item{...}{Additional arguments passed to the documented labeling, registry or connection helper.}
\item{version}{Exact immutable revision identifier.}
\item{at}{Optional ISO applicability date; requires documented revision intervals.}
\item{con}{Caller-owned DBI/SQLite connection to a dictionary registry.}
\item{vars}{Optional selected column names, retained for positional compatibility.}
}
\description{Apply dictionary metadata. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
