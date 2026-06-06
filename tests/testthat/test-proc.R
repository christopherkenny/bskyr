test_that('`widen()` returns correctly named tibble', {
  result <- widen(list(
    displayName = 'A User',
    indexedAt = '2024-01-01',
    postsCount = 10L
  ))
  expect_named(result, c('display_name', 'indexed_at', 'posts_count'))
})

test_that('`widen_field()` respects depth limit', {
  viewer <- list(muted = FALSE, blockedBy = FALSE)
  expect_named(
    widen_field('viewer', viewer, 4L),
    c('viewer_muted', 'viewer_blockedBy')
  )
  expect_named(widen_field('viewer', viewer, 3L), 'viewer')
})

test_that('`blob_tb_to_list()` produces expected blob structure', {
  tb <- tibble::tibble(
    `$type` = 'blob',
    `ref_$link` = 'bafy123',
    mime_type = 'image/png',
    size = 1024L
  )
  result <- blob_tb_to_list(tb)
  expect_equal(result[[1]]$blob$`$type`, 'blob')
  expect_equal(result[[1]]$blob$ref$`$link`, 'bafy123')
  expect_equal(result[[1]]$blob$mimeType, 'image/png')
  expect_equal(result[[1]]$blob$size, 1024L)
})
