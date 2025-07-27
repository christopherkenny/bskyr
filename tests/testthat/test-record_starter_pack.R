test_that('`bs_new_starter_pack()` works', {
  vcr::local_cassette('r_post_new_starter_pack', match_requests_on = c('uri', 'method'))
  x <- bs_new_starter_pack('bskyr test', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
