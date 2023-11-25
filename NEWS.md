# bskyr 0.1.0

* Adds support for additional posting features.
  * Language for posts can be specified with the `langs` argument.
  * Images can be specified with the `images` argument.
  * Alt text for images can be specified with the `images_alt` argument.
  * Mentions and URLs are now parsed and passed as richtext facets, automatically.
* Adds support for direct blob uploads with `bs_upload_blob()`. This powers the ability to add media to posts.
* Adds `bs_uri_to_url()` which formats a given `uri` as an HTTPS URL.
* Adds `bs_resolve_handle()` to convert handles to decentralized identifiers (DIDs).

# bskyr 0.0.5

* Fixes testing issues on CRAN when token is not available.
* Adds `clean` argument to decide if a response should be cleaned into a `tibble` before returning. If `FALSE`, you receive the json as a list.
* Adds support for changing limits on the number of results returned.

# bskyr 0.0.1

* Initial package version, implementing features for accessing details about actors (user profiles), making posts, and more.
* Implements testing with `testthat` and `httptest2`.
* Limited posting abilities, as the initial version is focused on collecting data over creating data.
