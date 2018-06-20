context("test-adjust_time.R")

test_that("correct output", {
  expect_equal(
    object = garminer:::adjust_time(896825460, 31916),
    expected = lubridate::as_datetime("2018-06-02 00:28:00")
  )
})
