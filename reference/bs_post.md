# Make a post on Bluesky Social

Make a post on Bluesky Social

## Usage

``` r
bs_post(
  text,
  images,
  images_alt,
  video,
  video_alt,
  langs,
  reply,
  quote,
  embed = TRUE,
  emoji = TRUE,
  max_tries,
  created_at = bs_created_at(),
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
```

## Arguments

- text:

  Text of post

- images:

  Character vector of paths to images to attach to post

- images_alt:

  Character vector of alt text for images. Must be same length as
  `images` if used.

- video:

  Character vector of path for up to one video to attach to post

- video_alt:

  Character vector, length one, of alt text for video, if used.

- langs:

  Character vector of languages in BCP-47 format

- reply:

  Character vector with link to the parent post to reply to

- quote:

  Character vector with link to a post to quote

- embed:

  Logical. Default is `TRUE`. Should a link card be embedded?

- emoji:

  Logical. Default is `TRUE`. Should `:emoji:` style references be
  converted?

- max_tries:

  Integer, \>= 2. Number of times to retry the request if the first
  fails.

- created_at:

  Character, length 1 of the form "%Y-%m-%dT%H:%M:%OS6Z". Time to assign
  to a record. Default is
  [`bs_created_at()`](http://christophertkenny.com/bskyr/reference/bs_created_at.md).

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

- clean:

  Logical. Should output be cleaned into a `tibble`? Default: `TRUE`.

## Value

a [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
of post information

## Emoji parsing

`:emoji:` parsing is not a formally supported Bluesky feature. This
package converts usages of this kind by identifying text within `:`s,
here "`emoji`" and then matches them to the `emoji` package's list of
emoji names. All supported emoji names and corresponding images can be
seen with
[`emoji::emoji_name`](https://emilhvitfeldt.github.io/emoji/reference/emoji_name.html).
This feature was introduced in `v0.2.0`.

## Embedding

Embedding is a feature that allows for a link card to be created when a
URL or other media to be added as a preview to the post. This feature
was introduced in `v0.2.0`.

Embeds are processed as follows:

1.  If `is.list(embed)`, it is assumed to be an embed object. These
    should be created with
    [`bs_new_embed_external()`](http://christophertkenny.com/bskyr/reference/bs_new_embed_external.md),
    unless you are certain of the structure.

2.  If `is.character(embed)`, it is assumed to be a URL. The function
    will use the open graph protocol to try to infer the embed from the
    URL.

3.  If `isTRUE(embed)`, the *default*, it tries to infer the embed from
    the text.

4.  First, if a Tenor Gif link is found in the text, it will be
    embedded.

5.  Second, if a URL is found in the text, it will be embedded. Only the
    first URL found will be embedded.

6.  If `isFALSE(embed)` or it does match an earlier condidtion, no embed
    is created and the post is sent as is.

## Lexicon references

[feed/post.json
(2024-11-29)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/post.json)
[repo/createRecord.json
(2023-10-02)](https://github.com/bluesky-social/atproto/blob/main/lexicons/com/atproto/repo/createRecord.json)

## Function introduced

`v0.0.1` (2023-10-02)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
bs_post('Test post from R CMD Check for r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')
bs_post('Test self-reply from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g'
)
bs_post('Test quoting from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
)
bs_post('Test quote and reply from r package `bskyr`
via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3kexwuoyqj32g',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3kf24wd6cmb2a'
)

bs_post('Test quote with :emoji: and :fire: and :confetti_ball: from r package
  `bskyr` via @bskyr.bsky.social (https://christophertkenny.com/bskyr/)')

bs_post(
  text = 'Testing images and aspect ratios from R',
  images = fs::path_package('bskyr', 'man/figures/logo.png'),
  images_alt = 'hexagonal logo of the R package bskyr, with the text "bskyr" on a cloud'
)

bs_post(
  text = 'testing sending videos from R',
  video = fs::path_package('bskyr', 'man/figures/pkgs.mp4'),
  video_alt = 'a carousel of package logos, all hexagonal'
)
}
```
