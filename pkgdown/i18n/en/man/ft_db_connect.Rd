\name{ft_db_connect}
\alias{ft_db_connect}
\alias{ft_dbConnect}
\title{Connect using the requested Dmisc database name}
\usage{
ft_db_connect(db_name = "enft", ...)

ft_dbConnect(db_name = "enft", ...)
}
\arguments{
\item{db_name}{Requested configured database name; forwarded to Dmisc.}
\item{...}{Additional arguments passed to the documented labeling, registry or connection helper.}
}
\description{Connect using the requested Dmisc database name. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
