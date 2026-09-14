\name{ft_ing_especie_vestido}
\alias{ft_ing_especie_vestido}
\title{Income: in-kind clothing}
\usage{
ft_ing_especie_vestido(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute in-kind clothing using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PAGO_VESTIDO_MONTO.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_especie_vestido = dplyr::case_when(is.na(EFT_PAGO_VESTIDO_MONTO) ~ 0, TRUE ~ 
        EFT_PAGO_VESTIDO_MONTO/12))
\}}}
