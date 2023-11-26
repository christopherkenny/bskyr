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
  * Use helper function `bs_created_at()` to get the specific time formatting.

# bskyr 0.0.5

* Fixes testing issues on CRAN when token is not available.
* Adds `clean` argument to decide if a response should be cleaned into a `tibble` before returning. If `FALSE`, you receive the json as a list.
* Adds support for changing limits on the number of results returned.

# bskyr 0.0.1

* Initial package version, implementing features for accessing details about actors (user profiles), making posts, and more.
* Implements testing with `testthat` and `httptest2`.
* Limited posting abilities, as the initial version is focused on collecting data over creating data.
