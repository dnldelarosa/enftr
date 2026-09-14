ft_keys <- c("EFT_PERIODO", "EFT_VIVIENDA", "EFT_HOGAR", "EFT_MIEMBRO")

ft_income_table <- function(tbl, unique_members = FALSE) {
  result <- ft_canonical_table(tbl, member = TRUE)
  if (unique_members && anyDuplicated(result[ft_keys])) stop("Miembros duplicados en periodo/vivienda/hogar/miembro.", call. = FALSE)
  result
}

ft_key_id <- function(tbl, keys = ft_keys) {
  # Quoted and escaped values preserve key boundaries without delimiter collisions.
  if (!nrow(tbl)) return(character())
  do.call(paste, c(lapply(tbl[keys], function(x) encodeString(as.character(x), quote = '"')), sep = "|"))
}

ft_numeric <- function(tbl, columns) {
  ft_check_table(tbl, columns)
  for (name in columns) if (!is.numeric(tbl[[name]]) || any(is.infinite(tbl[[name]]))) {
    stop(paste("Se requieren numeros finitos o NA:", name), call. = FALSE)
  }
}

ft_lookup_rate <- function(year, month, currency) {
  rates <- enftr::tdc_oficial
  key <- paste(format(rates$date, "%Y-%m"), rates$cod_moneda2)
  target <- paste(sprintf("%04d-%02d", year, month), currency)
  values <- rates$value[match(target, key)]
  if (any(!is.finite(values) | values <= 0)) stop("Falta tipo de cambio para moneda/mes; revise la cobertura de tdc_oficial.", call. = FALSE)
  values
}

ft_lookup_ipc <- function(year, month) {
  ipc <- enftr::ipc_oficial
  values <- ipc$ipc[match(sprintf("%04d-%02d", year, month), format(ipc$date, "%Y-%m"))]
  if (any(!is.finite(values) | values <= 0)) stop("Falta IPC para el mes; revise la cobertura de ipc_oficial.", call. = FALSE)
  values
}

ft_attach_income <- function(tbl, events, values, output) {
  target <- ft_income_table(tbl, TRUE)
  ids <- ft_key_id(target)
  event_ids <- ft_key_id(events)
  if (any(!event_ids %in% ids)) stop("La tabla externa contiene miembros ausentes de tbl.", call. = FALSE)
  sums <- tapply(values, event_ids, sum, na.rm = FALSE)
  value <- rep(0, nrow(tbl))
  match_id <- match(ids, names(sums))
  present <- !is.na(match_id)
  value[present] <- sums[match_id[present]]
  tbl[[output]] <- as.numeric(value)
  tbl
}

ft_external_income <- function(tbl, ing_ext, amount, currency, output) {
  events <- ft_income_table(ing_ext)
  ft_numeric(events, c(amount, currency))
  value <- events[[amount]]
  active <- which(!is.na(value) & value > 0)
  value[!is.na(value) & value <= 0] <- 0
  if (!is.null(currency) && length(active)) {
    parts <- ft_period_parts(events)
    value[active] <- value[active] * ft_lookup_rate(parts$ano[active],
      ifelse(parts$semestre[active] == 1, 3, 9), events[[currency]][active])
  }
  ft_attach_income(tbl, events, value, output)
}

ft_remittance_income <- function(tbl, remesas, ing_ext) {
  target <- ft_income_table(tbl, TRUE)
  events <- ft_income_table(remesas, TRUE)
  old <- ft_income_table(ing_ext)
  p <- ft_period_parts(events)
  events <- events[p$periodo >= 20002 & p$periodo <= 20162, , drop = FALSE]
  p <- ft_period_parts(events)
  value <- rep(0, nrow(events))
  if (nrow(events)) {
    ft_numeric(events, "EFT_RECIBIO_REMESA")
    if (any(!is.na(events$EFT_RECIBIO_REMESA) & !events$EFT_RECIBIO_REMESA %in% c(0, 1, 2))) stop("Codigo de recepcion de remesa desconocido.", call. = FALSE)
    received <- which(!is.na(events$EFT_RECIBIO_REMESA) & events$EFT_RECIBIO_REMESA == 1)
    value[is.na(events$EFT_RECIBIO_REMESA)] <- NA_real_
    for (i in seq_along(c("SEP", "AGO", "JUL", "PER4", "PER5", "PER6"))) {
      slot <- c("SEP", "AGO", "JUL", "PER4", "PER5", "PER6")[[i]]
      columns <- paste0(c("EFT_MONTO_", "EFT_MONEDA_", "EFT_FRECUENCIA_"), slot)
      if (!length(received)) next
      ft_numeric(events, columns[1:2])
      if (any(p$periodo[received] <= 20071)) ft_numeric(events, columns[3])
      amount <- events[[columns[1]]]
      value[received[is.na(amount[received])]] <- NA_real_
      active <- received[!is.na(amount[received]) & amount[received] > 0]
      if (!length(active)) next
      month <- ifelse(p$semestre[active] == 1, c(3, 2, 1, 12, 11, 10)[i], c(9, 8, 7, 6, 5, 4)[i])
      year <- p$ano[active] - as.integer(p$semestre[active] == 1 & i >= 4)
      converted <- amount[active] * ft_lookup_rate(year, month, events[[columns[2]]][active]) *
        ft_lookup_ipc(p$ano[active], ifelse(p$semestre[active] == 1, 3, 9)) / ft_lookup_ipc(year, month)
      divisor <- ifelse(p$periodo[active] <= 20071, 12, 6)
      frequency <- rep(1, length(active))
      annual <- which(p$periodo[active] <= 20071)
      if (length(annual)) frequency[annual] <- events[[columns[3]]][active[annual]]
      if (any(!is.na(frequency) & frequency < 0)) stop("Frecuencia de remesa negativa.", call. = FALSE)
      value[active] <- value[active] + converted * frequency / divisor
    }
  }
  old <- old[ft_period_parts(old)$periodo == 20001, , drop = FALSE]
  old_value <- rep(0, nrow(old))
  if (nrow(old)) {
    ft_numeric(old, c("EFT_RECIBIO_ING_REMESA_SEM", "EFT_MONTO_ING_REMESA_SEM", "EFT_MONEDA_ING_REMESA_SEM"))
    received <- which(!is.na(old$EFT_RECIBIO_ING_REMESA_SEM) & old$EFT_RECIBIO_ING_REMESA_SEM == 1)
    old_value[is.na(old$EFT_RECIBIO_ING_REMESA_SEM)] <- NA_real_
    old_value[received] <- old$EFT_MONTO_ING_REMESA_SEM[received] / 6
    active <- received[!is.na(old_value[received]) & old_value[received] > 0]
    if (length(active)) old_value[active] <- old_value[active] * ft_lookup_rate(rep(2000, length(active)), rep(3, length(active)), old$EFT_MONEDA_ING_REMESA_SEM[active])
  }
  result <- ft_attach_income(tbl, rbind(events[ft_keys], old[ft_keys]), c(value, old_value), "ing_remesas_ext")
  parts <- ft_period_parts(target)
  result$ing_remesas_ext[parts$periodo < 20001 | parts$periodo > 20162] <- NA_real_
  result
}
