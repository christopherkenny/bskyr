#' Delete a list
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' lst <- bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
#' bs_delete_list(bs_extract_record_key(lst$uri))
bs_delete_list <- function(rkey,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.list',
    rkey = rkey,
    auth = auth
  )
}

#' Delete a list item
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/listitem.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/list.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-01)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' lst <- bs_new_list(name = 'test list bskyr', purpose = 'curatelist')
#' itm <- bs_new_list_item(subject = 'bskyr.bsky.social', uri = lst$uri)
#' bs_delete_list_item(bs_extract_record_key(itm$uri))
#' bs_delete_list(bs_extract_record_key(lst$uri))
bs_delete_list_item <- function(rkey,
                                user = get_bluesky_user(), pass = get_bluesky_pass(),
                                auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.listitem',
    rkey = rkey,
    auth = auth
  )
}

#' Delete a follow (un-follow someone)
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-03)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-03)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' foll <- bs_follow(subject = 'chriskenny.bsky.social')
#' bs_delete_follow(bs_extract_record_key(foll$uri))
#' # obviously, you deleted this by mistake and want to follow me
#' foll <- bs_follow(subject = 'chriskenny.bsky.social')
bs_delete_follow <- function(rkey,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.follow',
    rkey = rkey,
    auth = auth
  )
}

#' @rdname bs_delete_follow
#' @export
bs_unfollow <- bs_delete_follow

#' Delete a like (un-like something)
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-03)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-03)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' like <- bs_like(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
#' bs_delete_like(bs_extract_record_key(like$uri))
bs_delete_like <- function(rkey,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.feed.like',
    rkey = rkey,
    auth = auth
  )
}

#' @rdname bs_delete_like
#' @export
bs_unlike <- bs_delete_like

#' Delete a repost
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [feed/repost.json (2023-11-25)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/repost.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-03)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' repo <- bs_repost('https://bsky.app/profile/bskyr.bsky.social/post/3kf2577exva2x')
#' bs_delete_repost(bs_extract_record_key(repo$uri))
bs_delete_repost <- function(rkey,
                             user = get_bluesky_user(), pass = get_bluesky_pass(),
                             auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.feed.like',
    rkey = rkey,
    auth = auth
  )
}

#' Delete a block
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/list.json (2024-12-03)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/follow.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-03)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' blck <- bs_block(subject = 'nytimes.com')
#' bs_delete_block(bs_extract_record_key(blck$uri))
bs_delete_block <- function(rkey,
                            user = get_bluesky_user(), pass = get_bluesky_pass(),
                            auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.block',
    rkey = rkey,
    auth = auth
  )
}

#' @rdname bs_delete_block
#' @export
bs_unblock <- bs_delete_block

#' Delete a starter pack
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [graph/starterpack.json (2024-12-04)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/graph/starterpack.json)
#' [repo/deleteRecord.json (2024-12-01)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.2.0` (2024-12-04)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' starter <- bs_new_starter_pack('bskyr test')
#' bs_delete_starter_pack(bs_extract_record_key(starter$uri))
bs_delete_starter_pack <- function(rkey,
                                   user = get_bluesky_user(), pass = get_bluesky_pass(),
                                   auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.graph.block',
    rkey = rkey,
    auth = auth
  )
}

#' Delete a post
#'
#' @param rkey `r template_var_rkey()`
#' @param user `r template_var_user()`
#' @param pass `r template_var_pass()`
#' @param auth `r template_var_auth()`
#'
#' @concept repo
#'
#' @return an `httr2` status code
#' @export
#'
#' @section Lexicon references:
#' [feed/post.json (2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
#' [repo/deleteRecord.json (2025-03-20)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/deleteRecord.json)
#'
#' @section Function introduced:
#' `v0.3.0` (2025-03-20)
#'
#' @examplesIf has_bluesky_pass() && has_bluesky_user()
#' pst <- bs_post('a test post to be deleted')
#' bs_delete_post(bs_extract_record_key(pst$uri))
bs_delete_post <- function(rkey,
                           user = get_bluesky_user(), pass = get_bluesky_pass(),
                           auth = bs_auth(user, pass)) {
  bs_delete_record(
    collection = 'app.bsky.feed.post',
    rkey = rkey,
    auth = auth
  )
}
