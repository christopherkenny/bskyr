test_that("time creation works", {
  expect_equal(nchar(bs_created_at()), 27)
})
