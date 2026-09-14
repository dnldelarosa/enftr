\name{ft_categoria_ocupacion_principal}
\alias{ft_categoria_ocupacion_principal}
\title{Harmonized main-job occupational category}
\usage{
ft_categoria_ocupacion_principal(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Harmonized main-job occupational category. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_CATEGORIA_OCUP_PRINC, EFT_PERIODO or PERIALFA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_peri_vars() \%>\% dplyr::mutate(categoria_ocupacion_principal = dplyr::case_when(dplyr::between(ano, 
        2000, 2004) & EFT_CATEGORIA_OCUP_PRINC \%in\% 7:8 ~ 7, dplyr::between(ano, 2000, 2004) & EFT_CATEGORIA_OCUP_PRINC \%in\% 
        9:10 ~ 8, TRUE ~ EFT_CATEGORIA_OCUP_PRINC))
\}}}
