\name{ft_cantidad_personas_trabajan}
\alias{ft_cantidad_personas_trabajan}
\title{Harmonized workplace size}
\usage{
ft_cantidad_personas_trabajan(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Harmonized workplace size. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_CANT_PERS_TRAB, EFT_PERIODO or PERIALFA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_peri_vars() \%>\% dplyr::mutate(cantidad_personas_trabajan = dplyr::case_when(ano >= 2004 & 
        EFT_CANT_PERS_TRAB \%in\% 1:2 ~ 1, ano >= 2004 & EFT_CANT_PERS_TRAB \%in\% 3:4 ~ EFT_CANT_PERS_TRAB - 
        1, ano >= 2004 & EFT_CANT_PERS_TRAB >= 5 ~ 4, EFT_CANT_PERS_TRAB != 0 ~ EFT_CANT_PERS_TRAB))
\}}}
