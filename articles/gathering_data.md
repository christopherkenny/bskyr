# Gathering Data from Bluesky Social

Bluesky Social is a decentralized social network built on the AT
Protocol. For users, this means it is possible to programmatically
access a broad range of public data from the network. Bluesky organizes
information as a series of **records**, each defined by a structured
schema known as a **lexicon**. These lexicons (e.g., `app.bsky.*`)
specify the types of data (such as posts, profiles, or social
relationships) and the methods for querying them. The `bskyr` package
provides an R interface to these endpoints, abstracting the underlying
API and returning data in a tidy format suitable for analysis.

This vignette provides an overview of how to collect public data from
Bluesky using the `bskyr` package. It focuses on common data collection
tasks such as retrieving user profiles, gathering posts, exploring
threads, accessing social relationships, and examining likes or reposts.

## Setup and Authentication

Begin by loading the `bskyr` package:

``` r
library(bskyr)
```

Before gathering data, you need to authenticate with Bluesky. (This
requires having a Bluesky account and creating an App Password in your
account settings.) In this vignette, we assume you have already set your
Bluesky username and App Password via
[`set_bluesky_user()`](http://christophertkenny.com/bskyr/reference/set_bluesky_user.md)
and
[`set_bluesky_pass()`](http://christophertkenny.com/bskyr/reference/set_bluesky_pass.md)
(or by storing them in your .Renviron). If so, you can create an
authenticated session with:.

``` r
auth <- bs_auth(user = bs_get_user(), pass = bs_get_pass())
```

This authentication is used internally by most functions, though
explicitly creating a session at the beginning of your script is
recommended to avoid repeated logins. Note that this is *not* necessary
to do for every function call, as your authentication is *automatically*
cached for the session and refreshed if it gets stale.

## Working with your own data

Bluesky’s API distinguishes between data you can access about your own
account versus public data about others. A few endpoints only allow
fetching your personal data (for managing your account) and not other
users’. For example, you can retrieve your preferences with
[`bs_get_preferences()`](http://christophertkenny.com/bskyr/reference/bs_get_preferences.md),
but you cannot retrieve another user’s preferences. Similarly, you can
only get your list of blocks or mutes, and your notifications. .

For instance, to fetch your current preference settings (such as content
filtering preferences):

``` r
bs_get_preferences()
```

Other self-focused functions include retrieving your blocked accounts
([`bs_get_blocks()`](http://christophertkenny.com/bskyr/reference/bs_get_blocks.md)),
your muted lists
([`bs_get_muted_lists()`](http://christophertkenny.com/bskyr/reference/bs_get_muted_lists.md)),
and your notifications
([`bs_get_notifications()`](http://christophertkenny.com/bskyr/reference/bs_get_notifications.md)).
These functions correspond to lexicons in the `app.bsky.notification.*`
or `app.bsky.graph.*` namespaces, and they only return data for the
authenticated user. .

In the remainder of this vignette, we’ll focus on gathering public data
about other users and content on Bluesky. All such data is accessible
via the Bluesky API (with your authentication), provided the information
is public.

## Public Data about Other Users

Most `bskyr` functions are designed to gather data about other users or
content they’ve created. We will demonstrate these using a sample
account: `chriskenny.bsky.social`. (This is the Bluesky handle of the
`bskyr` package author, Christopher T. Kenny.) Using this account as an
example, we’ll show how to retrieve various types of information:.

- Profile information (user metadata)
- User feeds / posts (the content they have posted)
- Threads and replies (conversation threads involving that user’s posts)
- Followers and follows (the user’s social graph)
- Likes and other interactions (posts the user liked, and who liked the
  user’s posts)

Each subsection below focuses on one of these data types, with example
code and notes on the relevant lexicons.

## Accessing Profile Information

A basic starting point is retrieving a user’s profile. The
[`bs_get_profile()`](http://christophertkenny.com/bskyr/reference/bs_get_profile.md)
function queries the `app.bsky.actor.getProfile` lexicon to fetch
profile details for one or more users. For example, to get the profile
of `chriskenny.bsky.social`, use
[`bs_get_profile()`](http://christophertkenny.com/bskyr/reference/bs_get_profile.md).

``` r
profile <- bs_get_profile('chriskenny.bsky.social')
profile
```

This returns metadata such as the user’s handle, display name,
description, and follower counts. To retrieve multiple profiles:.

``` r
bs_get_profile(actors = c('chriskenny.bsky.social', 'simko.bsky.social'))
```

## Gathering Posts from a User

To access posts authored by a user, use
[`bs_get_author_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_author_feed.md),
which queries the `app.bsky.feed.getAuthorFeed` lexicon:

``` r
feed <- bs_get_author_feed('chriskenny.bsky.social')
feed |>
  dplyr::select(uri, like_count, reply_count)
```

Each row in the feed tibble represents a post made by the user. Key
columns include the post content (`text`), the number of likes and
replies, and potentially other metadata like repost count, timestamps
(`created_at`), and unique post IDs (`uri` and `cid`). By default,
[`bs_get_author_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_author_feed.md)
returns the most recent batch of posts (the Bluesky API typically
returns up to 50 at a time). .

If the user has more posts, the `cursor` returned can be used to
paginate:

``` r
more_posts <- bs_get_author_feed('chriskenny.bsky.social', cursor = attr(feed, 'cursor')$cursor)
```

## Retrieving Threads and Replies

Social interactions on Bluesky often happen in threads: a post and its
replies (and replies to those replies, and so on). The `bskyr` package
provides tools to retrieve entire conversation threads so you can
analyze the context of a post. .

To get a full thread for a particular post, use bs_get_post_thread().
This function calls the app.bsky.feed.getPostThread lexicon, which
returns the specified post, its ancestors (if it was a reply itself),
and all of its replies (and replies to those replies, up to a specified
depth). In other words, it fetches the whole conversation tree. .

Suppose we have a specific post by me that we want to examine in
context. If we know the post’s URI or URL, we can retrieve the thread.
For example, using a post URL (as you might copy from the Bluesky app or
web):.

``` r
thread <- bs_get_post_thread('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
thread
```

This returns the conversation context around a specific post. If the
post URI is known,
[`bs_get_posts()`](http://christophertkenny.com/bskyr/reference/bs_get_posts.md)
can be used to retrieve it directly:.

``` r
post <- bs_get_posts('https://bsky.app/profile/chriskenny.bsky.social/post/3loagm2phgk2t')
post$record[[1]] |>
  dplyr::select(`$type`, text, created_at)
```

## Accessing Social Graph Data

Bluesky, like other social platforms, allows users to follow each other.
The `app.bsky.graph.*` lexicons provide access to this social graph. In
`bskyr`, you can list a user’s followers and who a user is following
(their “follows”) with dedicated functions.

- [`bs_get_followers()`](http://christophertkenny.com/bskyr/reference/bs_get_followers.md):
  retrieves the accounts that follow a given user.
- [`bs_get_follows()`](http://christophertkenny.com/bskyr/reference/bs_get_follows.md):
  retrieves the accounts that a given user is following.

Both functions query the corresponding lexicons
`app.bsky.graph.getFollowers` and `app.bsky.graph.getFollows` and return
`tibble`s of user profiles. .

For example, to get all followers of `chriskenny.bsky.social`:

``` r
followers <- bs_get_followers('chriskenny.bsky.social')
followers
```

Each row represents one follower, including their handle, display name,
and bio (description). The followers `tibble` may also include each
follower’s `did` and possibly counts or mutual follow info (e.g.,
whether you follow them, if you are authenticated). By default, a
certain number of followers are returned (Bluesky’s API uses pagination
via cursors here as well). If the user has a lot of followers, you can
use the cursor and limit arguments in
[`bs_get_followers()`](http://christophertkenny.com/bskyr/reference/bs_get_followers.md)
to page through all results. .

Similarly, to get the list of accounts that `chriskenny.bsky.social`
follows (his “following” list):

``` r
follows <- bs_get_follows('chriskenny.bsky.social')
follows
```

This returns a `tibble` of the users that I am following. The structure
is the same as for followers (each row is a user profile). You could,
for instance, compare the two lists to find overlaps, or combine them to
analyze mutual connections. These functions rely on the Bluesky graph
endpoints and are great for mapping out the network around a user.

## Likes and Reposts

Finally, let’s look at how to gather data on post *interactions* like
likes (and similarly, reposts). Bluesky treats likes and reposts as
separate record types, and the API provides endpoints to query them.
Posts liked by a user: To fetch the posts that a given user has liked
(the content of their “Likes” tab on their profile), use
[`bs_get_likes()`](http://christophertkenny.com/bskyr/reference/bs_get_likes.md).
This function hits the `app.bsky.feed.getActorLikes` lexicon and returns
a `tibble` of posts. Essentially, it’s the reverse of
[`bs_get_author_feed()`](http://christophertkenny.com/bskyr/reference/bs_get_author_feed.md),
instead of posts the user authored, it gives posts the user liked. For
example:.

``` r
liked_posts <- bs_get_likes('bskyr.bsky.social')
liked_posts |>
  dplyr::select(author_handle, record_text)
```

Each row here is a post that was liked by `chriskenny.bsky.social`,
showing who the author of that post is (author.handle) and the post
content (text). The full data frame would also include details like the
post’s URI, timestamps, and engagement counts. This is a great way to
retrieve a user’s liked content for further analysis (for instance, to
see what topics or users they engage with). .

*Who liked a specific post*: Conversely, if you want to see which users
have liked a particular post, you can use
[`bs_get_post_likes()`](http://christophertkenny.com/bskyr/reference/bs_get_post_likes.md).
This corresponds to the `app.bsky.feed.getLikes` lexicon and returns a
tibble of actors. You need to specify the post by its URI or a bsky.app
URL. For example, if we want to find out who liked one of my posts
(identified by a known URI):.

``` r
bs_get_post_likes('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lnghukd7vk22')
```

This would return a `tibble` of users (handles, display names, etc.) who
have liked that post. It’s similar in structure to the followers list we
saw earlier. By examining this, you could see the audience engaging with
a particular piece of content. Reposts: Bluesky also has a concept of
“reposts” (analogous to retweets), where a user rebroadcasts someone
else’s post. To get the users who reposted a given post, you can use
[`bs_get_reposts()`](http://christophertkenny.com/bskyr/reference/bs_get_reposts.md),
which calls the `app.bsky.feed.getRepostedBy` endpoint. Its usage is
just like
[`bs_get_post_likes()`](http://christophertkenny.com/bskyr/reference/bs_get_post_likes.md),
you provide a post URI or URL, and it returns a tibble of users who
reposted that post. For brevity, we won’t show a full example, but it
works in much the same way.

``` r
bs_get_reposts('at://did:plc:wpe35pganb6d4pg4ekmfy6u5/app.bsky.feed.post/3lnghukd7vk22')
```

would give the list of accounts that reposted the specified post.

## Conclusion

By combining these functions, you can gather a rich set of data from
Bluesky Social. For instance, you might collect a user’s profile and
posts, then fetch all replies to those posts, the list of users who
follow them, and the posts they’ve liked. This opens up many
possibilities for analysis: social network analysis (using follows
data), content analysis (using posts and threads), and engagement
analysis (using likes and reposts).

In this vignette, we demonstrated how to use `bskyr` to gather various
types of public data from the Bluesky Social network. We covered
retrieving user profiles, fetching a user’s posts, exploring
conversation threads, listing followers and follows, and accessing likes
(and other interactions). All of these tasks are made possible by
Bluesky’s open AT Protocol and its lexicon-defined API endpoints, which
`bskyr` conveniently wraps in R functions. .

With these tools, R users can treat Bluesky as a data source for
research or development. You can pull data on social connections, user
behavior, and content trends from Bluesky and then apply the vast
ecosystem of R packages for data analysis and visualization. As the
Bluesky network grows and its API evolves, `bskyr` will aim to keep up,
providing an efficient bridge between the AT Protocol and R.

------------------------------------------------------------------------

**DISCLAIMER**: This vignette has been written with help from ChatGPT
4o. It has been reviewed for correctness and edited for clarity by the
package author. Please note any issues at
<https://github.com/christopherkenny/bskyr/issues>.
