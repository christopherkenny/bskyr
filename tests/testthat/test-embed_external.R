test_that('`bs_new_embed_external()` works', {
  skip(message = 'Error in `rawToChar(b)`: embedded nul in string')
  embed <- bs_new_embed_external(
    uri = 'https://christophertkenny.com/bskyr/',
    auth = auth
  )
  expect_vector(embed, vector(mode = 'list'))
})
