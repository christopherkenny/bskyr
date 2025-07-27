test_that('`bs_get_actor_starter_packs()` works', {
  vcr::local_cassette('g_actorstart')
  x <- bs_get_actor_starter_packs('pfrazee.com', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
