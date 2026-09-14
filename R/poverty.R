#' Pobreza monetaria histórica de la ENFT, 2005-2016
#'
#' Implementación histórica de enftr, revisada para preservar ingresos desconocidos,
#' corregir meses de remesas y validar claves. No está certificada como reproducción
#' del programa oficial. Las líneas incluidas son nominales y específicas de zona
#' y semestre. No aplique esta función a la ENCFT ni a períodos posteriores a 2016.
#'
#' @param tbl Datos locales, una fila por persona, con todos los miembros del hogar.
#' @param ing_ext Ingresos externos; admite varias transacciones por persona.
#'   Una fila ausente significa ninguna transacción; un importe NA significa desconocido.
#' @param remesas Remesas, una fila por persona con hasta seis meses. Por defecto tbl.
#' @param .keep TRUE conserva los componentes; FALSE conserva entradas y resultados;
#'   un vector selecciona nombres de componentes a conservar.
#' @param .reuse FALSE recalcula todos los componentes. TRUE reutiliza los presentes;
#'   un vector exige esos componentes. El usuario responde por sus unidades y vigencia.
#' @return tbl con ingresos individuales y per cápita, líneas, pobreza_monetaria
#'   (1 extrema, 2 moderada, 3 no pobre; NA sin cálculo), pobreza_estado y pobreza_metodo.
#' @details Fuera de 2005/1-2016/2 el resultado es NA y el estado outside_coverage.
#'   Si cualquier integrante tiene ingreso total desconocido, todo su hogar queda
#'   sin clasificación (missing_income). La suma incluye a todos los miembros de tbl;
#'   no se puede verificar que el usuario haya suministrado el hogar completo.
#' @export
#' @examples
#' resultado <- ft_pobreza_monetaria(enft_like)
#' table(resultado$pobreza_estado)
ft_pobreza_monetaria <- function(tbl, ing_ext = tbl, remesas = tbl, .keep = FALSE, .reuse = FALSE) {
  result <- ft_ing_pc_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse)
  ft_numeric(result, "EFT_ZONA")
  if (any(is.na(result$EFT_ZONA) | !result$EFT_ZONA %in% c(0, 1))) stop("EFT_ZONA debe ser 0/1, sin faltantes, para pobreza.", call. = FALSE)
  parts <- ft_period_parts(result)
  lines <- enftr::lineas_oficial_zona
  key <- paste(parts$canonical, result$EFT_ZONA)
  found <- match(key, paste(lines$EFT_PERIODO, lines$EFT_ZONA))
  result$lindigencia <- lines$lindigencia[found]
  result$lpobreza <- lines$lpobreza[found]
  covered <- parts$periodo >= 20051 & parts$periodo <= 20162
  if (any(covered & (is.na(result$lindigencia) | is.na(result$lpobreza)))) stop("Falta una linea de pobreza dentro de cobertura.", call. = FALSE)
  income <- result$ing_pc_pobreza_monetaria
  result$pobreza_monetaria <- ifelse(!covered | is.na(income), NA_real_,
    ifelse(income <= result$lindigencia, 1, ifelse(income <= result$lpobreza, 2, 3)))
  result$pobreza_estado <- ifelse(!covered, "outside_coverage", ifelse(is.na(income), "missing_income", "classified"))
  result$pobreza_metodo <- rep("enftr-historical-2005-2016-v2", nrow(result))
  result
}

ft_income_components <- c("ing_ocup_prin", "ing_comisiones", "ing_propinas", "ing_horas_extras",
  "ing_vacaciones", "ing_dividendos", "ing_bonificaciones", "ing_regalia_pascual",
  "ing_utilidades_empresariales", "ing_beneficios_marginales", "ing_especie_alimentos",
  "ing_especie_viviendas", "ing_especie_transporte", "ing_especie_vestido", "ing_especie_otros",
  "ing_especie_celulares", "ing_ocup_secun", "ing_pension_anual", "ing_pension_jubilacion",
  "ing_intereses_dividendo", "ing_interes_anual", "ing_alqui_renta_propiedades",
  "ing_alquiler_anual", "ing_remesas_nac", "ing_remesas_anual", "ing_ayuda_gobierno",
  "ing_gobierno_anual", "ing_especie_ayuda_ong", "ing_especie_auto", "ing_ext_pension",
  "ing_ext_intereses_alquiler", "ing_regalos_ext", "ing_imputado_vivienda_propia", "ing_remesas_ext")

