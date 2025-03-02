% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sociales.R
\name{ft_ing_ocasional_nac}
\alias{ft_ing_ocasional_nac}
\title{Ingreso monetario no laboral ocasional nacional para el cálculo de pobreza monetaria
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}}
\usage{
ft_ing_ocasional_nac(tbl)
}
\arguments{
\item{tbl}{\link{data.frame} el data.frame con los datos de la ENFT.
Puede ser conexión a base de datos.}
}
\value{
\link{data.frame} los datos del argumento \code{tbl} con la columna \code{ing_ocasional_nac} agregrada.
}
\description{
Ingreso monetario no laboral ocasional nacional para el cálculo de pobreza monetaria
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}
}
\examples{
\dontrun{
  enft <- ft_ing_ocasional_nac(enft)
}
}
