
# nyccars

<!-- badges: start -->
<!-- badges: end -->

The goal of nyccars is to scrape data from nyc.gov and provide some formatting (not implemented yet)

## Installation

You can install the released version of nyccars from github via devtools::

``` r
devtools::install_github("shill1729/nyccars")
```

## Example

This is a basic scraping example. The function will print the dimensions of each individual data-set and give a warning if they have different number of column-variables.

``` r
library(nyccars)
# Download and combine data-set time-series for march and april of 2020
# for high-volume for-hire trips

# Takes about a minute or two
dat <- highVolumeTimeSeries(from = 3, to = 4)
```

Similarly download the entire March to June range via

```r
library(nyccars)
# Will probably take a lot longer.
dat <- highVolumeTimeSeries(from = 3, to = 6)
```
