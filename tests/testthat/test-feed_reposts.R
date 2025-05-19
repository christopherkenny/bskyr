test_that('`bs_get_reposts()` works', {
  vcr::local_cassette('f_reposts')
  x <- bs_get_reposts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3kaa2gxjhzr2a', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
