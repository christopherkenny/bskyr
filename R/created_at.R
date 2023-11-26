#' Get current time in Bluesky format
#'
#' @concept helper
#'
#' @section Function introduced:
#' `v0.1.0` (2023-11-25)
#'
#' @return a length 1 character vector
#' @export
#'
#' @examples.
#' bs_created_at()
bs_created_at <- function() {
  format(lubridate::now('UTC'), format = '%Y-%m-%dT%H:%M:%OS6Z')
}
