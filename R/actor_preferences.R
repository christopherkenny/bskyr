#' Get (Self) Preferences
#'
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept actor
#'
#' @return a tibble of preferences
#' @export
#'
#' @section Lexicon references:
#' [actor/getPreferences.json (2023-10-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getPreferences.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_preferences()
bs_get_preferences <- function(user = get_bluesky_user(), pass = get_bluesky_pass(),
                               auth = bs_auth(user, pass)) {

  req <- httr2::request('https://bsky.social/xrpc/app.bsky.actor.getPreferences') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  dplyr::bind_cols(
    resp$preferences[[1]] |> unlist() |> clean_names() |> tibble::as_tibble_row(),
    resp$preferences[[2]] |>
      lapply(unlist) |>
      lapply(function(x) if (length(x) > 1) list(x) else x) |>
      tibble::as_tibble() |>
      dplyr::rename('$type2' = '$type'),
  )
}
