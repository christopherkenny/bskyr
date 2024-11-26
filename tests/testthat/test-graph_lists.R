with_mock_dir('t/g/actorlists', {
  test_that('`bs_get_actor_lists()` works', {
    x <- bs_get_actor_lists('pfrazee.com', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
