test_that('uri to url works', {
  expect_equal(
    bs_uri_to_url('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s'),
    'https://bsky.app/profile/did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/post/3k7qmjev5lr2s'
  )
})

with_mock_dir('t/o/url2uri', {
  test_that('urls to uri works', {
    expect_equal(
      bs_url_to_uri('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c'),
      'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lc5d6zspys2c'
    )
  })
})
