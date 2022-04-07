test_that("multiplication works", {
  local_edition(3)
  expect_snapshot(ft_peri_vars(enft_like) %>% dplyr::glimpse())
  expect_snapshot(ft_peri_vars(enft_like, rm = TRUE) %>% dplyr::glimpse())
  expect_snapshot(ft_peri_vars(enft_like, ano = FALSE, semestre=FALSE) %>% dplyr::glimpse())
  expect_snapshot(ft_compute_peri_vars(enft_like) %>% dplyr::glimpse())
  expect_snapshot(ft_compute_ano(enft_like) %>% dplyr::glimpse())
  expect_snapshot(ft_ano(enft_like) %>% dplyr::glimpse())
})
