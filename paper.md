---
title: 'bskyr: An R Package to Interact with Bluesky Social'
tags:
  - R
  - social media
  - API
authors:
  - name: Christopher T. Kenny
    orcid: 0000-0002-9386-6860
    email: christopherkenny@fas.harvard.edu
    url: https://christophertkenny.com
    affiliation: 1
affiliations:
 - name: Princeton University
   department: Data-Driven Social Science
   address: 169 Nassau Street
   city: Princeton
   region: NJ
   postal-code: '08540 '
   index: 1
date: 20 January 2026
bibliography: paper.bib
---

# Summary

Bluesky Social is an offshoot of Twitter, designed to provide a decentralized alternative to traditional social media platforms.
`bskyr` is an R package [@r] that provides programmatic access to Bluesky Social.
The package wraps the official Bluesky Social API, enabling users to retrieve posts, threads, user profiles, social graphs (e.g., follows, mutes, blocks), curated lists, and starter packs.
It also supports content creation and interaction so that users can post, reply, like, repost, and follow directly from R.
All data is returned in tidy data frames, making it compatible with standard R workflows for analysis and visualization.
This allows users of `bskyr` to not only collect data for observational studies but also to engage with the platform programmatically, such as posting updates or interacting with other users.

# Statement of Need

Following the acquisition of Twitter by Elon Musk in 2022, Bluesky Social launched a public beta in February 2023.
Bluesky Social is built on the Authenticated Transfer (AT) Protocol, a decentralized social networking protocol that emphasizes user control, data portability, and interoperability.
Bluesky has over 30 million users [@bluesky_user_faq].
A similar package, Rtoot [@rtoot], has been designed for an alternative decentralized platform Mastodon.

Bluesky's decentralized design makes it an appealing platform for researchers interested in social media data, as it allows for near complete access to public posts, user interactions, and social graphs without the restrictions often imposed by centralized platforms.
In contrast, existing packages for Twitter, such as `academictwitteR` [@barrie2021academictwitter] or `rtweet` [@kearney2019rtweet], have unfortunately become less reliable due to changes in Twitter's API access policies and the platform's evolving nature under new ownership.

Due to the decentralized nature of Bluesky Social, users can access a wide range of public data without the restrictions often imposed by centralized platforms.
This is unlikely to be threatened by future changes to the platform, as Bluesky Social is open-source and designed to be accessible, with final control held by a public benefit corporation.

`bskyr` offers a consistent and user-friendly interface to nearly all public endpoints of Bluesky Social.
It handles authentication, pagination, and API structure internally, allowing users to focus on data retrieval and interaction logic rather than protocol details.
By supporting both reading data from and writing data to Bluesky, `bskyr` enables reproducible workflows that cover data collection, analysis, and programmatic engagement with the platform.
This makes it a valuable tool for researchers, developers, and analysts working with social data in R.

Finally, `bskyr` offers flexibility in inputs and outputs.
All core operations are supported with automatic tidying of data into familiar tidy formats from the `tidyverse` [@wickham2019welcome].
Users can opt out of cleaning returned data, allowing them to read in raw JSON as native R lists.
Similarly, users can use `bskyr` to handle the uploads, but pass their own list objects.

# Software design

The package attempts to balance tidiness with a light touch to avoid blocking future features as they become supported by the upstream API.
The core goals of Bluesky and downstream clients differ greatly.
Bluesky's overall service and underlying data are designed to support a complete social media service, while clients primarily download data or create data at a much smaller scale.

R packages on CRAN are limited to monthly updates, whereas upstream APIs can change frequently, so the package is designed to be robust to changes in the Bluesky Social API.
Most, if not all, processing of data is optional, with an explicit opt-out via the `clean` argument.
For the remainder, columns are processed based on their length and type.
This avoids hard-coding any specific names or types that may change in the future.
Of course, these can still break if a column's meaning is changed upstream, though such changes have been rare.
This choice requires careful, manual updates any time the upstream API changes meaningfully, but will automatically work for any minor updates.

# State of the field

When development started, `bskyr` was the only R package available for interacting with Bluesky Social.
It has grown to be the most downloaded R package for using Bluesky Social.
`atrrr` [@atrrr], another R package, provides similar functionality for the primary posting and data collection features and is built with automatic parsing of Bluesky's lexicons.
However, it only exports functions for a smaller set of endpoints than those supported by `bskyr`.

Programmatic access to the Bluesky Social API is available in several other languages.
Notably, Bluesky Social provides its own official Typescript package and python has a popular AT Protocol SDK [@atproto].
Given the absence of any R alternatives at the beginning of development, `bskyr` was started to provide R users direct access to Bluesky Social.
Additionally, studies of social media platforms are frequent in social science research, where the R language is most common.
Further, developing an R package, rather than using packages from other languages, allows the use of `tidyverse`-style data frames with nested columns, which simplify this type of data analysis workflow in R.

# Research impact statement

Bluesky Social is a relatively new social media platform, but has already seen significant adoption.
Due to the decentralized design, researchers can use `bskyr` in support of a wide range of social media research, from running experiments to collecting data for observational studies.

`bskyr` is available on CRAN and has been downloaded at least 20,000 times since its release.
Every function is fully documented and contains examples of function-by-function use.
The package contains 3 vignettes which provide long-form examples of how to use the package.

The package itself is available under the MIT license.
All development occurs on GitHub, where users can find latest releases, report issues, and contribute to the codebase.
Tests are run after every commit on GitHub Actions and nightly on CRAN via testthat [@testthat].

# Examples

At its simplest, `bskyr` formats data inputted by users into lists that can be passed to the Bluesky Social API.
It also automates conversion from JSON to an R tibble when users want to read content from Bluesky.
Below demonstrates the simplest workflow for authenticating, making a simple post, and then gathering data from a single endpoint.

Prior to making or collecting content, users must authenticate with Bluesky.
To authenticate, all users need an account with a handle and an app password.

```r
library(bskyr)
bs_auth(user = 'chriskenny.bsky.social', app_password = 'XXXX-XXXX-XXXX-XXX')
```

From there, users can utilize many of the functions in `bskyr` to interact with Bluesky Social.
For example, users can post content to Bluesky Social using the `bs_post` function:

```r
bs_post('Hello, Bluesky!')
```
Users can retrieve nearly all records from Bluesky Social.
For example, users can get information on a specific user using the `bs_get_user` function:

```r
bs_get_user('chriskenny.bsky.social')
```

# AI usage disclosure

No generative AI tools were used in the development of the software or writing of this manuscript.
ChatGPT 4o was used in a limited capacity to improve the coverage of the R package vignettes and all suggestions were manually reviewed.

# References

