\name{ft_ing_especie_ayuda_ong}
\alias{ft_ing_especie_ayuda_ong}
\title{Income: family, employer, government and NGO assistance}
\usage{
ft_ing_especie_ayuda_ong(tbl)
}
\arguments{
\item{tbl}{Local data.frame or tibble with the required traditional ENFT columns.}
}
\description{Compute family, employer, government and NGO assistance using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.}
\value{A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.}
\details{Required columns: EFT_AYUDA_FAMILIARES_ANUAL, EFT_AYUDA_FAMILIARES_MENSUAL, EFT_ESPECIE_EMPRESAS_ANO_VAL, EFT_ESPECIE_EMPRESAS_MES_VAL, EFT_ESPECIE_FAMILIARES_ANO_VAL, EFT_ESPECIE_FAMILIARES_MES_VAL, EFT_ESPECIE_GOBIERNO_ANO_VAL, EFT_ESPECIE_GOBIERNO_MES_VAL, EFT_ESPECIE_OTROS_VAL.

Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.}
\section{Calculation rule}{\preformatted{\{
    EFT_AYUDA_FAMILIARES_ANUAL <- NULL
    EFT_AYUDA_FAMILIARES_MENSUAL <- NULL
    EFT_ESPECIE_FAMILIARES_ANO_VAL <- NULL
    EFT_ESPECIE_FAMILIARES_MES_VAL <- NULL
    EFT_ESPECIE_EMPRESAS_ANO_VAL <- NULL
    EFT_ESPECIE_EMPRESAS_MES_VAL <- NULL
    EFT_ESPECIE_GOBIERNO_ANO_VAL <- NULL
    EFT_ESPECIE_GOBIERNO_MES_VAL <- NULL
    EFT_ESPECIE_OTROS_VAL <- NULL
    ing_ayuda_familiares <- NULL
    ing_ayuda_especie_familiares <- NULL
    ing_ayuda_especie_empresas <- NULL
    ing_ayuda_especie_gob <- NULL
    ing_ayuda_especie_otros <- NULL
    tbl \%>\% dplyr::mutate(ing_ayuda_familiares = dplyr::if_else(dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_ANUAL), 
        0, EFT_AYUDA_FAMILIARES_ANUAL) == (dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_MENSUAL), 0, EFT_AYUDA_FAMILIARES_MENSUAL) * 
        12), dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_MENSUAL), 0, EFT_AYUDA_FAMILIARES_MENSUAL), dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_MENSUAL), 
        0, EFT_AYUDA_FAMILIARES_MENSUAL) + dplyr::if_else(is.na(EFT_AYUDA_FAMILIARES_ANUAL), 0, EFT_AYUDA_FAMILIARES_ANUAL)/12), 
        ing_ayuda_especie_familiares = dplyr::if_else(dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_ANO_VAL), 
            0, EFT_ESPECIE_FAMILIARES_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 
            0, EFT_ESPECIE_FAMILIARES_MES_VAL) * 12), dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 
            0, EFT_ESPECIE_FAMILIARES_MES_VAL), dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_MES_VAL), 
            0, EFT_ESPECIE_FAMILIARES_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_FAMILIARES_ANO_VAL), 
            0, EFT_ESPECIE_FAMILIARES_ANO_VAL)/12), ing_ayuda_especie_empresas = dplyr::if_else(dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_ANO_VAL), 
            0, EFT_ESPECIE_EMPRESAS_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 
            0, EFT_ESPECIE_EMPRESAS_MES_VAL) * 12), dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 
            0, EFT_ESPECIE_EMPRESAS_MES_VAL), dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_MES_VAL), 0, 
            EFT_ESPECIE_EMPRESAS_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_EMPRESAS_ANO_VAL), 0, EFT_ESPECIE_EMPRESAS_ANO_VAL)/12), 
        ing_ayuda_especie_gob = dplyr::if_else(dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_ANO_VAL), 0, 
            EFT_ESPECIE_GOBIERNO_ANO_VAL) == (dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 0, 
            EFT_ESPECIE_GOBIERNO_MES_VAL) * 12), dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 
            0, EFT_ESPECIE_GOBIERNO_MES_VAL), dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_MES_VAL), 0, 
            EFT_ESPECIE_GOBIERNO_MES_VAL) + dplyr::if_else(is.na(EFT_ESPECIE_GOBIERNO_ANO_VAL), 0, EFT_ESPECIE_GOBIERNO_ANO_VAL)/12), 
        ing_ayuda_especie_otros = dplyr::if_else(is.na(EFT_ESPECIE_OTROS_VAL), 0, EFT_ESPECIE_OTROS_VAL), 
        ing_especie_ayuda_ong = dplyr::if_else(is.na(ing_ayuda_familiares), 0, ing_ayuda_familiares) + 
            dplyr::if_else(is.na(ing_ayuda_especie_familiares), 0, ing_ayuda_especie_familiares) + dplyr::if_else(is.na(ing_ayuda_especie_empresas), 
            0, ing_ayuda_especie_empresas) + dplyr::if_else(is.na(ing_ayuda_especie_gob), 0, ing_ayuda_especie_gob) + 
            dplyr::if_else(is.na(ing_ayuda_especie_otros), 0, ing_ayuda_especie_otros))
\}}}
