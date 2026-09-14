\name{ft_ing_ocup_prin}
\alias{ft_ing_ocup_prin}
\title{Income: main-job earnings}
\usage{
ft_ing_ocup_prin(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute main-job earnings using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_DIAS_SEM_OCUP_PRINC, EFT_HORAS_SEM_OCUP_PRINC, EFT_ING_OCUP_PRINC, EFT_PERIODO_ING_OCUP_PRINC.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(ing_ocup_prin = dplyr::case_when(EFT_PERIODO_ING_OCUP_PRINC == 1 ~ EFT_ING_OCUP_PRINC * 
        4.3 * EFT_HORAS_SEM_OCUP_PRINC, EFT_PERIODO_ING_OCUP_PRINC == 2 ~ EFT_ING_OCUP_PRINC * 4.3 * 
        EFT_DIAS_SEM_OCUP_PRINC, EFT_PERIODO_ING_OCUP_PRINC == 3 ~ EFT_ING_OCUP_PRINC * 4.3, EFT_PERIODO_ING_OCUP_PRINC == 
        4 ~ EFT_ING_OCUP_PRINC * 2, EFT_PERIODO_ING_OCUP_PRINC == 5 ~ EFT_ING_OCUP_PRINC, TRUE ~ 0))
\}}}
