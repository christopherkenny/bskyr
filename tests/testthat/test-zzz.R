test_that('auth cache is cleaned up after tests', {
  p <- tools::R_user_dir('bskyr', 'config') |>
    fs::path('bs_auth.rds')

  if (fs::file_exists(p)) {
    fs::file_delete(p)
  }

  expect_false(fs::file_exists(p))
})
