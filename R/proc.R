proc_profile <- function(l) {
  tibble::tibble(
   did             = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'did')),
   handle          = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'handle')),
   display_name    = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'displayName')),
   description     = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'description')),
   avatar          = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'avatar')),
   follow_count    = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'followsCount')),
   followers_count = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'followersCount')),
   posts_count     = purrr::map_int(l$profiles, .f = function(x) purrr::pluck(x, 'postsCount')),
   indexed_at      = purrr::map_chr(l$profiles, .f = function(x) purrr::pluck(x, 'indexedAt')),
   viewer_muted    = purrr::map_lgl(l$profiles, .f = function(x) purrr::pluck(x, 'viewer', 'muted')),
   viewer_blocked  = purrr::map_lgl(l$profiles, .f = function(x) purrr::pluck(x, 'viewer', 'blockedBy')),
   labels          = purrr::map(l$profiles, .f = function(x) purrr::pluck(x, labels))
  )
}
