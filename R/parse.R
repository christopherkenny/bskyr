# regex based on: https://atproto.com/specs/handle#handle-identifier-syntax
mention_regex <- '[$|\\W](@([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)'
# regex base on: https://atproto.com/blog/create-post
url_regex <- '[$|\\W](https?://(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*[-a-zA-Z0-9@%_\\+~#//=])?)'
# regex taken from: https://github.com/bluesky-social/atproto/blob/main/packages/api/src/rich-text/util.ts
tag_regex <- '(^|\\s)[#\\uFF03](?<tag>(?!\\ufe0f)[^\\s\\u00AD\\u2060\\u200A\\u200B\\u200C\\u200D\\u20e2]*[^\\d\\s\\p{P}\\u00AD\\u2060\\u200A\\u200B\\u200C\\u200D\\u20e2]+[^\\s\\u00AD\\u2060\\u200A\\u200B\\u200C\\u200D\\u20e2]*)?'

parse_mentions <- function(txt) {
  # drop_n = whitespace + @
  parse_regex(txt, regex = mention_regex, drop_n = 2L)
}

parse_urls <- function(txt) {
  # drop_n = whitespace
  parse_regex(txt, regex = url_regex, drop_n = 1L)
}

parse_tags <- function(txt) {
  matches <- stringi::stri_locate_all_regex(txt, tag_regex, capture_groups = TRUE, get_length = TRUE, omit_no_match = TRUE)
  lapply(seq_along(matches), function(m) {
    tags <- attr(matches[[m]], 'capture_groups')$tag
    lapply(seq_len(nrow(tags)), function(r) {
      # did not find tag
      if (tags[r, 'length', drop = TRUE] < 0) {
        return(list())
      }

      start_idx <- unname(tags[r, 'start', drop = TRUE])
      text <- stringr::str_sub(
        txt[[m]],
        start = start_idx,
        end = start_idx + tags[r, 'length', drop = TRUE]
      )
      # strip ending punctuation and any spaces
      punct_space_unicode_set <- '[\\p{P}\\p{Z}\\n\\u00AD\\u2060\\u200A\\u200B\\u200C\\u200D\\u20e2]'
      stripped_text <- stringi::stri_trim_right(text, punct_space_unicode_set, negate = TRUE)
      text_length <- stringi::stri_numbytes(stripped_text)

      if (text_length > 64) {
        return(list())
      }

      numbytes_start <- stringi::stri_numbytes(stringr::str_sub(txt,
        start = 1L,
        end = start_idx - 1
      ))
      numbytes_hashtag <- stringi::stri_numbytes(stringr::str_sub(txt,
        start = start_idx - 1,
        end = start_idx - 1
      ))

      list(
        start = numbytes_start - numbytes_hashtag,
        end = numbytes_start + text_length,
        text = stringr::str_sub(stripped_text, start = 1L)
      )
    })
  })
}

parse_regex <- function(txt, regex, drop_n = 0L) {
  matches <- stringr::str_locate_all(txt, regex)
  txt_cum_wts <- weight_by_bytes(txt)

  lapply(seq_along(matches), function(m) {
    lapply(seq_len(nrow(matches[[m]])), function(r) {
      list(
        start = txt_cum_wts[[m]][unname(matches[[m]][r, 1, drop = TRUE])],
        end = txt_cum_wts[[m]][unname(matches[[m]][r, 2, drop = TRUE])],
        text = stringr::str_sub(
          string = txt[[m]],
          start = matches[[m]][r, 1, drop = TRUE] + drop_n,
          end = matches[[m]][r, 2, drop = TRUE]
        )
      )
    })
  })
}

weight_by_bytes <- function(txt) {
  txt |>
    stringr::str_split(pattern = '') |>
    lapply(function(x) {
      x |>
        stringi::stri_numbytes() |>
        cumsum()
    })
}


