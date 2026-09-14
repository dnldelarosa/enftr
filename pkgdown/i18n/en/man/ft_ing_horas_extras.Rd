\name{ft_ing_horas_extras}
\alias{ft_ing_horas_extras}
\title{Income: overtime}
\usage{
ft_ing_horas_extras(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute overtime using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_MES_PASADO_HORAS_EXTRAS.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_horas_extras = dplyr::case_when(is.na(EFT_MES_PASADO_HORAS_EXTRAS) ~ 0, 
        TRUE ~ EFT_MES_PASADO_HORAS_EXTRAS))
\}}}
