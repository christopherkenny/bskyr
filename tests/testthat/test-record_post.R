#   test_that("`bs_post()` just text works", {
#     vcr::local_cassette('r_postT')
#     x <- bs_post(text = 'test post', auth = auth)
#     expect_s3_class(x, 'tbl_df')
#   })
