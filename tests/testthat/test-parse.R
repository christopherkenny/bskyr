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

test_that('parse emoji functions okay', {
  skip_if_not_installed('emoji')

  expect_equal(
    parse_emoji('Test quote with :emoji:'),
    'Test quote with :emoji:'
  )

  expect_equal(
    parse_emoji('Test quote with :emoji: and :fire:'),
    'Test quote with :emoji: and 🔥'
  )

  expect_equal(
    parse_emoji(':fire:'),
    '🔥'
  )

  expect_equal(
    parse_emoji('Test quote with :emoji: and :fire: and :confetti_ball:'),
    'Test quote with :emoji: and 🔥 and 🎊'
  )

  expect_equal(
    parse_emoji('Test quote with :emoji: and :fire: and :confetti_ball: from r package `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)'),
    'Test quote with :emoji: and 🔥 and 🎊 from r package `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)'
  )


})
