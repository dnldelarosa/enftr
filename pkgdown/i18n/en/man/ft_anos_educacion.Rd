\name{ft_anos_educacion}
\alias{ft_anos_educacion}
\title{Years of education}
\usage{
ft_anos_educacion(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Years of education. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_EDAD, EFT_ULT_ANO_APROBADO, EFT_ULT_NIVEL_ALCANZADO.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    EFT_EDAD <- NULL
    EFT_ULT_NIVEL_ALCANZADO <- NULL
    EFT_ULT_ANO_APROBADO <- NULL
    tbl \%>\% dplyr::mutate(anos_educacion = dplyr::case_when(EFT_EDAD <= 3 ~ NA_integer_, EFT_ULT_NIVEL_ALCANZADO \%in\% 
        c(1, 7) ~ 0, EFT_ULT_NIVEL_ALCANZADO == 2 ~ EFT_ULT_ANO_APROBADO, EFT_ULT_NIVEL_ALCANZADO \%in\% 
        c(3, 4) ~ 8 + EFT_ULT_ANO_APROBADO, EFT_ULT_NIVEL_ALCANZADO == 5 ~ 12 + EFT_ULT_ANO_APROBADO, 
        EFT_ULT_NIVEL_ALCANZADO == 6 ~ 16 + EFT_ULT_ANO_APROBADO))
\}}}
