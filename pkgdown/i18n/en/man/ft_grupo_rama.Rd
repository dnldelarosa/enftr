\name{ft_grupo_rama}
\alias{ft_grupo_rama}
\title{Economic activity group}
\usage{
ft_grupo_rama(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Economic activity group. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_RAMA_PRINC.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% dplyr::mutate(grupo_rama = dplyr::case_when(EFT_RAMA_PRINC < 100 ~ 1, EFT_RAMA_PRINC < 150 ~ 
        2, EFT_RAMA_PRINC < 400 ~ 3, EFT_RAMA_PRINC < 450 ~ 4, EFT_RAMA_PRINC < 500 ~ 5, EFT_RAMA_PRINC < 
        550 ~ 6, EFT_RAMA_PRINC < 600 ~ 7, EFT_RAMA_PRINC < 650 ~ 8, EFT_RAMA_PRINC < 700 ~ 9, EFT_RAMA_PRINC < 
        750 ~ 11, EFT_RAMA_PRINC < 800 ~ 10, EFT_RAMA_PRINC >= 800 ~ 11))
\}}}
