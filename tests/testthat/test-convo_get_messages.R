test_that('`bs_get_messages()` works', {
  vcr::local_cassette('c_messages')
  x <- bs_get_messages('3ku7w6h4vog2d', limit = 10, auth = auth)
  expect_s3_class(x, 'tbl_df')
})
