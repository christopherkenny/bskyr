test_that('`bs_upload_blob()` works', {
  vcr::local_cassette('r_upload_blob', match_requests_on = c('uri', 'method'))
  fig <- safe_figures('logo.png')
  x <- bs_upload_blob(blob = fig, auth = auth)
  expect_s3_class(x, 'tbl_df')
})
