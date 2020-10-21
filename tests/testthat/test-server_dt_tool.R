test_that("dt-tool-input", {
  expect_error(dt_styler(data = NULL))
  expect_error(dt_styler(data = ""))
})
