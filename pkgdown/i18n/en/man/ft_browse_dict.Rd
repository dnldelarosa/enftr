\name{ft_browse_dict}
\alias{ft_browse_dict}
\title{Browse a dictionary as a table or widget}
\usage{
ft_browse_dict(dict = NULL, ...)
}
\arguments{
\item{dict}{Explicit dictionary; NULL selects the bundled edition where documented.}
\item{...}{Additional arguments passed to the documented labeling, registry or connection helper.}
}
\description{Browse a dictionary as a table or widget. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
