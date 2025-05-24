test_that('`bs_repost()` works', {
  vcr::local_cassette('r_post_repost')
  x <- bs_repost(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
