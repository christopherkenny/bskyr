test_that('`bs_get_convo_availability()` works', {
  vcr::local_cassette('c_availability')
  x <- bs_get_convo_availability('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
