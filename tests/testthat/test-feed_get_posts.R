test_that('`bs_get_posts()` works', {
  vcr::local_cassette('f_getposts')
  x <- bs_get_posts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
