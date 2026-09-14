test_that("periods, flags and structures have unambiguous contracts", {
  x <- data.frame(EFT_PERIODO=c("1/2005","2005/2","20061"),ano=0,marker=letters[1:3])
  expect_equal(ft_peri_vars(x)$periodo,c(20051,20052,20061))
  expect_equal(ft_peri_vars(x,ano=FALSE)$ano,rep(0,3))
  expect_equal(ft_peri_vars(x,rm=TRUE)$marker,x$marker)
  expect_false("EFT_PERIODO" %in% names(ft_peri_vars(x,rm=TRUE)))
  expect_equal(nrow(ft_peri_vars(x[FALSE,])),0)
  for (p in c("3/2005","2005/0","2005",NA)) expect_error(ft_peri_vars(data.frame(EFT_PERIODO=p)))
  expect_error(ft_peri_vars(x,rm=NA))
  expect_error(ft_version(data.frame(PERIALFA=1,EFT_PERIODO=1)))
  expect_equal(ft_version(data.frame(PERIALFA="1/2000")),1)
  expect_equal(ft_zona(data.frame(PERIALFA="1/2000",S1_P4=c(0,1)))$zona,c(1,2))
  expect_error(ft_zona(data.frame(EFT_PERIODO="1/2016",EFT_ZONA=2)))
  expect_error(ft_pet(enft_like,min_edad=-1))
  x <- enft_like[1,]; x$EFT_BUSCO_TRAB_SEM_ANT <- 1; x$EFT_TIENE_COND_JORNADA <- 1
  expect_equal(ft_desempleo_abierto(x)$desempleo_abierto,0)
  expect_equal(ft_desempleo_ampliado(x)$desempleo_ampliado,0)
})

test_that("database helper forwards without contacting a database", {
  local_mocked_bindings(db_connect=function(db_name,...) list(name=db_name,args=list(...)),.package="Dmisc")
  expect_identical(ft_db_connect("example",port=1234),list(name="example",args=list(port=1234)))
  expect_warning(expect_equal(ft_dbConnect("example")$name,"example"),"deprecated")
})

test_that("dictionary revisions reuse unchanged definitions", {
  d <- ft_dict()
  expect_equal(labeler::dict_revision(d)$dictionary_id,"enft")
  expect_error(ft_dict(at="2005-01-01"))
  expect_error(ft_dict(version="absent"))
  expect_equal(nrow(ft_browse_dict(testing=TRUE)),length(setdiff(names(d),"metadata")))
  labeled <- ft_set_labels(data.frame(EFT_ZONA=c(0,1)),vars="EFT_ZONA")
  expect_true(!is.null(attr(labeled$EFT_ZONA,"labels")))
  con <- DBI::dbConnect(RSQLite::SQLite(),":memory:"); on.exit(DBI::dbDisconnect(con))
  first <- ft_register_dict(con,labeler::dict_draft(d),"v1",valid_from="2005-01-01",valid_to="2005-12-31")
  draft <- labeler::dict_draft(first); draft$EFT_ZONA$label <- "Zona revisada"
  second <- ft_register_dict(con,draft,"v2",parent_version="v1",valid_from="2006-01-01",valid_to="2006-12-31")
  expect_equal(labeler::dict_revision(ft_dict(at="2006-06-01",con=con))$version,"v2")
  r1 <- labeler::dict_revision(first)$variable_refs; r2 <- labeler::dict_revision(second)$variable_refs
  expect_equal(r1$EFT_EDAD,r2$EFT_EDAD)
  expect_false(identical(r1$EFT_ZONA$definition_hash,r2$EFT_ZONA$definition_hash))
})

test_that("coverage and missing income never silently become a category", {
  result <- ft_pobreza_monetaria(enft_like)
  expect_equal(sum(result$pobreza_estado=="outside_coverage"),18)
  expect_equal(sum(result$pobreza_estado=="classified"),54)
  expect_true(all(is.na(result$pobreza_monetaria[result$pobreza_estado=="outside_coverage"])))
  x <- enft_like[19:21,]; x$EFT_ING_OCUP_PRINC[1] <- NA_real_
  result <- ft_pobreza_monetaria(x)
  expect_true(all(is.na(result$pobreza_monetaria)))
  expect_true(all(result$pobreza_estado=="missing_income"))
  expect_equal(nrow(ft_pobreza_monetaria(x[FALSE,])),0)
  x$EFT_PERIODO <- "1/2017"
  expect_true(all(ft_pobreza_monetaria(x)$pobreza_estado=="outside_coverage"))
})

