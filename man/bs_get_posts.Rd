% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feed_get_posts.R
\name{bs_get_posts}
\alias{bs_get_posts}
\title{Retrieve thread of posts}
\usage{
bs_get_posts(
  uris,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
}
\arguments{
\item{uris}{Character. Vector of URIs for posts to get.}

\item{user}{Character. User name to log in with. Defaults to \code{get_bluesky_user()}.}

\item{pass}{Character. App password to log in with. Defaults to \code{get_bluesky_pass()}.}

\item{auth}{Authentication information. Defaults to \code{bs_auth(user, pass)}.}

\item{clean}{Logical. Should output be cleaned into a \code{tibble}? Default: \code{TRUE}.}
}
\value{
a \link[tibble:tibble]{tibble::tibble} of posts
}
\description{
Retrieve thread of posts
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/feed/getPosts.json}{feed/getPosts.json (2023-10-01)}
}

\section{Function introduced}{

\code{v0.0.1} (2023-10-01)
}

\examples{
\dontshow{if (has_bluesky_pass() && has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_get_posts('at://did:plc:ic6zqvuw5ulmfpjiwnhsr2ns/app.bsky.feed.post/3k7qmjev5lr2s')
bs_get_posts('https://bsky.app/profile/chriskenny.bsky.social/post/3lc5d6zspys2c')
\dontshow{\}) # examplesIf}
}
\concept{feed}
