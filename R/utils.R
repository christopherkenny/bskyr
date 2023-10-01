clean_names <- function(x) {
  out <- x |>
    names() |>
    gsub('\\.', '_', x = _) |>
    gsub('([a-z])([A-Z])', '\\1_\\2', x = _) |>
    tolower()
  stats::setNames(object = x, nm = out)
}
