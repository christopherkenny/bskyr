test_that('`bs_get_likes()` works', {
  vcr::local_cassette('f_getlikes')
  x <- bs_get_likes('chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
