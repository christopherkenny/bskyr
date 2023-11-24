parse_mentions <- function(txt) {
  # regex based on: https://atproto.com/specs/handle#handle-identifier-syntax
  mention_regex <- '[$|\\W](@([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)'

  # drop_n = whitespace + @
  parse_regex(txt, regex = mention_regex, drop_n = 2L)
}

parse_urls <- function(txt) {
  # regex base on: https://atproto.com/blog/create-post
  url_regex <- '[$|\\W](https?://(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*[-a-zA-Z0-9@%_\\+~#//=])?)'

  # drop_n = whitespace
  parse_regex(txt, regex = url_regex, drop_n = 1L)
}

parse_regex <- function(txt, regex, drop_n = 0L) {
  matches <- stringr::str_locate_all(txt, regex)
  txt_cum_wts <- weight_by_bytes(txt)

  lapply(seq_along(matches), function(m) {
    lapply(seq_len(nrow(matches[[m]])), function(r) {
      list(
        start = txt_cum_wts[[m]][unname(matches[[m]][r, 1, drop = TRUE])],
        end = txt_cum_wts[[m]][unname(matches[[m]][r, 2, drop = TRUE])],
        text = stringr::str_sub(
          string = txt[[m]],
          start = matches[[m]][r, 1, drop = TRUE] + drop_n,
          end = matches[[m]][r, 2, drop = TRUE]
        )
      )
    })
  })
}

weight_by_bytes <- function(txt) {
  txt |>
    stringr::str_split(pattern = '') |>
    lapply(function(x) {
      x |>
        stringi::stri_numbytes() |>
        cumsum()
    })
}
