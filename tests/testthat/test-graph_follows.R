with_mock_dir("t/g/follows", {
  test_that("`bs_get_follows()` works", {
    x <- bs_get_follows('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
