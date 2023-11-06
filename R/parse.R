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
