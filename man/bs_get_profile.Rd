% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/actor_profile.R
\name{bs_get_profile}
\alias{bs_get_profile}
\title{Get Profile for a Bluesky Social User}
\usage{
bs_get_profile(
  actors,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
}
\arguments{
\item{actors}{character vector of actor(s), such as \code{'chriskenny.bsky.social'}}

\item{user}{Character. User name to log in with. Defaults to \code{get_bluesky_user()}.}

\item{pass}{Character. App password to log in with. Defaults to \code{get_bluesky_pass()}.}

\item{auth}{Authentication information. Defaults to \code{bs_auth(user, pass)}.}

\item{clean}{Logical. Should output be cleaned into a \code{tibble}? Default: \code{TRUE}.}
}
\value{
a tibble with a row for each actor
}
\description{
Get Profile for a Bluesky Social User
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfiles.json}{actor/getProfiles.json (2023-10-01)}
\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/app/bsky/actor/getProfile.json}{actor/getProfile.json (2023-10-01)}
}

\section{Function introduced}{

\code{v0.0.1} (2023-10-01)
}

\examples{
\dontshow{if (has_bluesky_pass() && has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_get_profile('chriskenny.bsky.social')
bs_get_profile(actors = c('chriskenny.bsky.social', 'simko.bsky.social'))
\dontshow{\}) # examplesIf}
}
\concept{actor}
