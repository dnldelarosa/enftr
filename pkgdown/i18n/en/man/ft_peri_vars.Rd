\name{ft_peri_vars}
\alias{ft_peri_vars}
\alias{ft_compute_peri_vars}
\alias{ft_compute_ano}
\alias{ft_ano}
\title{Validate and extract the semiannual period}
\usage{
ft_peri_vars(tbl, rm = FALSE, ano = TRUE, semestre = TRUE, periodo = TRUE)

ft_compute_peri_vars(
  tbl,
  rm = FALSE,
  ano = TRUE,
  semestre = TRUE,
  periodo = TRUE
)

ft_compute_ano(tbl)

ft_ano(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{rm}{Remove the source period column when TRUE.}
\item{ano}{Add or overwrite the year when TRUE.}
\item{semestre}{Add or overwrite the semester when TRUE.}
\item{periodo}{Add or overwrite the YYYYS code when TRUE.}
}
\description{Validate and extract the semiannual period. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_PERIODO or PERIALFA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
