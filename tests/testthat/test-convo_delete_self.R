test_that('`bs_delete_message_for_self()` works', {
  vcr::local_cassette('c_delete_self')
  x <- bs_delete_message_for_self('3ku7w6h4vog2d', '3lpi4fcbnxv2l', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
