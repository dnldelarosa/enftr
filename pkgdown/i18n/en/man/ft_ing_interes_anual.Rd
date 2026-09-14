\name{ft_ing_interes_anual}
\alias{ft_ing_interes_anual}
\title{Income: annual interest converted to monthly}
\usage{
ft_ing_interes_anual(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute annual interest converted to monthly using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ANIO_PASADO_MONTO_INTERES.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_interes_anual = dplyr::case_when(is.na(EFT_ANIO_PASADO_MONTO_INTERES) ~ 
        0, TRUE ~ EFT_ANIO_PASADO_MONTO_INTERES/12))
\}}}
