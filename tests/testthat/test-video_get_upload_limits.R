test_that('`bs_get_video_upload_limits()` works', {
  vcr::local_cassette('r_video_get_upload_limits', match_requests_on = c('uri', 'method'))
  x <- bs_get_video_upload_limits(auth = auth)
  expect_type(x, 'list')
  expect_true('can_upload' %in% names(x))
})
