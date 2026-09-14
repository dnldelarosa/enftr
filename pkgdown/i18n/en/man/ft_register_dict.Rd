\name{ft_register_dict}
\alias{ft_register_dict}
\title{Register a dictionary edition with shared definitions}
\usage{
ft_register_dict(con, dict, version, valid_from = NULL, valid_to = NULL, ...)
}
\arguments{
\item{con}{Caller-owned DBI/SQLite connection to a dictionary registry.}
\item{dict}{Explicit dictionary; NULL selects the bundled edition where documented.}
\item{version}{Exact immutable revision identifier.}
\item{valid_from}{Inclusive ISO start date, or NULL when unknown.}
\item{valid_to}{Inclusive ISO end date, or NULL when unknown.}
\item{...}{Additional arguments passed to the documented labeling, registry or connection helper.}
}
\description{Register a dictionary edition with shared definitions. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
