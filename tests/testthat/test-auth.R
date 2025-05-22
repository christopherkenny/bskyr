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

  vcr::local_cassette('repo_auth_cache')
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

  vcr::local_cassette('repo_auth_refresh')
  # create initial cache file
  bs_auth(
    user = get_bluesky_user(),
    pass = get_bluesky_pass(),
    save_auth = TRUE
  )

  expect_true(fs::file_exists(bs_auth_file()))

  # manually overwrite timestamp to expire it
  auth <- readRDS(bs_auth_file())
  auth$bskyr_created_time <- lubridate::now() - lubridate::dminutes(15)
  saveRDS(auth, bs_auth_file())

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

  time <- readRDS(bs_auth_file())$bskyr_created_time

  vcr::local_cassette('repo_auth_direct')
  auth <- bs_auth(
    user = get_bluesky_user(),
    pass = get_bluesky_pass(),
    save_auth = FALSE
  )

  expect_type(auth, 'list')
  expect_true(time != auth$bskyr_created_time)
})

test_that('`bs_auth_is_valid()` returns TRUE for fresh auth and FALSE for expired', {
  fresh <- list(bskyr_created_time = lubridate::now())
  old   <- list(bskyr_created_time = lubridate::now() - lubridate::dminutes(15))
  none  <- list()
  expect_true(bs_auth_is_valid(fresh))
  expect_false(bs_auth_is_valid(old))
  expect_false(bs_auth_is_valid(none))
})
