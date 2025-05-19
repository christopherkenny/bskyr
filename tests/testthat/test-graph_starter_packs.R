test_that('`bs_get_starter_packs()` works', {
  vcr::local_cassette('g_starts')
  x <- bs_get_starter_packs('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
