<!-- README.md is generated from README.Rmd. Please edit that file -->

# octolog

<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![R-CMD-check](https://github.com/assignUser/octolog/workflows/R-CMD-check/badge.svg)](https://github.com/assignUser/octolog/actions)
[![pkgcheck](https://github.com/assignUser/octolog/actions/workflows/pkgcheck.yaml/badge.svg)](https://github.com/assignUser/octolog/actions/workflows/pkgcheck.yaml)
[![Codecov test coverage](https://codecov.io/gh/assignUser/octolog/branch/main/graph/badge.svg)](https://app.codecov.io/gh/assignUser/octolog?branch=main)
<!-- badges: end -->

Octolog provides a complete[^1] API for Github [workflow commands](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions) that makes it easy to create powerful Github Actions that create readable logs. 

 and makes it possible to signal conditions from within R that will create annotations when used within Github Actions but raise normal R conditions
when used interactively.
![Annotations on files of a PR](man/figures/error.png)

[^1]: The only exception is [`save-state`](https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#sending-values-to-the-pre-and-post-actions) which can only be used in JavaScript actions. 

## Installation

You can install the development version of octolog with either of these options:

``` r
pak::pak("assignUser/octolog")
devtools::install_github("assignUser/octolog")
```

## What are *Github Actions*?
[Github Actions](https://github.com/features/actions) is a powerful,free[^2] [CI](https://devguide.ropensci.org/ci.html) service integrated into every repository on Github. You can use actions created by other users (e.g. the very popular [r-lib/actions](https://github.com/r-lib/actions) collection of R related actions) or create your own customized workflow that fits your needs.

[^2]: For public repositories.

## Example

The best way to see how {octolog} works, is in an actual [workflow](https://github.com/assignUser/octolog/actions/workflows/test-octolog.yaml). For more information please see the [website](assignUser.github.io/octolog) and the vignette [LINK ME]().

## Code of Conduct

Please note that the octolog project is released with a [Contributor Code of Conduct](https://assignuser.github.io/octolog/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
