test_that('`bs_list_convos()` works', {
  vcr::local_cassette('c_list')
  x <- bs_list_convos(limit = 5, status = 'accepted', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
