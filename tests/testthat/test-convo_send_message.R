test_that('`bs_send_message()` works', {
  vcr::local_cassette('c_send')
  x <- bs_send_message('3ku7w6h4vog2d', '[example] sent with bskyr', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
