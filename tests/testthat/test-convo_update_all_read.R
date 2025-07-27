test_that('`bs_update_all_read()` works', {
  vcr::local_cassette('c_all_read', match_requests_on = c('uri', 'method'))
  x <- bs_update_all_read(status = 'accepted', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
