test_that('`bs_delete_post()` works', {
  vcr::local_cassette('r_post_delete_post', match_requests_on = c('uri', 'method'))
  pst <- bs_post('a test post to be deleted', auth = auth)
  rkey <- bs_extract_record_key(pst$uri)
  x <- bs_delete_post(rkey, auth = auth)
  expect_type(x, 'integer')
})

test_that('`bs_delete_like()` and `bs_unlike()` work', {
  vcr::local_cassette('r_post_delete_like', match_requests_on = c('uri', 'method'))
  like <- bs_like(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x', auth = auth)
  rkey <- bs_extract_record_key(like$uri)
  x1 <- bs_delete_like(rkey, auth = auth)
  x2 <- bs_unlike(rkey, auth = auth)
  expect_type(x1, 'integer')
  expect_type(x2, 'integer')
})

test_that('`bs_delete_follow()` and `bs_unfollow()` work', {
  vcr::local_cassette('r_post_delete_follow', match_requests_on = c('uri', 'method'))
  foll <- bs_follow(subject = 'chriskenny.bsky.social', auth = auth)
  rkey <- bs_extract_record_key(foll$uri)
  x1 <- bs_delete_follow(rkey, auth = auth)
  x2 <- bs_unfollow(rkey, auth = auth)
  expect_type(x1, 'integer')
  expect_type(x2, 'integer')
})

test_that('`bs_delete_block()` and `bs_unblock()` work', {
  vcr::local_cassette('r_post_delete_block', match_requests_on = c('uri', 'method'))
  blk <- bs_block(subject = 'nytimes.com', auth = auth)
  rkey <- bs_extract_record_key(blk$uri)
  x1 <- bs_delete_block(rkey, auth = auth)
  x2 <- bs_unblock(rkey, auth = auth)
  expect_type(x1, 'integer')
  expect_type(x2, 'integer')
})

test_that('`bs_delete_repost()` works', {
  vcr::local_cassette('r_post_delete_repost', match_requests_on = c('uri', 'method'))
  rp <- bs_repost(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x', auth = auth)
  rkey <- bs_extract_record_key(rp$uri)
  x <- bs_delete_repost(rkey, auth = auth)
  expect_type(x, 'integer')
})

test_that('`bs_delete_list()` works', {
  vcr::local_cassette('r_post_delete_list', match_requests_on = c('uri', 'method'))
  lst <- bs_new_list(name = 'delete test list', purpose = 'curatelist', auth = auth)
  rkey <- bs_extract_record_key(lst$uri)
  x <- bs_delete_list(rkey, auth = auth)
  expect_type(x, 'integer')
})

test_that('`bs_delete_list_item()` works', {
  vcr::local_cassette('r_post_delete_list_item', match_requests_on = c('uri', 'method'))
  lst <- bs_new_list(name = 'delete test list item', purpose = 'curatelist', auth = auth)
  itm <- bs_new_list_item(subject = 'bskyr.bsky.social', uri = lst$uri, auth = auth)
  rkey_item <- bs_extract_record_key(itm$uri)
  x <- bs_delete_list_item(rkey_item, auth = auth)

  # cleanup list itself
  rkey_list <- bs_extract_record_key(lst$uri)
  bs_delete_list(rkey_list, auth = auth)

  expect_type(x, 'integer')
})

test_that('`bs_delete_starter_pack()` works', {
  vcr::local_cassette('r_post_delete_starter_pack', match_requests_on = c('uri', 'method'))
  starter <- bs_new_starter_pack(name = 'delete test pack', auth = auth)
  rkey <- bs_extract_record_key(starter$uri)
  x <- bs_delete_starter_pack(rkey, auth = auth)
  expect_type(x, 'integer')
})
