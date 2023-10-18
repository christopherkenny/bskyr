with_mock_dir("t/f/feedgens", {
  test_that("`bs_get_feed_generators()` works", {
    x <- bs_get_feed_generators('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
