test_that('`bs_get_actor_lists()` works', {
  vcr::local_cassette('g_actorlist')
  x <- bs_get_actor_lists('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
