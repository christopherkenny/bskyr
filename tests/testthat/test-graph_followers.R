with_mock_dir("t/g/followers", {
  test_that("`bs_get_followers()` works", {
    x <- bs_get_followers('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
