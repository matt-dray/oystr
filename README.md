<img src="https://raw.githubusercontent.com/matt-dray/stickers/master/output/oystr_hex.png" alt="Hexagonal sticker with an oystercatcher bird on it" width="150" align="right">

# oystr

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/matt-dray/oystr.svg?branch=master)](https://travis-ci.org/matt-dray/oystr)
[![Coverage status](https://codecov.io/gh/matt-dray/oystr/branch/master/graph/badge.svg)](https://codecov.io/github/matt-dray/oystr?branch=master)

## Purpose

Handle Oyster journey history data.

You can use an [Oyster card](https://oyster.tfl.gov.uk/oyster/entry.do) to pay for public transit on [Transport for London](https://tfl.gov.uk/) (TfL) services. You can opt-in to monthly emails with your journey history attached as a CSV. Functions in this package help to handle these data.

I, and this package, are not associated officially with TfL.

## Install

The package is under development with no guarantees whatsoever.

Install with `remotes::install_github("matt-dray/oystr")`.

## Functions

Functions under development:

* `oy_read()` reads and checks multiple raw journey history files from a folder
* `oy_clean()` cleans journey history data
* `oy_cols()` contains the TfL colour palette

There's also anonymised journey history data:

* `journeys_read` is an example having been read in with `oy_read()`
* `journeys_clean` is the result of using `oy_clean()` on the `journeys_read` data

Maybe in future:

* `oy_plot()` to plot features over time
* `oy_summary()` for summarising main statistics
* more example data files

## Dependencies

Developing this package is an exercise in working with minimal dependencies (hopefully zero) and working with good ol' base R functions.

## Contributing

Please note that the 'oystr' project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project, you agree to abide by its terms.
