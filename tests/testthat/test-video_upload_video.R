test_that('`bs_upload_video()` works', {
  vcr::local_cassette('r_video_upload_video', match_requests_on = c('uri', 'method'))
  video_auth <- auth
  video_auth$did <- 'did:plc:5c2r73erhng4bszmxlfdtscf'
  vid <- safe_figures('pkgs.mp4')
  x <- bs_upload_video(video = vid, auth = video_auth)
  expect_type(x, 'list')
  expect_true(!is.null(x[[1]]$blob))
  expect_equal(x[[1]]$blob$mimeType, 'video/mp4')
})
