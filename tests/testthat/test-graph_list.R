test_that('`bs_get_list()` works', {
  vcr::local_cassette('g_getlist')
  x <- bs_get_list('at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
