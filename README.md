<img src="https://raw.githubusercontent.com/matt-dray/stickers/master/output/oystr_hex.png" width="150" align="right">

# oystr

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/matt-dray/oystr.svg?branch=master)](https://travis-ci.org/matt-dray/oystr)
[![Coverage status](https://codecov.io/gh/matt-dray/oystr/branch/master/graph/badge.svg)](https://codecov.io/github/matt-dray/oystr?branch=master)
[![](https://img.shields.io/github/languages/code-size/matt-dray/oystr.svg)](https://github.com/matt-dray/oystr)<!-- badges: end -->

## Purpose

Handle TfL Oyster journey history data. Under development.

You can use an [Oyster card](https://oyster.tfl.gov.uk/oyster/entry.do) to pay for public transit on [Transport for London](https://tfl.gov.uk/) (TfL) services. You can opt-in to monthly emails with your journey history attached as a CSV. Functions in this package help to read, handle and summarise these data.

I, and this package, are not associated officially with TfL.

## Install

The package is under development with no guarantees whatsoever.

Install with `remotes::install_github("matt-dray/oystr")`.

## Functions

Functions under development:

* `oy_read()` reads and checks multiple raw journey history files from a folder
* `oy_clean()` cleans journey history data and engineers new variables
* `oy_lineplot()` to plot features over time (restricted to train journeys for now)
* `oy_summary()` for summarising main statistics (restricted to train and bus journeys only)
* `oy_cols()` contains the TfL colour palette

There's also anonymised journey history data:

* `journeys_read` is an example of anonymised data read with `oy_read()`
* `journeys_clean` is the result of using `oy_clean()` on the `journeys_read` data

## Dependencies

Developing this package is an exercise in working with minimal dependencies (hopefully zero) and working with good ol' base R functions.

## Limitations

The format of these data have remained pretty consistent for a number of years and there's no reason to believe that it will change anytime soon. It could though. In which case, these functions may fail.

Also, I asked TfL for details of all the possible forms of their column 'Journey/Action', which includes things like station start and end, bus route and much more. They were unable to provide this information. Therefore, the `oy_clean()` function can only parse formats that I'm personally aware of (train and bus, mostly) given my own Oyster history data. For example, I know the exact string for bus journeys is "Bus journey, route <number>". I don't know what format this string takes if you travel on a boat, for example.

I would be extremely pleased if someone could share this information.

## Contributing

Please note that the 'oystr' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
