test_that('`bs_new_embed_external()` works', {
  vcr::local_cassette('e_external', preserve_exact_body_bytes = TRUE, match_requests_on = c('uri', 'method'))
  embed <- bs_new_embed_external(
    uri = 'https://christophertkenny.com/bskyr/',
    auth = auth
  )
  expect_vector(embed, vector(mode = 'list'))
})
