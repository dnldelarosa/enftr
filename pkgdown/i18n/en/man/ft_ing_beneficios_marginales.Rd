\name{ft_ing_beneficios_marginales}
\alias{ft_ing_beneficios_marginales}
\title{Income: fringe benefits}
\usage{
ft_ing_beneficios_marginales(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute fringe benefits using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ULT_DOCE_BENEFICIOS_MARG.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_beneficios_marginales = dplyr::case_when(is.na(EFT_ULT_DOCE_BENEFICIOS_MARG) ~ 
        0, TRUE ~ EFT_ULT_DOCE_BENEFICIOS_MARG/12))
\}}}
