with_mock_dir("t/f/postlikes", {
  test_that("`bs_get_follows()` works", {
    x <- bs_get_post_likes('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
