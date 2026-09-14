\name{ft_ing_remesas_ext}
\alias{ft_ing_remesas_ext}
\title{Income: external remittances}
\usage{
ft_ing_remesas_ext(tbl, remesas = tbl, ing_ext = tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{remesas}{One row per member with six remittance slots; defaults to tbl.}
\item{ing_ext}{External income transactions; multiple rows per member are allowed. Absent transactions mean zero; missing amounts remain unknown.}
}
\description{Compute external remittances using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_RECIBIO_REMESA, EFT_MONTO_SEP, EFT_MONEDA_SEP, EFT_FRECUENCIA_SEP, EFT_MONTO_AGO, EFT_MONEDA_AGO, EFT_FRECUENCIA_AGO, EFT_MONTO_JUL, EFT_MONEDA_JUL, EFT_FRECUENCIA_JUL, EFT_MONTO_PER4, EFT_MONEDA_PER4, EFT_FRECUENCIA_PER4, EFT_MONTO_PER5, EFT_MONEDA_PER5, EFT_FRECUENCIA_PER5, EFT_MONTO_PER6, EFT_MONEDA_PER6, EFT_FRECUENCIA_PER6, EFT_RECIBIO_ING_REMESA_SEM, EFT_MONTO_ING_REMESA_SEM, EFT_MONEDA_ING_REMESA_SEM.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
