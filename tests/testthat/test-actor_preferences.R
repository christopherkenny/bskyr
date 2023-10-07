with_mock_dir("t/a/preferences", {
  test_that("`bs_get_preferences()` works", {
    x <- bs_get_preferences(auth = auth)
    expect_true(is.list(x))
  })
})
