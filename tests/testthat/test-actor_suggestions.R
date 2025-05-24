test_that('`bs_get_actor_suggestions()` works', {
  vcr::local_cassette('a_sugg')
  x <- bs_get_actor_suggestions(auth = auth)
  expect_s3_class(x, 'tbl_df')
})
