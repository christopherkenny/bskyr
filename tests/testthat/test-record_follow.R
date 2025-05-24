test_that('`bs_follow()` works', {
  vcr::local_cassette('r_post_follow')
  x <- bs_follow(subject = 'chriskenny.bsky.social', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
