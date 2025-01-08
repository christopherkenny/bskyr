with_mock_dir('t/o/url2uri', {
  test_that('urls to uri works post', {
    expect_equal(
      bs_url_to_uri('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c', auth = auth),
      'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lc5d6zspys2c'
    )
  })
})

with_mock_dir('t/o/url2uri', {
  test_that('urls to uri works starter-pack', {
    expect_equal(
      bs_url_to_uri('https://bsky.app/starter-pack/chriskenny.bsky.social/3lb3g5veo2z2r', auth = auth),
      'at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.graph.starterpack/3lb3g5veo2z2r'
    )
  })
})

test_that('extract record key works', {
  expect_equal(
    bs_extract_record_key('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c'),
    '3lc5d6zspys2c'
  )
})
