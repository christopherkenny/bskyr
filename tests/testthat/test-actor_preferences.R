test_that('`bs_get_preferences()` works', {
  vcr::local_cassette('a_preferences')
  x <- bs_get_preferences(auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_get_preferences()` works', {
  vcr::local_cassette('a_preferencesL')
  x <- bs_get_preferences(auth = auth, clean = FALSE)
  expect_equal(class(x), 'list')
})
