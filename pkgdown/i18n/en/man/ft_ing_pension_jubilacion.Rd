\name{ft_ing_pension_jubilacion}
\alias{ft_ing_pension_jubilacion}
\title{Income: domestic pension}
\usage{
ft_ing_pension_jubilacion(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute domestic pension using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_MONTO_PENSION_ING_NAC.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_pension_jubilacion = dplyr::case_when(is.na(EFT_MONTO_PENSION_ING_NAC) ~ 
        0, TRUE ~ EFT_MONTO_PENSION_ING_NAC))
\}}}
