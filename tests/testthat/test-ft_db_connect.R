test_that("database connection", {
  expect_error(ft_db_connect(db_name = "0"))
  expect_error(ft_dbConnect(db_name = "0"))
})
