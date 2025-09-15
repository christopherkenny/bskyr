test_that('`bs_get_quotes()` works', {
  vcr::local_cassette('f_getquotes')
  x <- bs_get_quotes('at://did:plc:5c2r73erhng4bszmxlfdtscf/app.bsky.feed.post/3lc5c5qv72r2w', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
