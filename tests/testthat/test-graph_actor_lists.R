with_mock_dir('t/g/actorlist', {
  test_that('`bs_get_actor_lists()` works', {
    x <- bs_get_actor_lists('chriskenny.bsky.social', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
