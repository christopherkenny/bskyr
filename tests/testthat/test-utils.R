test_that('`validate_user()` rejects non-handles', {
  expect_error(validate_user('chriskenny'), 'not a valid handle')
  expect_error(validate_user('@chriskenny.bsky.social'), 'not a valid handle')
  expect_error(validate_user('did:plc:abc123'), 'not a valid handle')
  expect_error(validate_user(''), 'empty string')
  expect_error(validate_user(123), 'character')
})

test_that('`validate_pass()` rejects malformed passwords', {
  expect_error(validate_pass('abc-efgh-ijkl-mnop'), '19 characters')
  expect_error(validate_pass('abcdefghijklmnopstu'), 'xxxx-xxxx-xxxx-xxxx')
  expect_error(validate_pass(''), 'empty string')
  expect_error(validate_pass(1234), 'character')
})

test_that('`validate_limit()` passes NULL and floors to 1', {
  expect_null(validate_limit(NULL))
  expect_equal(validate_limit(0), 1L)
  expect_equal(validate_limit(-10), 1L)
})

test_that('`clean_names()` converts camelCase to snake_case', {
  x <- list(
    displayName = 'Chris Kenny',
    indexedAt = '2024-01-01',
    followersCount = 554L
  )
  expect_named(
    clean_names(x),
    c('display_name', 'indexed_at', 'followers_count')
  )
})

test_that('`pack()` returns NA for NULL and wraps vectors', {
  expect_equal(pack(NULL), NA)
  result <- pack(c('did:plc:aaa', 'did:plc:bbb'))
  expect_type(result, 'list')
  expect_length(result[[1]], 2L)
})

test_that('`make_req_seq()` splits into 100-item pages', {
  expect_equal(make_req_seq(NULL), list(NULL))
  expect_equal(make_req_seq(100), 100)
  expect_equal(make_req_seq(150), c(100, 50))
  expect_equal(make_req_seq(250), c(100, 100, 50))
})
