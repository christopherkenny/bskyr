test_that('uri to urls works', {
  expect_equal(
    bs_uri_to_url('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s'),
    'https://bsky.app/profile/did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/post/3k7qmjev5lr2s'
  )
})
