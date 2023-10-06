with_mock_dir("t/g/mutedlists", {
  test_that("`bs_get_muted_lists()` works", {
    x <- bs_get_muted_lists(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
