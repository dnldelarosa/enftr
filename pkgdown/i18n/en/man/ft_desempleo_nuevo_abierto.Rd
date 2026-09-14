\name{ft_desempleo_nuevo_abierto}
\alias{ft_desempleo_nuevo_abierto}
\title{Open unemployment among new entrants}
\usage{
ft_desempleo_nuevo_abierto(tbl, min_edad = 15)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{min_edad}{Nonnegative integer minimum age; default 15.}
}
\description{Open unemployment among new entrants. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDO_FAM_SEM_ANT, EFT_BUSCO_TRAB_MES_ANT, EFT_BUSCO_TRAB_SEM_ANT, EFT_COSIO_LAVO_SEM_ANT, EFT_CULTIVO_SEM_ANT, EFT_EDAD, EFT_ELAB_PROD_SEM_ANT, EFT_TRABAJO_ANTES, EFT_TRABAJO_SEM_ANT, EFT_TUVO_ACT_ECON_SEM_ANT.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    tbl \%>\% ft_desempleo_abierto(min_edad) \%>\% dplyr::mutate(desempleo_nuevo_abierto = dplyr::case_when(desempleo_abierto == 
        1 & EFT_TRABAJO_ANTES != 1 ~ 1, desempleo_abierto == 1 ~ 0))
\}}}
