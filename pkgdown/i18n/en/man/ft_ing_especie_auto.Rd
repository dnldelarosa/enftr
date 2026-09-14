\name{ft_ing_especie_auto}
\alias{ft_ing_especie_auto}
\title{Income: self-produced consumption}
\usage{
ft_ing_especie_auto(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute self-produced consumption using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_BIENES_CONSUMO_ANUAL, EFT_BIENES_CONSUMO_MENSUAL.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    EFT_BIENES_CONSUMO_MENSUAL <- NULL
    EFT_BIENES_CONSUMO_ANUAL <- NULL
    tbl \%>\% dplyr::mutate(ing_especie_auto = dplyr::if_else(is.na(EFT_BIENES_CONSUMO_MENSUAL), 0, EFT_BIENES_CONSUMO_MENSUAL) + 
        dplyr::if_else(is.na(EFT_BIENES_CONSUMO_ANUAL), 0, EFT_BIENES_CONSUMO_ANUAL)/12)
\}}}
