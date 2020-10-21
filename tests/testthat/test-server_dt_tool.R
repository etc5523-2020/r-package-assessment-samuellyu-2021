test_that("test-dt-tool-inputs-are-accurate", {
  expect_error(dt_styler(data = NULL, var = NULL, cnt1 = NULL, cnt2 = NULL, clr1 = NULL, clr2 = NULL, plength = NULL))
  expect_error(dt_styler(data = "", var = "", cnt1 = "", cnt2 = "", clr1 = "", clr2 = "", plength = ""))
  expect_error(dt_styler(character(0L)))
  expect_error(dt_styler(clr1 = "Not", clr2 = "Color"))
  expect_error(dt_styler(plength = "not"))
})
