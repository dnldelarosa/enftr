\name{ft_ing_bonificaciones}
\alias{ft_ing_bonificaciones}
\title{Income: bonuses}
\usage{
ft_ing_bonificaciones(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute bonuses using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ULT_DOCE_BONIFICACION.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_bonificaciones = dplyr::case_when(is.na(EFT_ULT_DOCE_BONIFICACION) ~ 0, 
        TRUE ~ EFT_ULT_DOCE_BONIFICACION/12))
\}}}
