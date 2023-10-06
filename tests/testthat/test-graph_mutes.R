with_mock_dir("t/g/mutes", {
  test_that("`bs_get_mutes()` works", {
    x <- bs_get_mutes(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
