test_that('`bs_get_convo_log()` works', {
  vcr::local_cassette('c_log')
  x <- bs_get_convo_log(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
