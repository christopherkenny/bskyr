test_that('`bs_add_reaction()` works', {
  vcr::local_cassette('c_add_reaction')
  x <- bs_add_reaction('3ku7w6h4vog2d', '3lphbnrx7l32l', '👍', auth = auth)
  expect_s3_class(x, 'tbl_df')
})
