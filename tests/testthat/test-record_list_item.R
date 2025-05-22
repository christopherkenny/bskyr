test_that('`bs_new_list_item()` works', {
  vcr::local_cassette('r_post_new_list_item')
  lst <- bs_new_list(name = 'test list item', purpose = 'curatelist', auth = auth)
  x <- bs_new_list_item(subject = 'chriskenny.bsky.social', uri = lst$uri, auth = auth)
  expect_s3_class(x, 'tbl_df')
})
