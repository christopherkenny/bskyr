test_that('`bs_get_follow_suggestions()` works', {
  vcr::local_cassette('g_fs')
  x <- bs_get_follow_suggestions('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_get_follow_suggestions()` works', {
  vcr::local_cassette('g_fs')
  x <- bs_get_follow_suggestions('chriskenny.bsky.social', auth = auth, clean = FALSE)
  expect_equal(class(x), 'list')
})
