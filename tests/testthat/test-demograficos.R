test_that("variables demográficas", {
  local_edition(3)
  enft0 <- enft_like %>% 
    ft_peri_vars()
  expect_snapshot(ft_zona(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_regiones_desarrollo(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_regiones_desarrollo_710_04(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_regiones_desarrollo_685_00(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_zona_desarrollo_fronterizo(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_dominios_inferencia(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_dominios_inferencia1(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_dominios_inferencia2(enft0) %>% dplyr::glimpse())
  expect_snapshot(ft_dominios_inferencia3(enft0) %>% dplyr::glimpse())
  
  
  enft1 <- data.frame(
    PERIALFA = 1:2,
    S1_P4 = 0:1
  )
  enft2 <- data.frame(
    EFT_PERIODO = 1:2,
    EFT_ZONA = 0:1
  )
  expect_snapshot(ft_zona(enft1) %>% dplyr::glimpse())
  expect_snapshot(ft_zona(enft2) %>% dplyr::glimpse())
  expect_snapshot(ft_compute_zona(enft2) %>% dplyr::glimpse())
})
