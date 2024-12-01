# bskyr 0.2.0

* Improves processing of posts into tidy objects, impacting:
  * `bs_get_posts()`: Posts are now returned as a tibble with one row per post, regardless of type.
  * `bs_get_author_feed()`: Posts no longer create extra columns when there are multiple embeds.
* Adds support for starter packs (#7)
  * `bs_get_actor_starter_packs()` retrieves a list of starter packs for a specific actor.
  * `bs_get_starter_pack()` retrieves a specific starter pack.
  * `bs_get_starter_packs()` retrieves a list of starter packs.
* Adds support for additional search parameters in `bs_search_posts()` (#6)
* Adds support for emoji in the text of posts, powered by the emoji package. (#11)
* Adds `bs_url_to_uri()` to convert a URL to a Bluesky URI.
  * This additionally allows `bs_get_posts()` to take URLs.
* Add support for posting videos within `bs_post()`, including gifs (#5).
* Improves list reading functionality
  * `bs_get_actor_lists()` retrieves all lists made by an actor
  * `bs_get_list()` retrieves a view of a list
* Expands support for working with lists (#9)
  * `bs_new_list()` creates a new list
  * `bs_delete_list()` deletes a list
  * `bs_new_list_item()` adds someone to a list 
  * `bs_delete_list_item()` removes someone from a list
* Adds new helper function `bs_extract_record_key()` to extract the record id or key from a URL or URI.
* Adds support for getting relationships between users with `bs_get_relationships()`.

# bskyr 0.1.3

* Fixes a bug where posting a single image fails (#3).
* Improves authentication experience using a local cache to avoid timeouts (#2).
* Requires alt text in `bs_post()` to avoid issues with posting images due to accessibility settings upstream.
* Adds support for linking for hashtags.

# bskyr 0.1.2

* Requests with `clean = TRUE` now include an attribute "request_url" with the request URL. This does not include any headers, so authentication information is *not* recorded.
* All functions with `limit` arguments now gain a `cursor` argument. This allows for requesting further pages of results.
* All functions with `limit` arguments will now automatically make additional API calls if more results are requested than the limit. For example, `bs_get_followers()` is limited to 100 results per call. If `limit = 301`, it will make 4 API calls to get all 301 results. A progress bar will appear if the response is taking sufficient time to return.
* Fixes bug where `bs_get_feed()` would discard posts with no interactions.

# bskyr 0.1.1

* Provides support for new post search endpoint with `bs_search_posts()`

# bskyr 0.1.0

* Adds support for additional posting features.
  * Language for posts can be specified with the `langs` argument.
  * Images can be specified with the `images` argument.
  * Alt text for images can be specified with the `images_alt` argument.
  * Mentions and URLs are now parsed and passed as richtext facets, automatically.
  * Replies can be made by specifying the `reply` argument with a link of a post to reply to.
  * Quotes can be made by specifying the `quote` argument with a link of a post to quote.
* Adds support for direct blob uploads with `bs_upload_blob()`. This powers the ability to add media to posts.
* Adds `bs_uri_to_url()` which formats a given `uri` as an HTTPS URL.
* Adds `bs_resolve_handle()` to convert handles to decentralized identifiers (DIDs).
* Adds support for working with arbitrary records.
  * `bs_create_record()` creates a record.
  * `bs_delete_record()` deletes a record.
  * `bs_get_record()` gets an existing record.
  * `bs_list_records()` lists existing records for a user and collection.
  * `bs_describe_repo()` provides a list of types of collections that a user has.
  * Use helper function `bs_created_at()` to get the specific time formatting.

# bskyr 0.0.5

* Fixes testing issues on CRAN when token is not available.
* Adds `clean` argument to decide if a response should be cleaned into a `tibble` before returning. If `FALSE`, you receive the json as a list.
* Adds support for changing limits on the number of results returned.

# bskyr 0.0.1

* Initial package version, implementing features for accessing details about actors (user profiles), making posts, and more.
* Implements testing with `testthat` and `httptest2`.
* Limited posting abilities, as the initial version is focused on collecting data over creating data.