test_that("independent line boundaries and reuse use monthly per capita DOP", {
  x <- enft_like[19:21,]
  for (name in ft_income_components) x[[name]] <- 0
  line <- lineas_oficial_zona[lineas_oficial_zona$EFT_PERIODO=="1/2005" & lineas_oficial_zona$EFT_ZONA==0,]
  for (case in list(c(0,1),c(line$lindigencia,1),c(line$lindigencia+0.01,2),c(line$lpobreza,2),c(line$lpobreza+0.01,3))) {
    x$ing_ocup_prin <- rep(case[1],3)
    result <- ft_pobreza_monetaria(x,.reuse=TRUE)
    expect_equal(result$ing_pc_pobreza_monetaria,rep(case[1],3))
    expect_equal(result$pobreza_monetaria,rep(case[2],3))
  }
  expect_error(ft_pobreza_monetaria(enft_like,.reuse="ing_ocup_prin"),"Falta")
  expect_error(ft_pobreza_monetaria(x,.keep="absent"))
  expect_equal(nrow(ft_pobreza_monetaria(x)),3)
})

test_that("keys and household structure prevent accidental multiplication", {
  x <- enft_like[19:21,]
  expect_error(ft_pobreza_monetaria(rbind(x,x[1,])),"duplicados")
  bad <- x; bad$EFT_ZONA[1] <- 1
  expect_error(ft_pobreza_monetaria(bad),"Zona inconsistente")
  bad <- x; bad$EFT_PARENTESCO_CON_JEFE <- 2
  expect_error(ft_pobreza_monetaria(bad),"un jefe")
  x$lindigencia <- -1; x$lpobreza <- -1
  result <- ft_pobreza_monetaria(x)
  expect_true(all(result$lindigencia>0))
  expect_false(any(grepl("\\.x$|\\.y$",names(result))))
})

test_that("December remittance uses the previous year and exact slots", {
  x <- enft_like[37:39,]
  for (slot in c("SEP","AGO","JUL","PER4","PER5","PER6")) x[[paste0("EFT_MONTO_",slot)]] <- 0
  x$EFT_MONTO_PER4[1] <- 120
  fx <- tdc_oficial$value[tdc_oficial$date==as.Date("2007-12-31") & tdc_oficial$cod_moneda2==1]
  base <- ipc_oficial$ipc[ipc_oficial$date==as.Date("2008-03-31")]
  payment <- ipc_oficial$ipc[ipc_oficial$date==as.Date("2007-12-31")]
  expected <- c(120*fx*base/payment/6,0,0)
  expect_equal(ft_ing_remesas_ext(x)$ing_remesas_ext,expected)
  x$EFT_MONTO_UNRELATED <- 999999
  expect_equal(ft_ing_remesas_ext(x)$ing_remesas_ext,expected)
  x$EFT_MONEDA_PER4[1] <- 999
  expect_error(ft_ing_remesas_ext(x),"tipo de cambio")
  x$EFT_MONEDA_PER4[1] <- 1; x$EFT_MONTO_PER4[1] <- NA_real_
  expect_true(is.na(ft_ing_remesas_ext(x)$ing_remesas_ext[1]))
})

test_that("separate transactions distinguish absent from unknown", {
  x <- enft_like[19:21,]; events <- x[c(1,1),]
  events$EFT_MONTO_EQUIV_REGALO <- c(10,20)
  expect_equal(ft_ing_regalos_ext(x,events)$ing_regalos_ext,c(30,0,0))
  events$EFT_MONTO_EQUIV_REGALO[2] <- NA_real_
  expect_true(is.na(ft_ing_regalos_ext(x,events)$ing_regalos_ext[1]))
  events$EFT_MIEMBRO <- 99
  expect_error(ft_ing_regalos_ext(x,events),"ausentes")
})

test_that("synthetic branch reference remains reproducible", {
  path <- system.file("reference",package="enftr")
  x <- jsonlite::fromJSON(file.path(path,"branch-members.json"))
  report <- jsonlite::fromJSON(file.path(path,"report.json"),simplifyVector=FALSE)
  for (name in names(report)) {
    result <- get(paste0("ft_",name))(x)
    expected <- jsonlite::fromJSON(file.path(path,paste0(name,".json")))
    for (column in names(expected)) expect_equal(as.numeric(result[[column]]),as.numeric(unlist(expected[[column]])),tolerance=1e-10,info=paste(name,column))
  }
})
