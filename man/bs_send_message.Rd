% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convo_send_message.R
\name{bs_send_message}
\alias{bs_send_message}
\title{Send a message in a conversation (DM thread)}
\usage{
bs_send_message(
  convo_id,
  text,
  user = get_bluesky_user(),
  pass = get_bluesky_pass(),
  auth = bs_auth(user, pass),
  clean = TRUE
)
}
\arguments{
\item{convo_id}{Character, length 1. ID of the conversation to get.}

\item{text}{Character, length 1. Message text.}

\item{user}{Character. User name to log in with. Defaults to \code{get_bluesky_user()}.}

\item{pass}{Character. App password to log in with. Defaults to \code{get_bluesky_pass()}.}

\item{auth}{Authentication information. Defaults to \code{bs_auth(user, pass)}.}

\item{clean}{Logical. Should output be cleaned into a \code{tibble}? Default: \code{TRUE}.}
}
\value{
a \link[tibble:tibble]{tibble::tibble} or a \code{list} if \code{clean = FALSE}
}
\description{
Send a message in a conversation (DM thread)
}
\section{Lexicon references}{

\href{https://github.com/bluesky-social/atproto/blob/main/lexicons/chat/bsky/convo/sendMessage.json}{chat.bsky.convo.sendMessage.json (2025-05-16)}
}

\section{Function introduced}{

\code{v0.4.0} (2025-05-16)
}

\examples{
\dontshow{if (has_bluesky_pass() && has_bluesky_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
bs_send_message(convo_id = '3ku7w6h4vog2d', text = '[example] sent with bskyr')
\dontshow{\}) # examplesIf}
}
\concept{chat}
