## Resubmission

This is a resubmission. In this version, I have:

- Removes disallowed phrase "Tools for" from the start of the description.
- Removes commented out line in `bs_post.Rd`.
* Removed the default writing to the home directory for `set_bluesky_pass()` and `set_bluesky_user()`. If interactive and no path is included, it suggests a default path, but doesn't write unless interactively accepted.

## Test environments

* local R installation (Windows 11), R 4.3.1
* local R installation (macOS 11.4), R 4.3.1
* ubuntu 20.04 (on GitHub Actions), (devel and release)
* windows-latest (on GitHub Actions), (release)
* macOS-latest (on GitHub Actions), (release)
* Windows (on Winbuilder), (release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
