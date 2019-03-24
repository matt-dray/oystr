# oystr

**Package under development.**

# Description

Handle Personal Oyster Journey Data Provided by Transport for London.

You can opt-in to monthly emails from Transport for London that have your Oyster journey history attached as a CSV. Functions in this small package help you read, wrangle and plot these data.

# Links

* [Oyster online](https://oyster.tfl.gov.uk/oyster/entry.do)
* [Transport for London](https://tfl.gov.uk/) (TfL)

# Functions

Some ideas for functions:

* `oy_read` to read one or more files from a folder (assumes files are raw from TfL)
* `oy_clean` to clean and tidy the data (e.g. separate out columns for 'from' and 'to' journey locations)
* `oy_scatter` for continuous x- and y-axis plots
* `oy_bar` for discrete x-axis plots 
* `oy_pal` for an Oyster colour palette

I'm hoping this will be an exercise in working with minimal dependencies. Hopefully zero.

# Install

The package is under development with no gurantees.

Install with `remotes::install_github("matt-dray/oystr")`.
