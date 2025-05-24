test_that('`bs_get_starter_pack()` works', {
  vcr::local_cassette('g_start')
  x <- bs_get_starter_pack('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
