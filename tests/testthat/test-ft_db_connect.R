test_that("database connection", {
  expect_error(ft_db_connect(db_name = "falso"))
  expect_error(ft_dbConnect(db_name = "falso"))
})
