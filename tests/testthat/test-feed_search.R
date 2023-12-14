with_mock_dir("t/f/search", {
  test_that("`bs_search_actors()` works", {
    x <- bs_search_posts('redistricting', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
