test_that('`has_bluesky_pass()` and `get_bluesky_pass()` work as expected', {
  withr::local_envvar(BLUESKY_APP_PASS = 'abcd-efgh-ijkl-mnop')
  expect_true(has_bluesky_pass())
  expect_equal(get_bluesky_pass(), 'abcd-efgh-ijkl-mnop')
  expect_equal(bs_get_pass(), 'abcd-efgh-ijkl-mnop')
  expect_true(bs_has_pass())
})

test_that('`set_bluesky_pass()` sets envvar in session only if not installed', {
  withr::local_envvar(BLUESKY_APP_PASS = '')
  withr::defer(Sys.unsetenv('BLUESKY_APP_PASS'))  # cleanup if `do.call()` leaks
  set_bluesky_pass('1111-2222-3333-4444', install = FALSE)
  expect_equal(Sys.getenv('BLUESKY_APP_PASS'), '1111-2222-3333-4444')
})

test_that('`set_bluesky_pass()` handles test password silently and returns invisibly', {
  withr::local_envvar(BLUESKY_APP_PASS = '')
  out <- set_bluesky_pass('1234-1234-1234-1234', install = FALSE)
  expect_type(out, 'list')
  expect_named(out, 'BLUESKY_APP_PASS')
  expect_equal(Sys.getenv('BLUESKY_APP_PASS'), '')  # unchanged
})

test_that('`set_bluesky_pass()` installs to a new .Renviron when not present', {
  example_env <- tempfile(fileext = '.Renviron')
  withr::local_envvar(BLUESKY_APP_PASS = '')  # don't affect other tests
  set_bluesky_pass('aaaa-bbbb-cccc-dddd', install = TRUE, r_env = example_env)
  lines <- readLines(example_env)
  expect_true(any(grepl('BLUESKY_APP_PASS=', lines)))
})

test_that('`set_bluesky_pass()` overwrites existing entry in .Renviron if allowed', {
  example_env <- tempfile(fileext = '.Renviron')
  writeLines("BLUESKY_APP_PASS='old-pass'", example_env)

  withr::local_envvar(BLUESKY_APP_PASS = '')  # prevent session leakage
  set_bluesky_pass('new-pass-value', install = TRUE, overwrite = TRUE, r_env = example_env)
  lines <- readLines(example_env)
  expect_true(any(grepl("BLUESKY_APP_PASS='new-pass-value'", lines)))
})

test_that('`set_bluesky_pass()` refuses to overwrite unless allowed', {
  example_env <- tempfile(fileext = '.Renviron')
  writeLines("BLUESKY_APP_PASS='existing-pass'", example_env)

  withr::local_envvar(BLUESKY_APP_PASS = '')  # suppress session pollution
  expect_message(
    set_bluesky_pass('attempted-overwrite', install = TRUE, overwrite = FALSE, r_env = example_env),
    'already exists in .Renviron'
  )

  lines <- readLines(example_env)
  expect_true(any(grepl("BLUESKY_APP_PASS='existing-pass'", lines)))
})
