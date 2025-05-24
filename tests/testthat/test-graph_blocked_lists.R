test_that('`bs_get_blocked_lists()` works', {
  vcr::local_cassette('g_blockedlist')
  x <- bs_get_blocked_lists(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
