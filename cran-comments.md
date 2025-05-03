## Test environments

* local R installation (Windows 11), R 4.5.0 and R 4.2.2
* local R installation (macOS 11.4), R 4.5.0
* ubuntu 22.04 (on GitHub Actions), (devel and release)
* windows-latest (on GitHub Actions), (release)
* macOS-latest (on GitHub Actions), (release)
* Windows (on Winbuilder), (release)

## R CMD check results

0 errors | 0 warnings | 0 notes (or maybe 1 note)

* On Winbuilder, I did see a `429` error for some of the Lexicon links within the package.
  This appears to only happen on Winbuilder and not locally or GitHub Actions.
