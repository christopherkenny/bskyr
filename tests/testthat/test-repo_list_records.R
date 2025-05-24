test_that('`bs_list_records()` works', {
  vcr::local_cassette('r_listrcd')
  x <- bs_list_records(
    repo = 'did:plc:wpe35pganb6d4pg4ekmfy6u5',
    collection = 'app.bsky.feed.post', auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_list_records()` works', {
  vcr::local_cassette('r_listrcdL')
  x <- bs_list_records(
    repo = 'did:plc:wpe35pganb6d4pg4ekmfy6u5',
    collection = 'app.bsky.feed.post', auth = auth, clean = FALSE
  )
  expect_equal(class(x), 'list')
})
