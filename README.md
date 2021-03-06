
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/UBESP-DCTV/garminer.svg?branch=master)](https://travis-ci.org/UBESP-DCTV/garminer)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/UBESP-DCTV/garminer?branch=master&svg=true)](https://ci.appveyor.com/project/UBESP-DCTV/garminer)
[![Coverage
status](https://codecov.io/gh/UBESP-DCTV/garminer/branch/master/graph/badge.svg)](https://codecov.io/github/UBESP-DCTV/garminer?branch=master)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/garminer)](https://cran.r-project.org/package=garminer)

# garminer

The goal of garminer is to provide a set of utility function to extract
information and get insights from Garmin FIT files.

## Installation

You can install the develop version of garminer from
[GITHUB](https://github.com) with:

``` r
# install.packages("devtools")
devtools::install_github("UBESP-DCTV/garminer")
```

## Usage

``` r
suppressPackageStartupMessages(library(garminer))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(RColorBrewer))

cl_monitoring_data <- import_monitoring("data-raw", fit_date = "2018-06-02")
#> Warning: Removed 48 rows containing missing values.
#> Warning: Removed 1 rows containing missing values.

cl_monitoring_data %>% 
    ggplot(aes(`timestamp`, `heart_rate[bpm]`, colour = `heart_rate[bpm]`)) + 
    geom_line() +
    scale_color_gradient(low="blue", high="red",
      name = expression(paste('Heart rate '['bpm']))
    ) +
    ylab(expression(paste('Heart rate '['bpm']))) +
    xlab(expression(paste('Time'))) +
    theme_bw() +
    theme(legend.position = "right") + 
    ggtitle("Hearth Rate along a day", subtitle = "2018-06-02")
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />

## Bug reports

If you encounter a bug, please file a
[reprex](https://github.com/tidyverse/reprex) (minimal reproducible
example) to <https://github.com/UBESP-DCTV/garminer/issues>

## Code of conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
