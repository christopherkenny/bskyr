with_mock_dir("t/f/reposts", {
  test_that("`bs_get_reposts()` works", {
    x <- bs_get_reposts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3kaa2gxjhzr2a', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
