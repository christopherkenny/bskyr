with_mock_dir('t/f/getlikes', {
  test_that('`bs_get_likes()` works', {
    x <- bs_get_likes('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})

test_that("`bs_get_likes()` errors if actor is not the authenticated user", {
  skip_if_offline()
  skip_if(!has_bluesky_user() || !has_bluesky_pass())

  fake_user <- paste0("not-", bs_get_user())

  expect_error(
    bs_get_likes(fake_user),
    regexp = "Likes can only be obtained for the authenticated user"
  )
})
