#' Make a post on Bluesky Social
#'
#' @param text Text of post
#' @param images Character vector of paths to images to attach to post
#' @param images_alt Character vector of alt text for images. Must be same length as `images` if used.
#' @param video Character vector of path for up to one video to attach to post
#' @param video_alt Character vector, length one, of alt text for video, if used.
#' @param langs Character vector of languages in BCP-47 format
#' @param reply Character vector with link to the parent post to reply to
#' @param quote Character vector with link to a post to quote
#' @param embed Logical. Default is `TRUE`. Should a link card be embedded?
#' @param emoji Logical. Default is `TRUE`. Should `:emoji:` style references be converted?
#' @param max_tries `r template_var_max_tries()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#' @param clean `r template_var_clean()`
#'
#' @details
#' `:emoji:` parsing is not a formally supported Bluesky feature. This package
#' converts usages of this kind by identifying text within `:`s, here "`emoji`"
#' and then matches them to the `emoji` package's list of emoji names. All
#' supported emoji names and corresponding images can be seen with
#' `emoji::emoji_name`. This feature was introduced in `v0.2.0`.
#'
#'
#' @concept record
#'
#' @section Lexicon references:
#' [feed/post.json (2024-11-29)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
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
#'   reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g'
#' )
#' bs_post('Test quoting from r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
#'   quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
#' )
#' bs_post('Test quote and reply from r package `bskyr`
#' via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
#'   reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
#'   quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
#' )
#'
#' bs_post('Test quote with :emoji: and :fire: and :confetti_ball: from r package
#'   `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')
#'
#' bs_post(text = 'testing sending videos from R',
#'   video = fs::path_package('bskyr', 'man/figures/pkgs.mp4'),
#'   video_alt = 'a carousel of package logos, all hexagonal')
bs_post <- function(text, images, images_alt,
                    video, video_alt, langs, reply, quote,
                    embed = TRUE, emoji = TRUE, max_tries,
                    user = get_bluesky_user(), pass = get_bluesky_pass(),
                    auth = bs_auth(user, pass), clean = TRUE) {
  if (missing(text)) {
    cli::cli_abort('{.arg text} must not be missing.')
  }

  if (!missing(images)) {
    if (length(images) > 4) {
      cli::cli_abort('You can only attach up to 4 images to a post.')
    }

    if (missing(images_alt) && !is.list(images)) {
      cli::cli_abort('If {.arg images} is provided, {.arg images_alt} must also be provided.')
    }
  }

  if (!missing(video)) {
    if (length(video) > 1) {
      cli::cli_abort('You can only attach one video to a post.')
    }

    if (missing(video_alt)) {
      cli::cli_abort('If {.arg video} is provided, {.arg video_alt} must also be provided.')
    }
  }

  if (!missing(images) && !missing(video)) {
    cli::cli_abort('You can only attach images or a video to a post, not both.')
  }

  if (emoji) {
    text <- parse_emoji(text)
  }

  facets_l <- parse_facets(txt = text, auth = auth)

  if (!missing(images)) {
    if (is.data.frame(images)) {
      blob <- blob_tb_to_list(images)
    } else if (is.list(images)) { # any(fs::path_ext(images) == '')
      # then we assume it's a blob
      blob <- images
    } else {
      # otherwise it's a set of paths
      blob <- bs_upload_blob(images, auth = auth, clean = FALSE)
    }

    if (!missing(images_alt)) {
      if (length(blob) != length(images_alt)) {
        cli::cli_abort('{.arg images_alt} must be the same length as {.arg images}.')
      }
    }
  }

  if (!missing(video)) {
    if (is.list(video)) {
      # then we assume it's a blob
      blob <- video
    } else {
      # otherwise it's a path
      blob <- bs_upload_blob(video, auth = auth, clean = FALSE)
    }
  }

  if (stringi::stri_numbytes(text) > 300) {
    # warning because *sometimes* it works even if I think it's above the limit
    cli::cli_warn(c('{.arg text} evaluates to {} graphemes, which is above the limit (300).',
                    i = 'If positng fails, consider reducing the length of the text.'))
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
      img_incl <- lapply(seq_along(blob), function(i) {
        list(
          image = blob[[i]]$blob,
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

  if (!missing(video)) {
    post$embed <- list(
      '$type' = 'app.bsky.embed.video',
      video = blob[[1]]$blob
    )

    if (!missing(video_alt)) {
      post$embed$alt <- video_alt
    }
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

  # this should be auto calced unless the user wants to override
  if (is.null(post$embed) && !missing(embed)) {
    # then parse links
    # priorities
    # 1. list of embeds manually provided
    # 2. a tenor gif
    # 3. link card for the first link

    # 1. list of embeds manually provided
    if (is.list(embed)) {
      post$embed <- list(
        '$type' = 'app.bsky.embed.external',
        links = embed
      )
    } else {
      # 2. a tenor gif
      tenor_gif <- parse_tenor_gif(text)
      if (!is.null(tenor_gif)) {
        post$embed <- list(
          '$type' = 'app.bsky.embed.external',
          gif = tenor_gif
        )
      } else {
        # 3. link card for the first link
        link_card <- parse_first_link(text)
        if (!is.null(link_card)) {
          post$embed <- link_card
        }
      }
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

  if (!missing(max_tries) && max_tries > 1) {
    req <- req |>
      httr2::req_retry(
        max_tries = max_tries,
        is_transient = function(x) httr2::resp_status(x) >= 400
      )
  }

  #return(httr2::req_dry_run(req))

  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  if (!clean) {
    return(resp)
  }

  resp |>
    widen() |>
    clean_names() |>
    add_req_url(req)
}
