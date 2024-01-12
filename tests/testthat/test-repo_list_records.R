with_mock_dir('t/r/listrcd', {
  test_that('`bs_list_records()` works', {
    x <- bs_list_records(
      repo = 'did:plc:wpe35pganb6d4pg4ekmfy6u5',
      collection = 'app.bsky.feed.post', auth = auth
    )
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/r/listrcdL', {
  test_that('`bs_list_records()` works', {
    x <- bs_list_records(
      repo = 'did:plc:wpe35pganb6d4pg4ekmfy6u5',
      collection = 'app.bsky.feed.post', auth = auth, clean = FALSE
    )
    expect_equal(class(x), 'list')
  })
})
