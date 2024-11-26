# do we match:
# https://github.com/bluesky-social/atproto-website/blob/main/examples/create_bsky_post.py
test_that('parse mentions matches bluesky python', {
  expect_equal(
    parse_mentions('prefix @handle.example.com @handle.com suffix'),
    list(list(
      list(start = 7L, end = 26L, text = 'handle.example.com'),
      list(start = 27L, end = 38L, text = 'handle.com')
    ))
  )

  expect_equal(
    parse_mentions('handle.example.com'),
    list(list()) # length one list with an empty interior list
  )

  expect_equal(
    parse_mentions('@bare'),
    list(list()) # length one list with an empty interior list
  )

  expect_equal(
    parse_mentions('💩💩💩 @handle.example.com'),
    list(list(list(start = 13, end = 32, text = 'handle.example.com')))
  )

  expect_equal(
    parse_mentions('email@example.com'),
    list(list()) # length one list with an empty interior list
  )

  expect_equal(
    parse_mentions('cc:@example.com'),
    list(list(list(start = 3, end = 15, text = 'example.com')))
  )
})

test_that('parse url matches bluesky python', {
  expect_equal(
    parse_urls('prefix https://example.com/index.html http://bsky.app suffix'),
    list(list(
      list(start = 7L, end = 37L, text = 'https://example.com/index.html'),
      list(start = 38L, end = 53L, text = 'http://bsky.app')
    ))
  )

  expect_equal(
    parse_urls('example.com'),
    list(list()) # length one list with an empty interior list
  )

  expect_equal(
    parse_urls('💩💩💩 http://bsky.app'),
    list(list(list(start = 13L, end = 28L, text = 'http://bsky.app')))
  )

  expect_equal(
    parse_urls('runonhttp://blah.comcontinuesafter'),
    list(list()) # length one list with an empty interior list
  )



  expect_equal(
    parse_urls('ref (https://bsky.app/)'),
    list(list(list(start = 5L, end = 22L, text = 'https://bsky.app/'))) # length one list with an empty interior list
  )

  expect_equal(
    parse_urls('ends https://bsky.app. what else?'),
    list(list(list(start = 5L, end = 21L, text = 'https://bsky.app')))
  )
})

test_that('parse uri functions okay', {
  expect_equal(
    parse_uri('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x'),
    list(
      repo = 'bskyr.bsky.social', collection = 'app.bsky.feed.post',
      rkey = '3kf2577exva2x'
    )
  )

  expect_equal(
    parse_uri('at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/bsky-team'),
    list(
      repo = 'did:plc:z72i7hdynmk6r22z27h6tvur', collection = 'app.bsky.feed.generator',
      rkey = 'bsky-team'
    )
  )


  expect_warning(
    parse_uri(c('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x', ''))
  )

  expect_error(
    parse_uri(uri = 'abc:/')
  )
})

