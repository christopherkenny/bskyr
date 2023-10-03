with_mock_dir("t/a/sugg", {
  test_that("`bs_get_actor_suggestions()` works", {
    x <- bs_get_actor_suggestions('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
