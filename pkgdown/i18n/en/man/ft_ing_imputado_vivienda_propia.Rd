\name{ft_ing_imputado_vivienda_propia}
\alias{ft_ing_imputado_vivienda_propia}
\title{Income: owner-occupied imputed rent}
\usage{
ft_ing_imputado_vivienda_propia(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute owner-occupied imputed rent using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_PARENTESCO_CON_JEFE, EFT_MONTO_PROBABLE_ALQ.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
