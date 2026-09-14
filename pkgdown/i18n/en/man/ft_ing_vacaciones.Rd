\name{ft_ing_vacaciones}
\alias{ft_ing_vacaciones}
\title{Income: paid leave}
\usage{
ft_ing_vacaciones(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute paid leave using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ULT_DOCE_VACACIONES_PAGAS.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_vacaciones = dplyr::case_when(is.na(EFT_ULT_DOCE_VACACIONES_PAGAS) ~ 0, 
        TRUE ~ EFT_ULT_DOCE_VACACIONES_PAGAS/12))
\}}}
