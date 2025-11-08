# Creating Records on Bluesky Social

Bluesky Social’s API is built around a decentralized model where user
content and interactions are stored as **records** in your personal data
repository. Each record follows a strict schema defined in a *lexicon*.
For example, a regular post is defined by the `app.bsky.feed.post`
lexicon, while a “like” is defined by `app.bsky.feed.like`. This means
that actions like posting, liking, or reposting on Bluesky all translate
to creating specific record types in your account. The `bskyr` package
provides high-level R functions to create these records
programmatically, aligning with the underlying lexicons.

A detailed understanding of lexicons isn’t required for basic use, but
it’s useful to know that each `bskyr` function corresponds to a
particular record type. In this vignette, we demonstrate how to create
content and interactions on Bluesky Social using `bskyr`. We will cover
how to make new posts (including text-only posts, quote posts, and posts
with media or links), how to reply to posts, and how to interact with
posts by liking or reposting them. We also show how to delete content
you’ve created. Finally, we touch on advanced usage of
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
for creating records in a more generic way.

**Authentication:** Before proceeding, ensure you are authenticated with
Bluesky. Assuming you have already configured your Bluesky credentials
(via
[`set_bluesky_user()`](http://christophertkenny.com/bskyr/reference/set_bluesky_user.md)
and
[`set_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/set_bluesky_pass.md)
or environment variables), you can authenticate once at the start:

``` r
library(bskyr)
auth <- bs_auth(user = bs_get_user(), pass = bs_get_pass())
```

In the current version of `bskyr`, you do not need to take this step, as
it is handled automatically when you call any function that requires
authentication.

## Creating a New Post

To create a new text post on Bluesky, use the
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
function. At minimum, you provide the content of the post via the `text`
argument. This function creates a **feed post record** in your Bluesky
account (using the `app.bsky.feed.post` lexicon under the hood). It
returns a `tibble` with details of the created post, including its
unique URI and other metadata.

For example, here’s how to create a simple text-only post:

``` r
bs_post(text = '[vignette] This is a post from R using `bskyr` on Creating Records.')
```

When this function is called, it will post the given text to your
Bluesky feed. The result (if assigned) contains the post’s URI and CID
(content ID). You may want to save the result (e.g., in a variable) if
you plan to reference or delete this post later.

## Creating a Post with a Quote

Bluesky allows you to quote another post (similar to quoting a tweet,
where you share someone’s post with your own commentary). To create a
quote post, use the quote argument in
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md).
You should supply the URI or web link of the post you want to quote.
`bskyr` will then embed the referenced post into your new post record
(under the hood this uses the `app.bsky.embed.record` schema for the
quoted record).

For example, to quote another user’s post while adding your own text:

``` r
bs_post(
  text = '[vignette] This is a quote from R using `bskyr` on Creating Records',
  quote = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpem3br3qn2z'
)
```

Simply include the post ID as `quote` of the post you want to quote. The
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
call will create a new post containing your text and a quote of the
referenced post. You can use either the `https://bsky.app/profile/...`.
URL as shown, or the equivalent AT Protocol URI `at://...` for the post.
The function will handle it appropriately.

## Posting with Media and Links

Bluesky posts can include media or link previews in addition to text.
The
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
function makes it easy to attach these:

- *Images*: You can attach up to four images to a post using the
  `images` argument. Provide a character vector of file paths to the
  images. It’s recommended to also provide descriptive alt text for each
  image via the images_alt argument, with a character vector of the same
  length as the images. The images will be uploaded and embedded in the
  post (using the `app.bsky.embed.images` lexicon).
- *External links*: If your post text contains a URL,
  [`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
  will by default attempt to embed a preview card for that link (using
  the `app.bsky.embed.external` lexicon). This means you can include an
  external URL in the text and Bluesky may display a link preview on
  supported clients.

For example, to create a post with an image attached:

``` r
bs_post(
  text = '[vignette] This is a post with an image from R using `bskyr` on Creating Records',
  images = system.file('help/figures/logo.png', package = 'bskyr'),
  images_alt = 'A hexagon logo for bskyr with the letters "bskyr" on a cloud'
)
```

In this snippet, the image located at `"help/figures/logo.png"` within
`bskyr` will be uploaded and attached to the post, with alt text
describing the image. You can list multiple image file paths in images
(up to 4) and provide a corresponding alt text entry for each in
images_alt.

And here is an example of a post that includes an external link in the
text:

``` r
bs_post(
  text = '[vignette] This is a post with a link from R using `bskyr` on Creating Records. Check out the package at https://christophertkenny.com/bskyr/.',
)
```

When posting, if a URL (such as <https://example.com> in this case) is
present in the text,
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
will attempt to add it as an embedded link preview. On Bluesky, this
creates a card with the link’s title, description, and thumbnail (if
available) in your post. The exact appearance may depend on the client
app, but the underlying record will include an `app.bsky.embed.external`
embed for the URL.

## Replying to a Post

Replying to a post is straightforward using `bskyr`. A reply is
essentially a new post that is linked to an existing post as its parent.
To reply to a specific post, use the reply argument in
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
and provide the URI or link of the post you want to reply to. The
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
function will create a new post record that references the given post as
its parent (setting the appropriate reply thread reference in the
`app.bsky.feed.post` record).

For example, to reply to someone’s post:

``` r
bs_post(
  text  = '[vignette] This is a reply from R using `bskyr` on Creating Records',
  reply = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m'
)
```

This call will create a post with your text, threaded as a reply to the
specified post. In Bluesky, the new post will appear as a response in
the conversation thread of the original post.

*Note*: It’s possible to use both reply and quote simultaneously in a
single
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md)
call if you want to quote a post while replying to it. In that case, the
new post would be a reply in the thread and include a quoted embed of
the target post.

## Liking a Post

Liking a post on Bluesky creates a “like” record in your account
(defined by the `app.bsky.feed.like` lexicon). Using `bskyr`, you can
like a post with the function
[`bs_like()`](http://christophertkenny.com/bskyr/reference/bs_like.md).
This function will record that you liked a given post.

To like a post, you need to specify which post to like. The
[`bs_like()`](http://christophertkenny.com/bskyr/reference/bs_like.md)
function accepts a post argument where you can provide the post’s URI or
web URL. For convenience, you can pass the same kind of link you would
use for quoting or replying.

For example, to like a particular post:

``` r
bs_like(post = 'https://bsky.app/profile/chriskenny.bsky.social/post/3lktjjvxvdk2g')
```

This will create a like record for that post. The function returns a
`tibble` with information about the new like (including its own URI,
since the like is itself a record in your repository). There is no
visible effect in the output, but on Bluesky the target post will now
show as liked by your account.

## Reposting a Post

Reposting is an action that creates a repost record (using the
`app.bsky.feed.repost` lexicon). A repost indicates you are sharing
someone else’s post on your feed without adding additional text of your
own.

To repost a post via bskyr, use the
[`bs_repost()`](http://christophertkenny.com/bskyr/reference/bs_repost.md)
function. Provide the target post’s URI or URL as the argument, and
[`bs_repost()`](http://christophertkenny.com/bskyr/reference/bs_repost.md)
will create a repost record under your account.

For example, to repost a given post:

``` r
bs_repost(post = 'https://bsky.app/profile/chriskenny.bsky.social/post/3lktjjvxvdk2g')
```

This call will create a repost record for that post. The function
returns a `tibble` with details of the repost. On Bluesky, the effect is
that the original post will appear on your feed as a repost by you.

## Deleting Content (Posts, Likes, and Reposts)

All posts and interactions you create are stored as records in your
Bluesky repository, and they can be deleted if needed. `bskyr` provides
convenience functions to delete records:

- Deleting a post: use
  [`bs_delete_post()`](http://christophertkenny.com/bskyr/reference/bs_delete_post.md).
- Deleting a like: use
  [`bs_delete_like()`](http://christophertkenny.com/bskyr/reference/bs_delete_like.md)
  (this un-likes the post).
- Deleting a repost: use
  [`bs_delete_repost()`](http://christophertkenny.com/bskyr/reference/bs_delete_repost.md)
  (this removes the repost from your feed).

Each of these functions requires the record’s unique key (often called
the record key or rkey) to identify which record to delete. If you have
the original object returned when you created the record, you can
extract its key using
[`bs_extract_record_key()`](http://christophertkenny.com/bskyr/reference/bs_extract_record_key.md)
on the record’s URI. For example, if you saved a post to an object post
when creating it, you can delete it like so:

``` r
post <- bs_post(text = '[vignette] This is a post to be deleted from R using `bskyr` on Creating Records.')
bs_delete_post(bs_extract_record_key(post$uri))
```

In the above example, `post$uri` contains the full URI of the new post
record, and
[`bs_extract_record_key()`](http://christophertkenny.com/bskyr/reference/bs_extract_record_key.md)
pulls out the record’s key from that URI. We then pass that key into
[`bs_delete_post()`](http://christophertkenny.com/bskyr/reference/bs_delete_post.md)
to delete the post. The `200` displayed is the HTTP status code
indicating success.

Similarly, if you had saved a like or repost:

``` r
liked <- bs_like(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m')
reposted <- bs_repost(post = 'https://bsky.app/profile/bskyr.bsky.social/post/3lpemxzni4l2m')

bs_delete_like(bs_extract_record_key(liked$uri))
bs_delete_repost(bs_extract_record_key(reposted$uri))
```

The pattern is the same: the object returned by
[`bs_like()`](http://christophertkenny.com/bskyr/reference/bs_like.md)
or
[`bs_repost()`](http://christophertkenny.com/bskyr/reference/bs_repost.md)
has a uri field, and using
[`bs_extract_record_key()`](http://christophertkenny.com/bskyr/reference/bs_extract_record_key.md)
on it gives the identifier needed to delete that record via the
appropriate delete function.

*Note*: Under the hood, all these deletion functions are wrappers around
[`bs_delete_record()`](http://christophertkenny.com/bskyr/reference/bs_delete_record.md).
You could call `bs_delete_record(collection, rkey, ...)` directly by
specifying the record’s collection NSID (e.g., `'app.bsky.feed.post'`
for a post) and its record key. The specialized functions
([`bs_delete_post()`](http://christophertkenny.com/bskyr/reference/bs_delete_post.md),
[`bs_delete_like()`](http://christophertkenny.com/bskyr/reference/bs_delete_like.md),
etc.) simply provide a convenient shorthand for their respective record
types.

For example, suppose we want to create a post by calling
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
directly, instead of using
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md).
We need to use the `app.bsky.feed.post` collection and provide a record
with the required fields (at least the text and a timestamp):

## Advanced: Using `bs_create_record()`

As you may have noticed, everything in this vignette centers around
records. Posting, liking, quoting, etc. are all ways of creating records
in your Bluesky repository. Deleting is simply removing those records.

For advanced use cases, `bskyr` offers a low-level interface
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
which can create an arbitrary record in your repo, given the correct
parameters. This function is essentially a direct wrapper around the AT
Protocol endpoint for creating records
(`com.atproto.repo.createRecord`). It requires you to specify the
collection (the lexicon NSID for the record type) and a record list that
contains the fields defined by that record’s lexicon.

Most users will not need to call
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
directly, since higher-level functions like
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md),
[`bs_like()`](http://christophertkenny.com/bskyr/reference/bs_like.md),
etc., construct the appropriate record for you. However, if you need to
create a record type that `bskyr` doesn’t yet have a helper for, or you
want fine-grained control,
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
is the tool to use. Keep in mind that you must follow the lexicon’s
schema exactly when constructing the record list.

``` r
post_record <- list(
  text = '[vignette] Posting via bs_create_record()',
  createdAt = bs_created_at()
)
bs_create_record(collection = 'app.bsky.feed.post', record = post_record)
```

Here we constructed a list post_record with a text field for the post
content and a `createdAt` field. We used the helper function
[`bs_created_at()`](http://christophertkenny.com/bskyr/reference/bs_created_at.md)
to generate the current timestamp in the format the Bluesky lexicon
expects. Passing this into
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
with the appropriate collection will create a new post record identical
to one created by
[`bs_post()`](http://christophertkenny.com/bskyr/reference/bs_post.md).
The return value would be a tibble with the details of the created
record (including its URI and CID).

As another example, one could manually create a like record with
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
(though normally you would use
[`bs_like()`](http://christophertkenny.com/bskyr/reference/bs_like.md)).
The `app.bsky.feed.like` lexicon expects a subject (the post being
liked, identified by its URI and CID) and a timestamp. If `post_rcd` is
a post object we fetched or have details for, we could do:

``` r
post_rcd <- bs_get_record(
  'https://bsky.app/profile/bskyr.bsky.social/post/3lpeonujcdg2q',
  clean = FALSE
)

like_record <- list(
  subject = list(
    uri = post_rcd$uri,
    cid = post_rcd$cid
  ),
  createdAt = bs_created_at()
)
bs_create_record(collection = 'app.bsky.feed.like', record = like_record)
```

This illustrates how you must supply the necessary fields (in this case,
the post’s identifiers and a timestamp) to create a record. In practice,
using `bs_like(post = ...)` is much simpler, but
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
gives you the flexibility to craft requests for any record type as long
as you know the required schema.

## Conclusion

The `bskyr` package enables programmatic interaction with Bluesky Social
by creating and managing the same records that underpin the Bluesky
protocol. We covered how to make posts (with text, quotes, media, and
links) and how to interact with others’ posts through replies, likes,
and reposts. We also demonstrated how to delete content and touched on
the advanced
[`bs_create_record()`](http://christophertkenny.com/bskyr/reference/bs_create_record.md)
interface for custom record creation. With these tools, you can
integrate Bluesky Social into R workflows, bots, or analyses, taking
full advantage of the AT Protocol’s openness and the convenience of
tidyverse-style functions.

------------------------------------------------------------------------

**DISCLAIMER**: This vignette has been written with help from ChatGPT
4o. It has been reviewed for correctness and edited for clarity by the
package author. Please note any issues at
<https://github.com/christopherkenny/bskyr/issues>.
