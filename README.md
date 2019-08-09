<img src="https://raw.githubusercontent.com/matt-dray/stickers/master/output/oystr_hex.png" alt="Hexagonal sticker with an oystercatcher bird on it" width="150" align="right">

# oystr

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/matt-dray/oystr.svg?branch=master)](https://travis-ci.org/matt-dray/oystr)
[![Coverage status](https://codecov.io/gh/matt-dray/oystr/branch/master/graph/badge.svg)](https://codecov.io/github/matt-dray/oystr?branch=master)

_R package and hex sticker under construction._

# Purpose

You can opt-in to monthly emails from [Transport for London](https://tfl.gov.uk/) (TfL) with your [Oyster](https://oyster.tfl.gov.uk/oyster/entry.do) public transport journey history attached as a CSV. Functions in this tiny package help you read and wrangle these data.

I, and this package, are not associated officially with TfL.

# Install

The package is under development with no guarantees whatsoever.

Install with `remotes::install_github("matt-dray/oystr")`.

# Functions

Functions under development:

* `oy_read()` reads multiple raw journey history files from a folder
* `oy_clean()` cleans and engineers journey history data frame object (e.g. separate out columns for 'from' and 'to' journey locations)
* `oy_cols` contains the TfL colour palette

I may add some plotting functions to show journeys over time.

# Dependencies

Developing this package is an exercise in working with minimal dependencies (hopefully zero) and working with good ol' base R functions.

I welcome issues and pull requests with your improvements and suggestions.
