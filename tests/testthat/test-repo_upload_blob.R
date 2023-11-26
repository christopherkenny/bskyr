# with_mock_dir("t/r/uploadBlob", {
#   test_that("`bs_upload_blob()` works", {
#     fig <- fs::path_package('bskyr', 'man/figures/logo.png')
#     x <- bs_upload_blob(blob = fig, auth = auth)
#     expect_s3_class(x, 'tbl_df')
#     # x <- bs_upload_blob(blob = fig, auth = auth, clean = FALSE)
#     # expect_equal(class(x), 'list')
#   })
# })

