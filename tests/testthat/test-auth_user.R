test_that('`has_bluesky_user()` and `get_bluesky_user()` work as expected', {
  withr::local_envvar(BLUESKY_APP_USER = 'example.bsky.social')
  expect_true(has_bluesky_user())
  expect_equal(get_bluesky_user(), 'example.bsky.social')
  expect_equal(bs_get_user(), 'example.bsky.social')
  expect_true(bs_has_user())
})

test_that('`set_bluesky_user()` sets envvar in session only if not installed', {
  withr::local_envvar(BLUESKY_APP_USER = '')
  withr::defer(Sys.unsetenv('BLUESKY_APP_USER'))  # ensure cleanup
  set_bluesky_user('set.in.session.bsky.social', install = FALSE)
  expect_equal(Sys.getenv('BLUESKY_APP_USER'), 'set.in.session.bsky.social')
})

test_that('`set_bluesky_user()` handles test username silently and returns invisibly', {
  withr::local_envvar(BLUESKY_APP_USER = '')
  out <- set_bluesky_user('CRAN_EXAMPLE.bsky.social', install = FALSE)
  expect_type(out, 'list')
  expect_named(out, 'BLUESKY_APP_USER')
  expect_equal(Sys.getenv('BLUESKY_APP_USER'), '')  # no session change
})

test_that('`set_bluesky_user()` installs to a new .Renviron when not present', {
  example_env <- tempfile(fileext = '.Renviron')
  withr::local_envvar(BLUESKY_APP_USER = '')
  set_bluesky_user('write.test.bsky.social', install = TRUE, r_env = example_env)
  lines <- readLines(example_env)
  expect_true(any(grepl('BLUESKY_APP_USER=', lines)))
})

test_that('`set_bluesky_user()` overwrites existing entry in .Renviron if allowed', {
  example_env <- tempfile(fileext = '.Renviron')
  writeLines("BLUESKY_APP_USER='old.user'", example_env)

  withr::local_envvar(BLUESKY_APP_USER = '')
  set_bluesky_user('new.user.bsky.social', install = TRUE, overwrite = TRUE, r_env = example_env)
  lines <- readLines(example_env)
  expect_true(any(grepl("BLUESKY_APP_USER='new.user.bsky.social'", lines)))
})

test_that('`set_bluesky_user()` refuses to overwrite unless allowed', {
  example_env <- tempfile(fileext = '.Renviron')
  writeLines("BLUESKY_APP_USER='existing.user'", example_env)

  withr::local_envvar(BLUESKY_APP_USER = '')
  expect_message(
    set_bluesky_user('attempted.overwrite.user', install = TRUE, overwrite = FALSE, r_env = example_env),
    'already exists in .Renviron'
  )

  lines <- readLines(example_env)
  expect_true(any(grepl("BLUESKY_APP_USER='existing.user'", lines)))
})
