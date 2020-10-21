test_that("date_tool", {
  expect_error(dateInput_range(date = NULL, date = ""))
  expect_error(dateInput_range(character(0L)))
  expect_error(dateInput_ramge(date = "word"))
})
