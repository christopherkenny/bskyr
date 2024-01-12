with_mock_dir('t/g/blocks', {
  test_that('`bs_get_blocks()` works', {
    x <- bs_get_blocks(auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
