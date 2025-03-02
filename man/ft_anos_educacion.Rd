% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/educacion.R
\name{ft_anos_educacion}
\alias{ft_anos_educacion}
\title{Años de educación
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}}
\usage{
ft_anos_educacion(tbl)
}
\arguments{
\item{tbl}{\link{data.frame} una conexión a base de datos o data.frame con los datos}
}
\value{
\link{data.frame}: Los datos suministrados en el argumento \code{tbl} con
la variable \code{anos_educacion} adicionada.
}
\description{
Años de educación
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}
}
\examples{
\dontrun{
  enft <- ft_anos_educacion(enft)
}
}
