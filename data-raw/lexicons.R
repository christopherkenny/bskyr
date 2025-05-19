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

    lex_lns <- which(stringr::str_detect(lns, '\\[.+/.+.json'))
    fn_lns <- which(stringr::str_detect(lns, ' <- function\\('))

    keeps <- map_int(lex_lns, function(x) {
      fn_lns[fn_lns > x][1]
    })

    lex <- lns[lex_lns]
    fns <- lns[keeps]

    if (length(lex_lns) > 0) {
      tibble::tibble(
        file = x,
        line = lex,
        fn = fns
      )
    } else {
      NULL
    }
  }) |>
  list_rbind() |>
  dplyr::mutate(
    lexicon = stringr::str_extract(line, '\\[(.+/.+).json '),
    lexicon = stringr::str_sub(lexicon, 2, -2),
    ref = stringr::str_extract(line, 'lexicons/.+/.+/.+/.+'),
    ref = stringr::str_sub(ref, 10, -2)
  )

# what is the full set of lexicons
all_lexicon_files <- fs::dir_ls('../atproto/lexicons/', recurse = TRUE, glob = '*.json')

all_lexicons <- lapply(all_lexicon_files, yyjsonr::read_json_file)

non_def_lexicons <- all_lexicons |>
  discard_at(at = stringr::str_detect(all_lexicon_files, 'defs'))

types <- tibble::tibble(
  local_file = names(non_def_lexicons),
  ref = str_remove(local_file, '../atproto/lexicons/'),
  type = map_chr(non_def_lexicons, function(x) x$defs$main$type)
)

# which are implemented
types |>
  left_join(current_supported, by = 'ref') |>
  filter(str_detect(ref, 'app/bsky/'), is.na(fn))

# queries to do
types |>
  anti_join(current_supported, by = 'ref') |>
  filter(str_detect(ref, 'app/bsky/'), !str_detect(ref, 'unspecced'), type == 'query')
