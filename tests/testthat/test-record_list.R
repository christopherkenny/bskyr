test_that('`bs_new_list()` works', {
  vcr::local_cassette('r_post_new_list', match_requests_on = c('uri', 'method'))
  x <- bs_new_list(name = 'test list bskyr', purpose = 'curatelist', auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_new_list()` with avatar works', {
  vcr::local_cassette('r_post_new_list_avatar', match_requests_on = c('uri', 'method'))
  img <- safe_figures('logo.png')
  x <- bs_new_list(
    name = 'test list bskyr w avatar',
    purpose = 'curatelist',
    description = 'to be deleted, just for testing bskyr',
    avatar = img,
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})
