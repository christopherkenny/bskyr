#' Embed external media in a post
#'
#' Embeds are not designed as standalone records, but rather as part of a post.
#' This will create a list representation of an external embed.
#'
#' @param uri a link to embed
#' @param title the title for the link
#' @param description a description of the link
#' @param thumb Optional. A thumbnail for the link
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept embed
#'
#' @section Lexicon references:
#' [embed/external.json (2024-12-05)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/embed/external.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-05)
#'
#' @return a list representation of an external embed
#' @export
#'
#' @examplesIf has_bluesky_pass() & has_bluesky_user()
#' bs_new_embed_external(
#'   uri = 'https://christophertkenny.com/bskyr/',
#'   title = 'Interact with Bluesky Social',
#'   description = 'An R package for using Bluesky Social'
#' )
bs_new_embed_external <- function(uri, title, description, thumb,
                                  user = get_bluesky_user(), pass = get_bluesky_pass(),
                                  auth = bs_auth(user, pass)) {

  if (missing(uri)) {
    cli::cli_abort('{.arg uri} must not be missing.')
  }

  details <- opengraph::og_parse(uri)

  if (missing(title)) {
    if (!is.na(details[['title']])) {
      title <- details[['title']]
    } else {
      title <- ''
    }
  }

  if (missing(description)) {
    if (!is.na(details[['description']])) {
      description <- details[['description']]
      if (is.na(description)) {
        description <- title
      }
    }
  }

  if (missing(thumb)) {
    if (!is.na(details[['image']])) {
      user_did <- auth$did

      if (fs::is_link(details[['image']])) {
        ext <- fs::path_ext(details[['image']])
        tfd <- fs::file_temp(fileext = ext)
        download.file(details[['image']], tfd)
        details[['image']] <- tfd
      }
      thumb_url <- bs_upload_blob(details[['image']], auth = auth)

      thumb <- paste0('https://cdn.bsky.app/img/feed_thumbnail/plain/', user_did, '/', thumb_url[['ref_$link']])
    } else {
      thumb <- NULL
    }
  }


  rec <- list(
    `$type` = 'app.bsky.embed.external',
    external = list(
      uri = uri,
      title = title,
      description = description
    )
  )

  if (!is.null(thumb)) {
    rec$external$thumb <- thumb
  }

  rec
}
