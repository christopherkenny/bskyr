test_that('`bs_describe_repo()` works', {
  vcr::local_cassette('r_descRepo')
  x <- bs_describe_repo(repo = 'chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_describe_repo()` works', {
  vcr::local_cassette('r_descRepoL')
  x <- bs_describe_repo(repo = 'chriskenny.bsky.social', auth = auth, clean = TRUE)
  expect_s3_class(x, 'tbl_df')
})
