test_that('`bs_get_actor_lists()` works', {
  vcr::local_cassette('g_actorlists')
  x <- bs_get_actor_lists('pfrazee.com', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
