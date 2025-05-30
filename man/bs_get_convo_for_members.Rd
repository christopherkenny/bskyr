% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convo_get_convo_members.R
\name{bs_get_convo_for_members}
\alias{bs_get_convo_for_members}
\title{Retrieve conversation shared among specified members}
\usage{
bs_get_convo_for_members(
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
A \link[tibble:tibble]{tibble::tibble} or a \code{list} if \code{clean = FALSE}.
}
\description{
Retrieve conversation shared among specified members
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/getConvoForMembers.json}{chat.bsky.convo.getConvoForMembers.json (2025-05-16)}
}

\section{Function introduced}{

\code{v0.4.0} (2025-05-16)
}

\examples{
\dontshow{if (has_bluesky_pass() && has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_get_convo_for_members(actors = c('bskyr.bsky.social', 'chriskenny.bsky.social'))
\dontshow{\}) # examplesIf}
}
\concept{chat}
