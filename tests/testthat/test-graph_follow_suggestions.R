with_mock_dir("t/g/fs", {
  test_that("`bs_get_follow_suggestions()` works", {
    x <- bs_get_follow_suggestions('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/g/fs", {
  test_that("`bs_get_follow_suggestions()` works", {
    x <- bs_get_follow_suggestions('chriskenny.bsky.social', auth = auth, clean = FALSE)
    expect_equal(class(x), 'list')
  })
})
