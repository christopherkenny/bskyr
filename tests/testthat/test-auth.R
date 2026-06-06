test_that('`bs_auth()` requires `user` and `pass`', {
  expect_error(bs_auth(pass = '1234'), 'user.*must not be missing')
  expect_error(bs_auth(user = 'test'), 'pass.*must not be missing')
})

test_that('`bs_auth()` errors on non-logical `save_auth`', {
  expect_error(bs_auth('user', 'pass', save_auth = 'yes'), 'must be a logical')
})

test_that('`bs_auth()` works and caches when save_auth = TRUE', {
  withr::local_envvar(
    BLUESKY_APP_USER = 'test.bsky.social',
    BLUESKY_APP_PASS = 'abcd-efgh-ijkl-mnop'
  )
  fake_config <- tempfile()
  withr::local_options(list(R_USER_CONFIG_DIR = fake_config))

  vcr::local_cassette('repo_auth_cache', match_requests_on = c('uri', 'method'))
  expect_error(
    bs_auth(
      user = get_bluesky_user(),
      pass = get_bluesky_pass(),
      save_auth = FALSE
    ),
    'HTTP 401'
  )
})

test_that('`bs_auth()` forces refresh when save_auth = NULL', {
  skip_if_not(bs_has_pass())
  skip_if_not(bs_has_user())

  vcr::local_cassette('repo_auth_refresh', match_requests_on = c('uri', 'method'))
  # create initial cache file
  bs_auth(
    user = get_bluesky_user(),
    pass = get_bluesky_pass(),
    save_auth = TRUE
  )

  expect_true(fs::file_exists(bs_auth_file()))

  # manually overwrite timestamp to expire it
  key <- openssl::sha256(charToRaw(get_bluesky_pass()))
  auth <- httr2::secret_read_rds(bs_auth_file(), key = key)
  auth$bskyr_created_time <- Sys.time() - as.difftime(15, units = 'mins')
  httr2::secret_write_rds(auth, path = bs_auth_file(), key = key)

  # now refresh it
  new_auth <- bs_auth(
    user = get_bluesky_user(),
    pass = get_bluesky_pass(),
    save_auth = NULL
  )

  expect_true(file.exists(bs_auth_file()))
  expect_gt(new_auth$bskyr_created_time, auth$bskyr_created_time)
})

test_that('`bs_auth()` bypasses cache with save_auth = FALSE', {
  skip_if_not(bs_has_pass())
  skip_if_not(bs_has_user())

  if (!fs::file_exists(bs_auth_file())) {
    skip('No cached auth found, skipping test')
  }
  key <- openssl::sha256(charToRaw(get_bluesky_pass()))
  time <- httr2::secret_read_rds(bs_auth_file(), key = key)$bskyr_created_time

  vcr::local_cassette('repo_auth_direct', match_requests_on = c('uri', 'method'))
  auth <- bs_auth(
    user = get_bluesky_user(),
    pass = get_bluesky_pass(),
    save_auth = FALSE
  )

  expect_type(auth, 'list')
  expect_true(time != auth$bskyr_created_time)
})

test_that('`bs_auth_is_valid()` returns TRUE for fresh auth and FALSE for expired', {
  fresh <- list(bskyr_created_time = Sys.time())
  old   <- list(bskyr_created_time = Sys.time() - as.difftime(15, units = 'mins'))
  none  <- list()
  expect_true(bs_auth_is_valid(fresh))
  expect_false(bs_auth_is_valid(old))
  expect_false(bs_auth_is_valid(none))
})
