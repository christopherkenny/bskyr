with_mock_dir('t/g/rel', {
  test_that('`bs_get_relationships()` works', {
    x <- bs_get_relationships('did:plc:wpe35pganb6d4pg4ekmfy6u5', 'did:plc:5c2r73erhng4bszmxlfdtscf', auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
