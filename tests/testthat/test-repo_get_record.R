with_mock_dir("t/r/getRecord", {
  test_that("`bs_get_record()` works", {
    x <- bs_get_record(repo = 'did:plc:ic6zqvuw5ulmfpjiwnhsr2ns',
                       collection = 'app.bsky.feed.post',
                       rkey = '3k7qmjev5lr2s',
                       auth = auth)
    expect_s3_class(x, 'tbl_df')
  })
})
