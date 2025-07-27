test_that('`bs_get_list_feed()` works', {
  vcr::local_cassette('f_get_list_feed')
  x <- bs_get_list_feed(
    list = 'at://did:plc:ragtjsm2j2vknwkz3zp4oxrd/app.bsky.graph.list/3kmokjyuflk2g',
    limit = 10,
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})
