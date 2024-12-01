with_mock_dir('t/g/relationships', {
  test_that('`bs_get_relationships()` works', {
    x <- bs_get_relationships('chriskenny.bsky.social', 'bskyr.bsky.social')
    expect_s3_class(x, 'tbl_df')
  })
})
