# Changelog

## bskyr 0.4.0

CRAN release: 2025-10-25

- Fixes an issue where OpenGraph links with a size hint would fail
  downloading.
  ([\#32](https://github.com/christopherkenny/bskyr/issues/32))
- Improves transformations of starter packs into tibbles with cleaner
  unnesting.
  ([\#31](https://github.com/christopherkenny/bskyr/issues/31))
- Allows for more than 25 actors in
  [`bs_get_profile()`](http://christophertkenny.com/bskyr/reference/bs_get_profile.md),
  ([\#29](https://github.com/christopherkenny/bskyr/issues/29),
  [\#30](https://github.com/christopherkenny/bskyr/issues/30)).
- No longer overly widens results in
  [`bs_get_profile()`](http://christophertkenny.com/bskyr/reference/bs_get_profile.md).
  ([\#42](https://github.com/christopherkenny/bskyr/issues/42))
- Improves
  [`bs_get_likes()`](http://christophertkenny.com/bskyr/reference/bs_get_likes.md)
  processing and makes it clear it is self-only.
- Adds 3 vignettes.
  ([\#12](https://github.com/christopherkenny/bskyr/issues/12))
  - “Creating Records on Bluesky Social”
  - “Gathering Data from Bluesky Social”
  - “Working with Lists and Starter Packs”
- Adds support for direct messages or conversations (aka “convos”).
  - [`bs_list_convos()`](http://christophertkenny.com/bskyr/reference/bs_list_convos.md)
    lists all conversations
  - [`bs_get_messages()`](http://christophertkenny.com/bskyr/reference/bs_get_messages.md)
    retrieves messages from a conversation
  - [`bs_get_convo()`](http://christophertkenny.com/bskyr/reference/bs_get_convo.md)
    retrieves details on a conversation  
  - [`bs_get_convo_log()`](http://christophertkenny.com/bskyr/reference/bs_get_convo_log.md)
    retrieves the log on all conversations
  - [`bs_update_read()`](http://christophertkenny.com/bskyr/reference/bs_update_read.md)
    sets a conversation to read
  - [`bs_update_all_read()`](http://christophertkenny.com/bskyr/reference/bs_update_all_read.md)
    sets all conversations to read
  - [`bs_accept_convo()`](http://christophertkenny.com/bskyr/reference/bs_accept_convo.md)
    accepts a conversation
  - [`bs_add_reaction()`](http://christophertkenny.com/bskyr/reference/bs_add_reaction.md)
    adds a reaction to a message
  - [`bs_remove_reaction()`](http://christophertkenny.com/bskyr/reference/bs_remove_reaction.md)
    removes a reaction to a message
  - [`bs_mute_convo()`](http://christophertkenny.com/bskyr/reference/bs_mute_convo.md)
    mutes a conversation
  - [`bs_unmute_convo()`](http://christophertkenny.com/bskyr/reference/bs_unmute_convo.md)
    unmutes a conversation
  - [`bs_send_message()`](http://christophertkenny.com/bskyr/reference/bs_send_message.md)
    sends a message to a conversation
  - [`bs_delete_message_for_self()`](http://christophertkenny.com/bskyr/reference/bs_delete_message_for_self.md)
    hides a message for you
  - [`bs_leave_convo()`](http://christophertkenny.com/bskyr/reference/bs_leave_convo.md)
    leaves a conversation
  - [`bs_get_convo_availability()`](http://christophertkenny.com/bskyr/reference/bs_get_convo_availability.md)
    retrieves info on if you can chat with another actor
  - [`bs_send_message_batch()`](http://christophertkenny.com/bskyr/reference/bs_send_message_batch.md)
    sends a batch of messages to different conversations
- Fixes an issue where actual numbers with a \# sign would cause
  failures in posting
  ([\#45](https://github.com/christopherkenny/bskyr/issues/45)).
- Avoids creating raw version of files for upload where possible
  ([\#16](https://github.com/christopherkenny/bskyr/issues/16)).
- Always returns `embed` for
  [`bs_get_posts()`](http://christophertkenny.com/bskyr/reference/bs_get_posts.md)
  ([\#40](https://github.com/christopherkenny/bskyr/issues/40),
  [\#41](https://github.com/christopherkenny/bskyr/issues/41)).
- Include all returned information in
  [`bs_get_author_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_author_feed.md).
  Note that this requires adding a prefix to `reply` and `reason`
  information.
  ([\#43](https://github.com/christopherkenny/bskyr/issues/43))

## bskyr 0.3.0

CRAN release: 2025-05-02

- Adds support for embedded link cards in
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md).
  ([\#17](https://github.com/christopherkenny/bskyr/issues/17))
- Adds new function
  [`bs_new_embed_external()`](http://christophertkenny.com/bskyr/reference/bs_new_embed_external.md)
  to support manual setup of external embeds.
  ([\#17](https://github.com/christopherkenny/bskyr/issues/17))
- Adds more control to
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
  with a new argument `created_at` to customize times of posts.
  ([\#21](https://github.com/christopherkenny/bskyr/issues/21))
- Attempts to add an aspect ratio to image posts, if the image can be
  read by `magick`.
  ([\#20](https://github.com/christopherkenny/bskyr/issues/20))
- Adds support to get a list feed with
  [`bs_get_list_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_list_feed.md).
  ([\#26](https://github.com/christopherkenny/bskyr/issues/26))
- Corrects a bug in parsing of URLs in posts and tagging them as
  richtext.
  ([\#23](https://github.com/christopherkenny/bskyr/issues/23))
- Adds
  [`bs_delete_post()`](http://christophertkenny.com/bskyr/reference/bs_delete_post.md)
  to delete posts.

## bskyr 0.2.0

CRAN release: 2025-02-08

- Improves processing of posts into tidy objects, impacting:
  - [`bs_get_posts()`](http://christophertkenny.com/bskyr/reference/bs_get_posts.md):
    Posts are now returned as a tibble with one row per post, regardless
    of type.
  - [`bs_get_author_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_author_feed.md):
    Posts no longer create extra columns when there are multiple embeds.
- Adds support for starter packs
  ([\#7](https://github.com/christopherkenny/bskyr/issues/7))
  - [`bs_get_actor_starter_packs()`](http://christophertkenny.com/bskyr/reference/bs_get_actor_starter_packs.md)
    retrieves a list of starter packs for a specific actor.
  - [`bs_get_starter_pack()`](http://christophertkenny.com/bskyr/reference/bs_get_starter_pack.md)
    retrieves a specific starter pack.
  - [`bs_get_starter_packs()`](http://christophertkenny.com/bskyr/reference/bs_get_starter_packs.md)
    retrieves a list of starter packs.
- Adds support for additional search parameters in
  [`bs_search_posts()`](http://christophertkenny.com/bskyr/reference/bs_search_posts.md)
  ([\#6](https://github.com/christopherkenny/bskyr/issues/6))
- Adds support for emoji in the text of posts, powered by the emoji
  package. ([\#11](https://github.com/christopherkenny/bskyr/issues/11))
- Adds
  [`bs_url_to_uri()`](http://christophertkenny.com/bskyr/reference/bs_url_to_uri.md)
  to convert a URL to a Bluesky URI.
  - This additionally allows
    [`bs_get_posts()`](http://christophertkenny.com/bskyr/reference/bs_get_posts.md)
    to take URLs.
- Add support for posting videos within
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md),
  including gifs
  ([\#5](https://github.com/christopherkenny/bskyr/issues/5)).
- Improves list reading functionality
  - [`bs_get_actor_lists()`](http://christophertkenny.com/bskyr/reference/bs_get_actor_lists.md)
    retrieves all lists made by an actor
  - [`bs_get_list()`](http://christophertkenny.com/bskyr/reference/bs_get_list.md)
    retrieves a view of a list
- Expands support for working with lists
  ([\#9](https://github.com/christopherkenny/bskyr/issues/9))
  - [`bs_new_list()`](http://christophertkenny.com/bskyr/reference/bs_new_list.md)
    creates a new list
  - [`bs_delete_list()`](http://christophertkenny.com/bskyr/reference/bs_delete_list.md)
    deletes a list
  - [`bs_new_list_item()`](http://christophertkenny.com/bskyr/reference/bs_new_list_item.md)
    adds someone to a list
  - [`bs_delete_list_item()`](http://christophertkenny.com/bskyr/reference/bs_delete_list_item.md)
    removes someone from a list
- Adds new helper function
  [`bs_extract_record_key()`](http://christophertkenny.com/bskyr/reference/bs_extract_record_key.md)
  to extract the record id or key from a URL or URI.
- Adds support for getting relationships between users with
  [`bs_get_relationships()`](http://christophertkenny.com/bskyr/reference/bs_get_relationships.md).
- Adds support for getting quote posts for a given post with
  [`bs_get_quotes()`](http://christophertkenny.com/bskyr/reference/bs_get_quotes.md).
- Fixes bug in repeated requests which could result in duplicate
  responses.
  ([\#13](https://github.com/christopherkenny/bskyr/issues/13))
- Minor improvements to
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
  - Adds a `max_tries` argument that can be set to avoid transient
    issues.
    ([\#15](https://github.com/christopherkenny/bskyr/issues/15))
  - Improves processing of tags in posts
    ([@nguyenank](https://github.com/nguyenank),
    [\#10](https://github.com/christopherkenny/bskyr/issues/10)).
  - Images created with
    [`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
    and `clean = TRUE` can be passed to `images` in
    [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md).
- General improved processing for creating and deleting records
  - [`bs_follow()`](http://christophertkenny.com/bskyr/reference/bs_follow.md)
    allows for following other “subjects” (colloquially, other users)
  - [`bs_unfollow()`](http://christophertkenny.com/bskyr/reference/bs_delete_follow.md)
    allows for deleting follow records
  - [`bs_block()`](http://christophertkenny.com/bskyr/reference/bs_block.md)
    allows for blocking other “subjects”
  - [`bs_unblock()`](http://christophertkenny.com/bskyr/reference/bs_delete_block.md)
    allows for deleting block records
  - [`bs_unlike()`](http://christophertkenny.com/bskyr/reference/bs_delete_like.md)
    allows for deleting like records
  - [`bs_delete_repost()`](http://christophertkenny.com/bskyr/reference/bs_delete_repost.md)
    allows for deleting repost records
  - [`bs_new_starter_pack()`](http://christophertkenny.com/bskyr/reference/bs_new_starter_pack.md)
    allows for creating new starter packs
  - [`bs_delete_starter_pack()`](http://christophertkenny.com/bskyr/reference/bs_delete_starter_pack.md)
    allows for deleting starter packs

## bskyr 0.1.3

- Fixes a bug where posting a single image fails
  ([\#3](https://github.com/christopherkenny/bskyr/issues/3)).
- Improves authentication experience using a local cache to avoid
  timeouts ([\#2](https://github.com/christopherkenny/bskyr/issues/2)).
- Requires alt text in
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
  to avoid issues with posting images due to accessibility settings
  upstream.
- Adds support for linking for hashtags.

## bskyr 0.1.2

CRAN release: 2024-01-09

- Requests with `clean = TRUE` now include an attribute “request_url”
  with the request URL. This does not include any headers, so
  authentication information is *not* recorded.
- All functions with `limit` arguments now gain a `cursor` argument.
  This allows for requesting further pages of results.
- All functions with `limit` arguments will now automatically make
  additional API calls if more results are requested than the limit. For
  example,
  [`bs_get_followers()`](http://christophertkenny.com/bskyr/reference/bs_get_followers.md)
  is limited to 100 results per call. If `limit = 301`, it will make 4
  API calls to get all 301 results. A progress bar will appear if the
  response is taking sufficient time to return.
- Fixes bug where
  [`bs_get_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_feed.md)
  would discard posts with no interactions.

## bskyr 0.1.1

- Provides support for new post search endpoint with
  [`bs_search_posts()`](http://christophertkenny.com/bskyr/reference/bs_search_posts.md)

## bskyr 0.1.0

CRAN release: 2023-11-26

- Adds support for additional posting features.
  - Language for posts can be specified with the `langs` argument.
  - Images can be specified with the `images` argument.
  - Alt text for images can be specified with the `images_alt` argument.
  - Mentions and URLs are now parsed and passed as richtext facets,
    automatically.
  - Replies can be made by specifying the `reply` argument with a link
    of a post to reply to.
  - Quotes can be made by specifying the `quote` argument with a link of
    a post to quote.
- Adds support for direct blob uploads with
  [`bs_upload_blob()`](http://christophertkenny.com/bskyr/reference/bs_upload_blob.md).
  This powers the ability to add media to posts.
- Adds
  [`bs_uri_to_url()`](http://christophertkenny.com/bskyr/reference/bs_uri_to_url.md)
  which formats a given `uri` as an HTTPS URL.
- Adds
  [`bs_resolve_handle()`](http://christophertkenny.com/bskyr/reference/bs_resolve_handle.md)
  to convert handles to decentralized identifiers (DIDs).
- Adds support for working with arbitrary records.
  - [`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
    creates a record.
  - [`bs_delete_record()`](http://christophertkenny.com/bskyr/reference/bs_delete_record.md)
    deletes a record.
  - [`bs_get_record()`](http://christophertkenny.com/bskyr/reference/bs_get_record.md)
    gets an existing record.
  - [`bs_list_records()`](http://christophertkenny.com/bskyr/reference/bs_list_records.md)
    lists existing records for a user and collection.
  - [`bs_describe_repo()`](http://christophertkenny.com/bskyr/reference/bs_describe_repo.md)
    provides a list of types of collections that a user has.
  - Use helper function
    [`bs_created_at()`](http://christophertkenny.com/bskyr/reference/bs_created_at.md)
    to get the specific time formatting.

## bskyr 0.0.5

- Fixes testing issues on CRAN when token is not available.
- Adds `clean` argument to decide if a response should be cleaned into a
  `tibble` before returning. If `FALSE`, you receive the json as a list.
- Adds support for changing limits on the number of results returned.

## bskyr 0.0.1

- Initial package version, implementing features for accessing details
  about actors (user profiles), making posts, and more.
- Implements testing with `testthat` and `httptest2`.
- Limited posting abilities, as the initial version is focused on
  collecting data over creating data.
