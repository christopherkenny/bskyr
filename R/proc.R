# proc_profile <- function(l) {
#   tibble::tibble(
#    did             = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'did')),
#    handle          = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'handle')),
#    display_name    = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'displayName', .default = NA_character_)),
#    description     = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'description', .default = NA_character_)),
#    avatar          = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'avatar', .default = NA_character_)),
#    follow_count    = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'followsCount')),
#    followers_count = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'followersCount')),
#    posts_count     = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'postsCount')),
#    indexed_at      = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'indexedAt', .default = NA_character_)),
#    viewer_muted    = purrr::map_lgl(l$profiles, .f = function(x) purrr::pluck(x, 'viewer', 'muted')),
#    viewer_blocked  = purrr::map_lgl(l$profiles, .f = function(x) purrr::pluck(x, 'viewer', 'blockedBy')),
#    labels          = purrr::map(l$profiles, .f = function(x) purrr::pluck(x, labels))
#   )
# }
#
# spec <- list(
#   int = list(
#     'followsCount', 'followersCount', 'postsCount'
#   ),
#   chr = list(
#     'did', 'handle', 'displayName', 'description', 'avatar', 'indexedAt',
#     c('viewer', 'following'), c('viewer', 'followedBy')
#   ),
#   lgl = list(
#     c('viewer', 'muted'), c('viewer', 'blockedBy')
#   ),
#   lst = list(
#     'labels'
#   )
# )
#
#
# lt <- function(l, spec) {
#
# }
#
# lt_autospec <- function(l) {
#
# }

proc <- function(l) {
  lapply(l, function(z) unlist(z)) |>
    dplyr::bind_rows() |>
    clean_names()
}

proc_record <- function(l) {
  lapply(l, function(k) {
    tibble::tibble(
      text = k$text,
      embed = list(proc(k$embed)),
      langs = list(k$langs),
      facets = list(proc(k$facets)),
      createdAt = k$createdAt
    )
  })
}

proc_record2 <- function(l) {
  tibble::tibble(
    `$type` = purrr::pluck(l, '$type', .default = NA_character_),
    createdAt = purrr::pluck(l, 'createdAt', .default = NA_character_),
    langs = list(purrr::pluck(l, 'langs', .default = NULL)),
    embed = list(purrr::pluck(l, 'embed', .default = NULL)),
    facet = list(purrr::pluck(l, 'facet', .default = NULL)),
    text = purrr::pluck(l, 'text', .default = NA_character_),
  )
}

proc_embed2 <- function(l) {
  tibble::tibble(
    `$type` = purrr::map_chr(l, .f = function(x) purrr::pluck(x, '$type', .default = NA_character_)),
    media = purrr::map(l, .f = function(x) purrr::pluck(x, 'media', .default = NULL)),
    record = purrr::map(l, .f = function(x) purrr::pluck(x, 'record', .default = NULL))
  )
}

proc_embed <- function(l) {
  lapply(l, proc)
}

add_singletons <- function(tb, l) {
  r1 <- purrr::keep(l, function(x) purrr::pluck_depth(x) == 1)
  if (length(r1) > 0 && nrow(tb) != 0) {
    dplyr::bind_cols(tb, tibble::as_tibble_row(r1))
  } else {
    tb
  }
}

proc_posts <- function(l) {
  tibble::tibble(
    uri = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'uri', .default = NA_character_)),
    cid = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'cid', .default = NA_character_)),
    author = purrr::map(l, .f = function(x) purrr::pluck(x, 'author', .default = NULL) |> widen()),
    record = purrr::map(l, .f = function(x) purrr::pluck(x, 'record', .default = NULL) |> proc_record2()),
    embed = purrr::map(l, .f = function(x) purrr::pluck(x, 'embed', .default = NULL) |> proc_embed2()),
    replyCount = purrr::map_int(l, .f = function(x) purrr::pluck(x, 'replyCount', .default = NA_integer_)),
    repostCount = purrr::map_int(l, .f = function(x) purrr::pluck(x, 'repostCount', .default = NA_integer_)),
    likeCount = purrr::map_int(l, .f = function(x) purrr::pluck(x, 'likeCount', .default = NA_integer_)),
    quoteCount = purrr::map_int(l, .f = function(x) purrr::pluck(x, 'quoteCount', .default = NA_integer_)),
    indexedAt = purrr::map_chr(l, .f = function(x) purrr::pluck(x, 'indexedAt', .default = NA_character_)),
    viewer = purrr::map(l, .f = function(x) purrr::pluck(x, 'viewer', .default = NULL) |> widen()),
    labels = purrr::map(l, .f = function(x) purrr::pluck(x, 'labels', .default = NULL) |> widen())
  ) |>
    tidyr::unnest_wider('author', names_sep = '_') |>
    tidyr::unnest_wider('viewer') |>
    clean_names()
}

proc_post <- function(l) {
  tibble::tibble(
    uri = purrr::pluck(l, 'uri', .default = NA_character_),
    cid = purrr::pluck(l, 'cid', .default = NA_character_),
    author = purrr::pluck(l, 'author', .default = NULL) |> widen(),
    record = list(purrr::pluck(l, 'record', .default = NULL) |> proc_record2()),
    embed = list(purrr::pluck(l, 'embed', .default = NULL) |> proc_embed2()),
    replyCount = purrr::pluck(l, 'replyCount', .default = NA_integer_),
    repostCount = purrr::pluck(l, 'repostCount', .default = NA_integer_),
    likeCount = purrr::pluck(l, 'likeCount', .default = NA_integer_),
    quoteCount = purrr::pluck(l, 'quoteCount', .default = NA_integer_),
    indexedAt = purrr::pluck(l, 'indexedAt', .default = NA_character_),
    viewer = purrr::pluck(l, 'viewer', .default = NULL) |> widen(),
    labels = list(purrr::pluck(l, 'labels', .default = NULL) |> widen())
  ) |>
    tidyr::unnest_wider('author', names_sep = '_') |>
    tidyr::unnest_wider('viewer') |>
    clean_names()
}
