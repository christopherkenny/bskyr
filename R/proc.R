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
  lapply(l, function(z) unlist(z)) |> dplyr::bind_rows() |> clean_names()
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

proc_embed <- function(l) {
  lapply(l, proc)
}

add_singletons <- function(tb, l) {
  r1 <- purrr::keep(l, \(x) purrr::pluck_depth(x) == 1)
  if (length(r1) > 0 && nrow(tb) != 0) {
    dplyr::bind_cols(tb, tibble::as_tibble_row(r1))
  } else {
    tb
  }
}
