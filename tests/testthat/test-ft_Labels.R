test_that("etiquetas", {
  local_edition(3)
  expect_snapshot(str(ft_set_labels(enft_like, dict)))
  expect_snapshot(str(ft_setLabels(enft_like, dict)))
  expect_snapshot(ft_use_labels(enft_like, dict) %>% dplyr::glimpse())
  expect_snapshot(ft_useLabels(enft_like, dict) %>% dplyr::glimpse())
  expect_snapshot(ft_browse_dict(testing = TRUE))
})
