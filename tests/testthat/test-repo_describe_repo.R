with_mock_dir('t/r/descRepo', {
  test_that('`bs_describe_repo()` works', {
    x <- bs_describe_repo(repo = 'chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})

with_mock_dir('t/r/descRepoL', {
  test_that('`bs_describe_repo()` works', {
    x <- bs_describe_repo(repo = 'chriskenny.bsky.social', auth = auth, clean = TRUE)
    expect_s3_class(x, 'tbl_df')
  })
})
