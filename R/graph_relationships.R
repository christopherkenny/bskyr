#' Get relationships between an account and other users
#'
#' @param actor `r template_var_actor()`
#' @param others Optional, character vector of other users to look up relationships
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept graph
#'
#' @return a [tibble::tibble] of relationships
#' @export
#'
#' @section Lexicon references:
#' [graph/getRelationships.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/getRelationships.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' bs_get_relationships('chriskenny.bsky.social', 'bskyr.bsky.social')
bs_get_relationships <- function(actor, others,
                                 user = get_bluesky_user(), pass = get_bluesky_pass(),
                                 auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(actor)) {
    cli::cli_abort('{.arg actor} must list at least one user.')
  }
  if (length(actor) != 1) {
    cli::cli_abort('{.arg actor} must be a single user.')
  }

  actor_input <- actor

  if (!is_user_did(actor)) {
    actor <- bs_resolve_handle(actor, auth = auth)$did
  }

  if (missing(others)) {
    others <- list(NULL)
    others_input <- NULL
  } else {
    others_input <- others
    others <- purrr::map_chr(
      others,
      function(x) {
        if (!is_user_did(x)) {
          bs_resolve_handle(x, auth = auth)$did
        } else {
          x
        }
      }
    )

    others <- others |>
      split(ceiling(seq_along(others) / 30))
  }


  req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getRelationships') |>
    httr2::req_url_query(
      actor = actor
    ) |>
    httr2::req_auth_bearer_token(token = auth$accessJwt)

  resp <- lapply(
    others,
    function(x) {
      req <- httr2::request('https://bsky.social/xrpc/app.bsky.graph.getRelationships') |>
        httr2::req_url_query(
          actor = actor
        )

      others <- x |>
        as.list() |>
        purrr::set_names('others')
      req <- rlang::inject(httr2::req_url_query(req, !!!others))

      req <- req |>
        httr2::req_auth_bearer_token(token = auth$accessJwt)

      req |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }
  ) |>
    unname()

  if (!clean) {
    return(resp)
  }

  out <- resp |>
    lapply(function(x) {
      dplyr::bind_cols(
        tibble::tibble(actor = x$actor),
        x$relationships |> list_hoist()
      )
    }) |>
    purrr::list_rbind() |>
    clean_names() |>
    add_req_url(req)

  if (!stringr::str_detect(actor_input, '^did:')) {
    out <- out |>
      dplyr::mutate(
        actor_input = actor_input,
        .after = 'actor'
      )
  }

  if (!is.null(others_input) && any(!stringr::str_detect(others_input, '^did:'))) {
    out <- out |>
      dplyr::mutate(
        others_input = others_input
      )
  }

  out
}
