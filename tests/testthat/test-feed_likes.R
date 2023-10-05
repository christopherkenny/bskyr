with_mock_dir("t/f/getlikes", {
  test_that("`bs_get_likes()` works", {
    x <- bs_get_likes('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
