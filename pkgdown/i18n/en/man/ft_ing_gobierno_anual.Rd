\name{ft_ing_gobierno_anual}
\alias{ft_ing_gobierno_anual}
\title{Income: annual government assistance converted to monthly}
\usage{
ft_ing_gobierno_anual(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute annual government assistance converted to monthly using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ANIO_PASADO_MONTO_GOBIERNO.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    EFT_ANIO_PASADO_MONTO_GOBIERNO <- NULL
    tbl \%>\% dplyr::mutate(ing_gobierno_anual = dplyr::if_else(is.na(EFT_ANIO_PASADO_MONTO_GOBIERNO), 
        0, EFT_ANIO_PASADO_MONTO_GOBIERNO/12))
\}}}
