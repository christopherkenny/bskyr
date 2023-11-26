#' Make a post on Bluesky Social
#'
#' Note: This function currently only supports text posts. Further support
#' planned for version 0.1.0
#'
#' @param text text of post
#' @param images character vector of paths to images to attach to post
#' @param images_alt character vector of alt text for images. Must be same length as `images` if used.
#' @param langs character vector of languages in BCP-47 format
#' @param reply character vector with link to the parent post to reply to
#' @param quote character vector with link to a post to quote
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @concept record
#'
#' @section Lexicon references:
#' [feed/post.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
#' [repo/createRecord.json (2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)
#'
#' @section Function introduced:
#' `v0.0.1` (2023-10-02)
#'
#' @return a [tibble::tibble] of post information
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_post('Test post from R CMD Check for r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')
#' bs_post('Test self-reply from r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
#'         reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g')
#' bs_post('Test quoting from r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
#'         quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a')
#' bs_post('Test quote and reply from r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
#'         reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
#'         quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a')
bs_post <- function(text, images, images_alt, langs, reply, quote,
                    user = get_bluesky_user(), pass = get_bluesky_pass(),
                    auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(text)) {
    cli::cli_abort('{.arg text} must not be missing.')
  }

  if (!missing(images)) {
    if (length(images) > 4) {
      cli::cli_abort('You can only attach up to 4 images to a post.')
    }
  }

  facets_l <- parse_facets(txt = text, auth = auth)

  if (!missing(images)) {
    if (is.list(images)) { #any(fs::path_ext(images) == '')
      # then we assume it's a blob
      blob <- images
    } else {
      # otherwise it's a set of paths
      blob <- bs_upload_blob(images, auth = auth, clean = FALSE)
      if (length(blob) == 1) {
        blob <- blob[[1]]
      }
    }
  }

  if (!missing(images_alt)) {
    if (length(blob) != length(images_alt)) {
      cli::cli_abort('{.arg images_alt} must be the same length as {.arg images}.')
    }
  }

  post <- list(
    `$type` = 'app.bsky.feed.post',
    text = text,
    createdAt = bs_created_at()
  )

  if (!missing(langs)) {
    post$langs <- as.list(langs)
  }

  if (!purrr::is_empty(facets_l)) {
    post$facets <- facets_l[[1]]
  }

  if (!missing(images)) {
    if (!missing(images_alt)) {
      img_incl <- lapply(seq_along(images), function(i) {
        list(
          image  = blob[[i]]$blob,
          alt = images_alt[[i]]
        )
      })
    } else {
      img_incl <- lapply(blob, function(x) {
        list(
          image = x$blob
        )
      })
    }

    post$embed <- list(
      '$type' = 'app.bsky.embed.images',
      images = img_incl
    )
  }

  if (!missing(reply)) {
    post$reply <- get_reply_refs(reply, auth = auth)
  }

  if (!missing(quote)) {
    quote_rcd <- bs_get_record(quote, auth = auth, clean = FALSE)
    quote_inc <- list(
      '$type' = 'app.bsky.embed.record',
      record = list(
        uri = quote_rcd$uri,
        cid = quote_rcd$cid
      )
    )

    if (!is.null(post$embed)) {
      post$embed <- append(post$embed, quote_inc)
    } else {
      post$embed <- quote_inc
    }
  }

  req <- httr2::request('https://bsky.social/xrpc/com.atproto.repo.createRecord') |>
    httr2::req_auth_bearer_token(token = auth$accessJwt) |>
    httr2::req_body_json(
      data = list(
        repo = auth$did,
        collection = 'app.bsky.feed.post',
        record = post
      )
    )

  #return(httr2::req_dry_run(req))

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) return(resp)

  resp |>
    dplyr::bind_rows() |>
    clean_names()
}
