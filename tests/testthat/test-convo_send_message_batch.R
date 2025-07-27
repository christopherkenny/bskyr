test_that('`bs_send_message_batch()` works', {
  vcr::local_cassette('c_send_batch', match_requests_on = c('uri', 'method'))
  x <- bs_send_message_batch(
    convo_id = c('3ku7w6h4vog2d', '3lpidxucy2g27'),
    text = c('Hello', 'Hi there'),
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})
