library(tidyverse)

# files <- gh::gh(
#   "GET /repos/{owner}/{repo}/contents/{path}",
#   owner = 'bluesky-social',
#   repo = 'atproto',
#   path = 'lexicons',
#   ref = 'main'
# )

# which are mentioned in the current docs
current_supported <- fs::dir_ls('R') |>
  lapply(function(x) {
    lns <- readLines(x)
    lns |>
      purrr::keep(stringr::str_detect(lns, '\\[.+/.+.json'))
  }) |>
  tibble::enframe(name = 'file', value = 'line') |>
  tidyr::unnest_longer(line) |>
  dplyr::mutate(
    lexicon = stringr::str_extract(line, '\\[(.+/.+).json '),
    lexicon = stringr::str_sub(lexicon, 2, -2),
    full = stringr::str_extract(line, 'lexicons/.+/.+/.+/.+'),
    full = stringr::str_sub(full, 10, -2)
  )

# what is the full set of lexicons
all_lexicon_files <- fs::dir_ls('../atproto/lexicons/', recurse = TRUE, glob = '*.json')

all_lexicons <- lapply(all_lexicon_files, yyjsonr::read_json_file)

non_def_lexicons <- all_lexicons |>
  discard_at(at = stringr::str_detect(all_lexicon_files, 'defs'))

types <- tibble::tibble(
  file = names(non_def_lexicons),
  full = str_remove(file, '../atproto/lexicons/'),
  type = map_chr(non_def_lexicons, function(x) x$defs$main$type)
)

t
