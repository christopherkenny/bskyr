test_that('`bs_search_actors()` works', {
  vcr::local_cassette('f_search')
  x <- bs_search_posts('redistricting', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
