#   test_that("`bs_post()` just text works", {
#     vcr::local_cassette('r_postT')
#     x <- bs_post(text = 'test post', auth = auth)
#     expect_s3_class(x, 'tbl_df')
#   })

test_that('`bs_post()` basic text post works', {
  vcr::local_cassette('r_post_text', match_requests_on = c('uri', 'method'))
  x <- bs_post('Test post from R CMD Check for r package `bskyr`
    via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)', auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` self-reply works', {
  vcr::local_cassette('r_post_reply', match_requests_on = c('uri', 'method'))
  x <- bs_post('Test self-reply from r package `bskyr`
    via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
    reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` quote works', {
  vcr::local_cassette('r_post_quote', match_requests_on = c('uri', 'method'))
  x <- bs_post('Test quoting from r package `bskyr`
    via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
    quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a',
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` quote + reply works', {
  vcr::local_cassette('r_post_quote_reply', match_requests_on = c('uri', 'method'))
  x <- bs_post('Test quote and reply from r package `bskyr`
    via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
    reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
    quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a',
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` emoji conversion works', {
  vcr::local_cassette('r_post_emoji', match_requests_on = c('uri', 'method'))
  x <- bs_post('Test quote with :emoji: and :fire: and :confetti_ball: from r package
    `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)', auth = auth)
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` with image upload works', {
  vcr::local_cassette('r_post_image', match_requests_on = c('uri', 'method'))
  img <- safe_figures('logo.png')
  x <- bs_post(
    text = 'Testing images and aspect ratios from R',
    images = img,
    images_alt = 'hexagonal logo of the R package bskyr, with the text "bskyr" on a cloud',
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` with video upload works', {
  vcr::local_cassette('r_post_video', match_requests_on = c('uri', 'method'))
  vid <- safe_figures('pkgs.mp4')
  x <- bs_post(
    text = 'testing sending videos from R',
    video = vid,
    video_alt = 'a carousel of package logos, all hexagonal',
    auth = auth
  )
  expect_s3_class(x, 'tbl_df')
})

test_that('`bs_post()` errors and warnings are triggered as expected', {
  vcr::local_cassette('r_post_errors', match_requests_on = c('uri', 'method'))

  expect_error(bs_post(), '`text` must not be missing')

  expect_error(
    bs_post('too many images', images = rep('a.png', 5), images_alt = rep('desc', 5), auth = auth),
    'You can only attach up to 4 images'
  )

  expect_error(
    bs_post('missing image alt', images = 'a.png', auth = auth),
    'If `images` is provided, `images_alt` must also be provided'
  )

  expect_error(
    bs_post('too many videos', video = c('a.mp4', 'b.mp4'), video_alt = 'alt', auth = auth),
    'You can only attach one video'
  )

  expect_error(
    bs_post('missing video alt', video = 'a.mp4', auth = auth),
    'If `video` is provided, `video_alt` must also be provided'
  )

  expect_error(
    bs_post('both image and video', images = 'a.png', images_alt = 'alt', video = 'b.mp4', video_alt = 'alt', auth = auth),
    'You can only attach images or a video'
  )

  expect_error(
    expect_warning(
      bs_post(paste(rep('A', 301), collapse = ''), auth = auth),
      'above the limit \\(300\\)'
    )
  )
})
