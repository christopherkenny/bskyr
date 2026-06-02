# Upload a video to be processed and stored

Upload a video to be processed and stored

## Usage

``` r
bs_upload_video(
  video,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass)
)
```

## Arguments

- video:

  Character, videos to upload to a repo.

- user:

  Character. User name to log in with. Defaults to
  [`get_bluesky_user()`](http://christophertkenny.com/bskyr/reference/user.md).

- pass:

  Character. App password to log in with. Defaults to
  [`get_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/pass.md).

- auth:

  Authentication information. Defaults to `bs_auth(user, pass)`.

## Value

a blob reference list, compatible with
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)

## Lexicon references

[video/uploadVideo.json
(2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/uploadVideo.json)
[video/getJobStatus.json
(2024-11-23)](https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/video/getJobStatus.json)

## Function introduced

`v0.5.0` (2026-06-01)

## Examples

``` r
if (FALSE) { # has_bluesky_pass() & has_bluesky_user()
vid <- fs::path_package('bskyr', 'man/figures/pkgs.mp4')
bs_upload_video(vid)
}
```
