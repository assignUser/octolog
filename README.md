
<!-- README.md is generated from README.Rmd. Please edit that file -->

# octolog

<!-- badges: start -->

[![R-CMD-check](https://github.com/assignUser/octolog/workflows/R-CMD-check/badge.svg)](https://github.com/assignUser/octolog/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/assignUser/octolog/branch/main/graph/badge.svg)](https://app.codecov.io/gh/assignUser/octolog?branch=main)
<!-- badges: end -->

Octolog makes it easy to create conditions that create annotations in
Github Action workflows and use the other [workflow
commands](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions)
that are available. \#\# Installation

You can install the development version of octolog like so:

``` r
pak::pak("assignUser/octolog")
```

## Example

Octolog provides drop-in replacements for `cli::cli_warn` and friends:

``` r
library(octolog)

Sys.setenv(GITHUB_ACTIONS = "FALSE")
octo_warn(c("An important warning!", i = "And a tipp how to avoid this warning."))
```

    ## Warning: An important warning!
    ## ℹ And a tipp how to avoid this warning.

``` r
Sys.setenv(GITHUB_ACTIONS = "TRUE")
octo_warn(c("An important warning!", i = "And a tipp how to avoid this warning."))
```

    ## ::warning ::An important warning!%0Aℹ And a tipp how to avoid this warning.
