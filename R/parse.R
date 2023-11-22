#
# #txt <- '\u2728 example mentioning @atproto.com to share the URL \ud83d\udc68\u200d\u2764\ufe0f\u200d\ud83d\udc68 https://en.wikipedia.org/wiki/CBOR.
# parse_mentions <- function(txt) {
#
#   # regex adapted from https://github.com/bluesky-social/atproto-website/blob/main/examples/create_bsky_post.py
#   locs <- stringr::str_locate_all(
#     string = txt,
#     pattern = '[$|\\W](@([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)'
#   )
#
#   lapply(locs, function(x) str_sub(txt, locs[[1]][, 1] + 1, locs[[1]][, 2]))
# }
#

# library(stringr)
#
# parse_mentions <- function(text) {
#   spans <- list()
#   # regex based on: https://atproto.com/specs/handle#handle-identifier-syntax
#   mention_regex <- "[$|\\W](@([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)"
#   matches <- str_locate_all(text, mention_regex)
#
#   for (m in matches[[1]]) {
#     spans <- append(spans, list(
#       start = m[1,],
#       end = m[2,],
#       handle = str_sub(m[2,], 2)
#     ))
#   }
#   spans
# }
#
# # Example usage
# text <- 'Check out this @example.com and also $mention@sample.xyz'
# parse_mentions(text)