parse_facets <- function(txt, auth) {
  mens <- parse_mentions(txt)
  urls <- parse_urls(txt)
  tags <- parse_tags(txt)

  mens_ok <- lapply(mens, function(m_l) {
    lapply(m_l, function(m) {
      bs_resolve_handle(m$text, auth = auth, clean = FALSE)
    })
  })

  facet_mens <- lapply(seq_along(mens), function(i) {
    lapply(seq_along(mens[[i]]), function(j) {
      if (is.na(mens_ok[[i]][[j]]$did)) {
        return(NULL)
      }
      list(
        index = list(
          byteStart = mens[[i]][[j]]$start,
          byteEnd = mens[[i]][[j]]$end
        ),
        features = list(list(
          '$type' = 'app.bsky.richtext.facet#mention',
          did = mens_ok[[i]][[j]]$did
        ))
      )
    })
  })

  facet_urls <- lapply(seq_along(urls), function(i) {
    lapply(seq_along(urls[[i]]), function(j) {
      list(
        index = list(
          byteStart = urls[[i]][[j]]$start,
          byteEnd = urls[[i]][[j]]$end
        ),
        features = list(list(
          '$type' = 'app.bsky.richtext.facet#link',
          uri = urls[[i]][[j]]$text
        ))
      )
    })
  })

  facet_tags <- lapply(seq_along(tags), function(i) {
    lapply(seq_along(tags[[i]]), function(j) {
      list(
        index = list(
          byteStart = tags[[i]][[j]]$start,
          byteEnd = tags[[i]][[j]]$end
        ),
        features = list(list(
          '$type' = 'app.bsky.richtext.facet#tag',
          tag = tags[[i]][[j]]$text
        ))
      )
    })
  })

  lapply(seq_along(mens), function(i) {
    out <- c(
      facet_mens[[i]],
      facet_urls[[i]],
      facet_tags[[i]]
    ) |>
      purrr::discard(is.null) |>
      purrr::discard(purrr::is_empty)
    if (purrr::is_empty(out)) {
      return(NULL)
    }
    out
  })
}

parse_uri <- function(uri) {
  if (length(uri) > 1) {
    uri <- uri[[1]]
    cli::cli_warn('Only the first URI will be parsed.')
  }
  spl <- stringr::str_split(uri, '/')[[1]]
  if (stringr::str_starts(uri, 'at://')) {
    repo <- spl[3]
    collection <- spl[4]
    rkey <- spl[5]
  } else if (stringr::str_starts(uri, 'https://')) {
    repo <- spl[5]
    collection <- spl[6]
    rkey <- spl[7]
    collection <- dplyr::case_when(
      collection == 'post' ~ 'app.bsky.feed.post',
      collection == 'lists' ~ 'app.bsky.graph.list',
      collection == 'feed' ~ 'app.bsky.feed.generator',
      TRUE ~ collection
    )
  } else {
    cli::cli_abort('URI must start with "at://" or "https://".')
  }
  list(
    repo = repo,
    collection = collection,
    rkey = rkey
  )
}

parse_emoji <- function(txt) {
  emoji_regex <- ':[a-zA-Z0-9_]+:' #' (?<=:)[^:\\s]+(?=:)'

  stringr::str_replace_all(txt, emoji_regex, replace_emoji)
}

parse_tenor_gif <- function(txt) {
  # extract gif from tenor like: https://tenor.com/view/this-is-fine-gif-24177057
  tenor_regex <- 'https://tenor.com/view/[^\\s]+'
  tenor_urls <- stringr::str_extract(txt, tenor_regex)

  # get the opengraph content+
  if (length(tenor_urls) == 0 || is.na(tenor_urls)) {
    return(NULL)
  }

  url <- tenor_urls[[1]]

  og <- opengraph::og_parse(url)

  if (!'site_name' %in% names(og)) {
    return(NULL)
  }
  if (og[['site_name']] != 'Tenor') {
    return(NULL)
  }

  # get image link
  # get image:width
  # get image:height
  # create new url, e.g. 'https://media.tenor.com/MYZgsN2TDJAAAAAC/this-is.gif?hh=280&ww=498'
  out_url <- paste0(
    og[['image']],
    '?hh=', og[['image:height']],
    '&ww=', og[['image:width']]
  ) |>
    stringr::str_replace('media1.tenor.com', 'media.tenor.com') |>
    stringr::str_replace('/m/', '/')

  # download the gif
  ext <- fs::path_ext(og[['image']])
  tfd <- fs::file_temp(ext = ext)
  curl::curl_download(og[['image']], tfd)

  # convert first frame to png as the thumbnail
  thumb <- fs::file_temp(ext = '.png')
  magick::image_read(tfd) |>
    magick::image_convert(format = 'png') |>
    magick::image_write(thumb)

  bs_new_embed_external(
    uri = out_url,
    title = og[['title']],
    description = og[['title']],
    thumb = thumb
  )
}

parse_first_link <- function(txt) {
  urls <- parse_urls(txt)[[1]]
  if (length(urls) == 0) {
    return(NULL)
  }
  bs_new_embed_external(urls[[1]]$text)
}
