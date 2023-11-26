with_mock_dir("t/a/preferences", {
  test_that("`bs_get_preferences()` works", {
    x <- bs_get_preferences(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir("t/a/preferencesL", {
  test_that("`bs_get_preferences()` works", {
    x <- bs_get_preferences(auth = auth, clean = FALSE)
    expect_equal(class(x), 'list')
  })
})
