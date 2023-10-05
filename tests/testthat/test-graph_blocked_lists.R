with_mock_dir("t/g/blockedlist", {
  test_that("`bs_get_blocked_lists()` works", {
    x <- bs_get_blocked_lists(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
