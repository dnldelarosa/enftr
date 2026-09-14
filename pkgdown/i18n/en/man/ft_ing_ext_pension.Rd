\name{ft_ing_ext_pension}
\alias{ft_ing_ext_pension}
\title{Income: external pension}
\usage{
ft_ing_ext_pension(tbl, ing_ext = tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{ing_ext}{External income transactions; multiple rows per member are allowed. Absent transactions mean zero; missing amounts remain unknown.}
}
\description{Compute external pension using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO, EFT_VIVIENDA, EFT_HOGAR, EFT_MIEMBRO, EFT_MONTO_ING_PENSION_MES, EFT_MONEDA_ING_PENSION_MES.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
