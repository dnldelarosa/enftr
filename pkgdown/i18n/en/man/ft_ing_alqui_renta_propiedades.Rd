\name{ft_ing_alqui_renta_propiedades}
\alias{ft_ing_alqui_renta_propiedades}
\title{Income: domestic property rent}
\usage{
ft_ing_alqui_renta_propiedades(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute domestic property rent using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_MONTO_ALQUILER_ING_NAC.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    EFT_MONTO_ALQUILER_ING_NAC <- NULL
    tbl \%>\% dplyr::mutate(ing_alqui_renta_propiedades = dplyr::if_else(is.na(EFT_MONTO_ALQUILER_ING_NAC), 
        0, EFT_MONTO_ALQUILER_ING_NAC))
\}}}
