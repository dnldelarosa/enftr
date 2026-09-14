\name{ft_ing_ocup_secun}
\alias{ft_ing_ocup_secun}
\title{Income: secondary-job earnings}
\usage{
ft_ing_ocup_secun(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute secondary-job earnings using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_DIAS_SEM_OCUP_SECUN, EFT_HORAS_SEM_OCUP_SECUN, EFT_ING_OCUP_SECUN, EFT_PERIODO or PERIALFA, EFT_PERIODO_ING_OCUP_SECUN.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_peri_vars() \%>\% dplyr::mutate(ing_ocup_secun = dplyr::case_when(ano >= 2005 ~ EFT_ING_OCUP_SECUN, 
        EFT_PERIODO_ING_OCUP_SECUN == 1 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_HORAS_SEM_OCUP_SECUN, EFT_PERIODO_ING_OCUP_SECUN == 
            2 ~ EFT_ING_OCUP_SECUN * 4.3 * EFT_DIAS_SEM_OCUP_SECUN, EFT_PERIODO_ING_OCUP_SECUN == 3 ~ 
            EFT_ING_OCUP_SECUN * 4.3, EFT_PERIODO_ING_OCUP_SECUN == 4 ~ EFT_ING_OCUP_SECUN * 2, EFT_PERIODO_ING_OCUP_SECUN == 
            5 ~ EFT_ING_OCUP_SECUN), ing_ocup_secun = dplyr::case_when(is.na(ing_ocup_secun) ~ 0, TRUE ~ 
        ing_ocup_secun))
\}}}
