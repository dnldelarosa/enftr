test_that("variables demográficas", {
  local_edition(3)
  # ft_zona tiene su propio test file
  enft <- data.frame(
    EFT_PERIODO = paste0(c(1, 2), '/', c(2000:2016)),
    EFT_PROVINCIA = c(1:32, 1, 32),
    EFT_ZONA = c(rep(0, 17), rep(1, 17))
  ) %>% 
    ft_peri_vars()
  expect_snapshot(ft_regiones_desarrollo(enft))
  expect_snapshot(ft_regiones_desarrollo_710_04(enft))
  expect_snapshot(ft_regiones_desarrollo_685_00(enft))
  expect_snapshot(ft_zona_desarrollo_fronterizo(enft))
  expect_snapshot(ft_dominios_inferencia(enft))
  expect_snapshot(ft_dominios_inferencia1(enft))
  expect_snapshot(ft_dominios_inferencia2(enft))
  expect_snapshot(ft_dominios_inferencia3(enft))
  
  
  enft1 <- data.frame(
    PERIALFA = 1:2,
    S1_P4 = 0:1
  )
  enft2 <- data.frame(
    EFT_PERIODO = 1:2,
    EFT_ZONA = 0:1
  )
  expect_snapshot(ft_zona(enft1))
  expect_snapshot(ft_zona(enft2))
  expect_snapshot(ft_compute_zona(enft2))
})
