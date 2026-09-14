\name{ft_dict}
\alias{ft_dict}
\title{Select an immutable dictionary revision}
\usage{
ft_dict(version = NULL, at = NULL, con = NULL)
}
\arguments{
\item{version}{Exact immutable revision identifier.}
\item{at}{Optional ISO applicability date; requires documented revision intervals.}
\item{con}{Caller-owned DBI/SQLite connection to a dictionary registry.}
}
\description{Select an immutable dictionary revision. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
