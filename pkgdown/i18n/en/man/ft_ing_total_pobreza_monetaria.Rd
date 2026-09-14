\name{ft_ing_total_pobreza_monetaria}
\alias{ft_ing_total_pobreza_monetaria}
\title{Monthly individual income for historical poverty}
\usage{
ft_ing_total_pobreza_monetaria(
  tbl,
  ing_ext = tbl,
  remesas = tbl,
  .keep = FALSE,
  .reuse = FALSE
)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
\item{ing_ext}{External income transactions; multiple rows per member are allowed. Absent transactions mean zero; missing amounts remain unknown.}
\item{remesas}{One row per member with six remittance slots; defaults to tbl.}
\item{.keep}{TRUE retains components; FALSE retains inputs and final outputs; a character vector selects components.}
\item{.reuse}{FALSE recalculates components. TRUE trusts present components; a character vector requires those components.}
}
\description{Use the historical 34-component monthly income model for 2005/1 to 2016/2. Unknown individual income leaves the household unclassified. Values outside coverage remain missing. This is not a certified reproduction of official ENFT production.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_ANIO_PASADO_MONTO_ALQUILER, EFT_ANIO_PASADO_MONTO_GOBIERNO, EFT_ANIO_PASADO_MONTO_INTERES, EFT_ANIO_PASADO_MONTO_PENSION, EFT_ANIO_PASADO_MONTO_REMESAS, EFT_AYUDA_FAMILIARES_ANUAL, EFT_AYUDA_FAMILIARES_MENSUAL, EFT_BIENES_CONSUMO_ANUAL, EFT_BIENES_CONSUMO_MENSUAL, EFT_DIAS_SEM_OCUP_PRINC, EFT_DIAS_SEM_OCUP_SECUN, EFT_ESPECIE_EMPRESAS_ANO_VAL, EFT_ESPECIE_EMPRESAS_MES_VAL, EFT_ESPECIE_FAMILIARES_ANO_VAL, EFT_ESPECIE_FAMILIARES_MES_VAL, EFT_ESPECIE_GOBIERNO_ANO_VAL, EFT_ESPECIE_GOBIERNO_MES_VAL, EFT_ESPECIE_OTROS_VAL, EFT_FRECUENCIA_AGO, EFT_FRECUENCIA_JUL, EFT_FRECUENCIA_PER4, EFT_FRECUENCIA_PER5, EFT_FRECUENCIA_PER6, EFT_FRECUENCIA_SEP, EFT_HOGAR, EFT_HORAS_SEM_OCUP_PRINC, EFT_HORAS_SEM_OCUP_SECUN, EFT_ING_OCUP_PRINC, EFT_ING_OCUP_SECUN, EFT_MES_PASADO_COMISIONES, EFT_MES_PASADO_HORAS_EXTRAS, EFT_MES_PASADO_PROPINAS, EFT_MIEMBRO, EFT_MONEDA_AGO, EFT_MONEDA_ING_INTERES_MES, EFT_MONEDA_ING_PENSION_MES, EFT_MONEDA_ING_REMESA_SEM, EFT_MONEDA_JUL, EFT_MONEDA_PER4, EFT_MONEDA_PER5, EFT_MONEDA_PER6, EFT_MONEDA_SEP, EFT_MONTO_AGO, EFT_MONTO_ALQUILER_ING_NAC, EFT_MONTO_EQUIV_REGALO, EFT_MONTO_GOBIERNO_ING_NAC, EFT_MONTO_ING_INTERES_MES, EFT_MONTO_ING_PENSION_MES, EFT_MONTO_ING_REMESA_SEM, EFT_MONTO_INTERES_ING_NAC, EFT_MONTO_JUL, EFT_MONTO_PENSION_ING_NAC, EFT_MONTO_PER4, EFT_MONTO_PER5, EFT_MONTO_PER6, EFT_MONTO_PROBABLE_ALQ, EFT_MONTO_REMESAS_ING_NAC, EFT_MONTO_SEP, EFT_PAGO_ALIMENTOS_MONTO, EFT_PAGO_COMUNICACION_MONTO, EFT_PAGO_OTROS_MONTO, EFT_PAGO_TRANSPORTE_MONTO, EFT_PAGO_VESTIDO_MONTO, EFT_PAGO_VIVIENDAS_MONTO, EFT_PARENTESCO_CON_JEFE, EFT_PERIODO, EFT_PERIODO or PERIALFA, EFT_PERIODO_ING_OCUP_PRINC, EFT_PERIODO_ING_OCUP_SECUN, EFT_RECIBIO_ING_REMESA_SEM, EFT_RECIBIO_REMESA, EFT_ULT_DOCE_BENEFICIOS_MARG, EFT_ULT_DOCE_BONIFICACION, EFT_ULT_DOCE_DIVIDENDOS, EFT_ULT_DOCE_REGALIA_PASCUAL, EFT_ULT_DOCE_UTILIDADES_EMP, EFT_ULT_DOCE_VACACIONES_PAGAS, EFT_VIVIENDA, EFT_ZONA.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
