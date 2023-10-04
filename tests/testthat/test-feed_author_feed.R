with_mock_dir("t/f/autfeed", {
  test_that("`bs_get_author_feed()` works", {
    x <- bs_get_author_feed('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
