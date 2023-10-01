function(resp) {
  resp |>
    httptest2::gsub_response(pattern = bskyr::bs_get_pass(), '')
}
