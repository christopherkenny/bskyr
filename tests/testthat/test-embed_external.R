test_that('`bs_new_embed_external()` works', {
  embed <- bs_new_embed_external(
    uri = 'https://christophertkenny.com/bskyr/',
    auth = auth
  )
  expect_vector(embed, vector(mode = 'list'))
})