ft_component_option <- function(value, name) {
  if (is.logical(value)) ft_check_flag(value, name)
  else if (!is.character(value) || anyNA(value) || any(!value %in% ft_income_components) || anyDuplicated(value)) {
    stop(paste(name, "debe ser TRUE/FALSE o nombres unicos de componentes."), call. = FALSE)
  }
}

#' Ingreso individual mensual usado por la pobreza histórica
#' @inheritParams ft_pobreza_monetaria
#' @return Datos con ing_total_pobreza_monetaria en pesos dominicanos mensuales.
#' @export
ft_ing_total_pobreza_monetaria <- function(tbl, ing_ext = tbl, remesas = tbl, .keep = FALSE, .reuse = FALSE) {
  original <- tbl
  tbl <- ft_income_table(tbl, TRUE)
  ft_component_option(.keep, ".keep")
  ft_component_option(.reuse, ".reuse")
  if (is.character(.reuse) && any(!.reuse %in% names(tbl))) stop("Falta un componente solicitado en .reuse.", call. = FALSE)
  selected <- if (isTRUE(.keep)) ft_income_components else if (is.character(.keep)) .keep else character()
  retained <- if (isTRUE(.reuse)) intersect(ft_income_components, names(tbl)) else if (is.character(.reuse)) .reuse else character()
  covered <- ft_period_parts(tbl)$periodo >= 20051 & ft_period_parts(tbl)$periodo <= 20162
  work <- ft_peri_vars(tbl[covered, , drop = FALSE])
  ext <- ft_income_table(ing_ext)
  rem <- ft_income_table(remesas, TRUE)
  # Validate membership before filtering to the computable periods.
  if (any(!ft_key_id(ext) %in% ft_key_id(tbl)) || any(!ft_key_id(rem) %in% ft_key_id(tbl))) stop("La tabla externa contiene miembros ausentes de tbl.", call. = FALSE)
  ext <- ext[ft_key_id(ext) %in% ft_key_id(work), , drop = FALSE]
  rem <- rem[ft_key_id(rem) %in% ft_key_id(work), , drop = FALSE]
  for (component in ft_income_components) {
    if (nrow(work) && !component %in% retained) {
      fun <- get(paste0("ft_", component), mode = "function")
      work <- if (component %in% c("ing_ext_pension", "ing_ext_intereses_alquiler", "ing_regalos_ext")) fun(work, ext)
        else if (component == "ing_remesas_ext") fun(work, rem, ext) else fun(work)
    }
    if (!nrow(work)) work[[component]] <- numeric()
    ft_numeric(work, component)
  }
  original$ing_total_pobreza_monetaria <- rep(NA_real_, nrow(original))
  original$ing_total_pobreza_monetaria[covered] <- rowSums(work[ft_income_components], na.rm = FALSE)
  for (component in selected) {
    original[[component]] <- rep(NA_real_, nrow(original))
    original[[component]][covered] <- work[[component]]
  }
  original
}

#' Ingreso mensual por persona del hogar
#' @inheritParams ft_pobreza_monetaria
#' @return Datos con ingreso individual y promedio por miembro del hogar.
#' @export
ft_ing_pc_pobreza_monetaria <- function(tbl, ing_ext = tbl, remesas = tbl, .keep = FALSE, .reuse = FALSE) {
  result <- ft_ing_total_pobreza_monetaria(tbl, ing_ext, remesas, .keep, .reuse)
  canonical <- ft_income_table(result, TRUE)
  ids <- ft_key_id(canonical, ft_keys[1:3])
  if ("EFT_ZONA" %in% names(result) && any(vapply(split(result$EFT_ZONA, ids), function(x) length(unique(x)) != 1L, logical(1)))) stop("Zona inconsistente dentro del hogar.", call. = FALSE)
  result$ing_pc_pobreza_monetaria <- if (nrow(result)) stats::ave(result$ing_total_pobreza_monetaria, ids, FUN = function(x) mean(x, na.rm = FALSE)) else numeric()
  result
}
