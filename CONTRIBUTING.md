# Contributing to bskyr

## Opening Issues

Please file issues at
<https://github.com/christopherkenny/bskyr/issues>. Include a minimal
reproducible example where possible. The likelihood of fixing an issue
is drastically increased if I can reproduce it.

## Making Pull Requests

- For nontrivial edits, please open an issue first.
- Fork the repository and open a pull request against `main`.
- Run `devtools::check()` and ensure there are no new errors or
  warnings.
- Code style follows
  [`styler.quote`](https://github.com/christopherkenny/styler.quote).
  Apply it with `styler.quote::style_file()` to any edited files. It is
  identical to `styler`’s tidyverse style, but with single quotes `'`.

## Updating Documentation

Parameter documentation uses the @param `r template_var_*()` pattern.
Template functions are defined in `R/roxygen.R` and called inline in
`@param` tags, for example:

``` r

#' @param actor `r template_var_actor()`
#' @param limit `r template_var_limit(100)`
```

Before adding a new template function, please check for any overlapping
parameters that might be more appropriate.

Do **not** use `@inheritParams`. It obscures what each function accepts
and makes the reference documentation harder to read and maintain.