# do we match:
# https://github.com/bluesky-social/atproto/blob/main/packages/api/tests/rich-text-detection.test.ts
test_that('parse tags inline matches bluesky typescript', {
  expect_equal(
    parse_tags("#a"),
    list(list(list(start = 0, end = 2, text = 'a')))
  )

  expect_equal(
    parse_tags("#a #b"),
    list(list(list(start = 0, end = 2, text = 'a'),
              list(start = 3, end = 5, text = 'b')))
  )

  expect_equal(
    parse_tags("#1"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("#1a"),
    list(list(list(start = 0, end = 3, text = '1a')))
  )

  expect_equal(
    parse_tags("#tag"),
    list(list(list(start = 0, end = 4, text = 'tag')))
  )

  expect_equal(
    parse_tags("body #tag"),
    list(list(list(start = 5, end = 9, text = 'tag')))
  )

  expect_equal(
    parse_tags("#tag body"),
    list(list(list(start = 0, end = 4, text = 'tag')))
  )

  expect_equal(
    parse_tags("body #tag body"),
    list(list(list(start = 5, end = 9, text = 'tag')))
  )

  expect_equal(
    parse_tags("body #1"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("body #1a"),
    list(list(list(start = 5, end = 8, text = '1a')))
  )

  expect_equal(
    parse_tags("body #a1"),
    list(list(list(start = 5, end = 8, text = 'a1')))
  )

  expect_equal(
    parse_tags("#"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("#?"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("text #"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("text # text"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("body #thisisa64characterstring_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
    list(list(list(start = 5, end = 70, text = 'thisisa64characterstring_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')))
  )

  expect_equal(
    parse_tags("body #thisisa65characterstring_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("body #thisisa64characterstring_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!"),
    list(list(list(start = 5, end = 70, text = 'thisisa64characterstring_aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa')))
  )

  expect_equal(
    parse_tags("its a #double#rainbow"),
    list(list(list(start = 6, end = 21, text = 'double#rainbow')))
  )

  expect_equal(
    parse_tags("##hashash"),
    list(list(list(start = 0, end = 9, text = '#hashash')))
  )

  expect_equal(
    parse_tags("##"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("some #n0n3s@n5e!"),
    list(list(list(start = 5, end = 15, text = 'n0n3s@n5e')))
  )

  expect_equal(
    parse_tags("strips trailing #punctuation, #like. #this!"),
    list(list(list(start = 16, end = 28, text = 'punctuation'),
              list(start = 30, end = 35, text = 'like'),
              list(start = 37, end = 42, text = 'this')))
  )

  expect_equal(
    parse_tags("strips #multi_trailing___..."),
    list(list(list(start = 7, end = 22, text = 'multi_trailing')))
  )

  expect_equal(
    parse_tags("works with #🦋 emoji, and #butter🦋fly"),
    list(list(list(start = 11, end = 16, text = '🦋'),
              list(start = 28, end = 42, text = 'butter🦋fly')))
  )

  expect_equal(
    parse_tags("#same #same #but #diff"),
    list(list(list(start = 0, end = 5, text = 'same'),
              list(start = 6, end = 11, text = 'same'),
              list(start = 12, end = 16, text = 'but'),
              list(start = 17, end = 22, text = 'diff')))
  )

  expect_equal(
    parse_tags("this #️⃣tag should not be a tag"),
    list(list(list()))
  )

  expect_equal(
    parse_tags("this ##️⃣tag should be a tag"),
    list(list(list(start = 5, end = 16, text = '#️⃣tag')))
  )

  expect_equal(
    parse_tags("this #t\nag should be a tag"),
    list(list(list(start = 5, end = 7, text = 't')))
  )

  expect_equal(
    parse_tags('no match (\\u200B): #​'),
    list(list(list()))
  )

  expect_equal(
    parse_tags('no match (\\u200Ba): #​a'),
    list(list(list()))
  )

  expect_equal(
    parse_tags('match (a\\u200Bb): #a​b'),
    list(list(list(start = 18, end = 20, text = 'a')))
  )

  expect_equal(
    parse_tags('match (ab\\u200B): #ab​'),
    list(list(list(start = 18, end = 21, text = 'ab')))
  )

  expect_equal(
    parse_tags('no match (\\u20e2tag): #⃢tag'),
    list(list(list()))
  )

  expect_equal(
    parse_tags('no match (a\\u20e2b): #a⃢b'),
    list(list(list(start = 21, end = 23, text = 'a')))
  )

  expect_equal(
    parse_tags('match full width number sign (tag): ＃tag'),
    list(list(list(start = 36, end = 42, text = 'tag')))
  )

  expect_equal(
    parse_tags('match full width number sign (tag): ＃#️⃣tag'),
    list(list(list(start = 36, end = 49, text = '#️⃣tag')))
  )

  expect_equal(
    parse_tags('no match 1?: #1?'),
    list(list(list()))
  )
})
