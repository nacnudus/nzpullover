
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nzpullover

[![Travis-CI Build
Status](https://travis-ci.org/nacnudus/nzpullover.svg?branch=master)](https://travis-ci.org/nacnudus/nzpullover)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/nacnudus/nzpullover?branch=master&svg=true)](https://ci.appveyor.com/project/nacnudus/nzpullover)
[![Cran
Status](http://www.r-pkg.org/badges/version/nzpullover)](https://cran.r-project.org/web/packages/nzpullover/index.html)
[![Cran
Downloads](https://cranlogs.r-pkg.org/badges/nzpullover)](https://www.r-pkg.org/pkg/nzpullover)

The nzpullover package makes available road policing data from the New
Zealand Police in a convenient ‘tidy’ form. Offence categories include
speed, alcohol, red light, restraints (seatbelts), mobile phone, fleeing
drivers, and speeding police vehicles.

The original data published by the New Zealand Police is available as a
spreadsheet here:
<http://www.police.govt.nz/about-us/publication/road-policing-driver-offence-data-january-2009-december-2017>.
Please note that this R package is not associated with the New Zealand
Police.

The spreadsheet data has been made tidy by using the
[tidyxl](https://github.com/nacnudus/tidyxl) and
[unpivotr](https://github.com/nacnudus/unpivotr) packages. See the
scripts in
[/data-raw](https://github.com/nacnudus/nzpullover/tree/master/data-raw).
Zipped csv files are available in
[/inst/extdata](https://github.com/nacnudus/nzpullover/tree/master/inst/extdata).

The New Zealand Police refresh the data approximately quarterly. If this
package lags behind, then please open an issue
<https://github.com/nacnudus/nzpullover/issues>. The CRAN version will
be updated annually.

## Installation

You can install nzpullover from github with:

``` r
# install.packages("devtools")
devtools::install_github("nacnudus/nzpullover")
```

## Example

Scroll to the bottom for lots more graphs.

![](figures/README-example-1.png)![](figures/README-example-2.png)

``` r
glimpse(driving_offences)
#> Observations: 56,957
#> Variables: 6
#> $ category <chr> "Red Light", "Red Light", "Red Light", "Red Light", "...
#> $ value    <dbl> 78, 105, 123, 138, 88, 101, 72, 121, 96, 157, 123, 97...
#> $ series   <chr> "Officer issued red light", "Officer issued red light...
#> $ district <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auck...
#> $ area     <chr> "Auckland Central Area", "Auckland Central Area", "Au...
#> $ month    <date> 2009-01-01, 2009-02-01, 2009-03-01, 2009-04-01, 2009...
glimpse(excess)
#> Observations: 19,929
#> Variables: 6
#> $ value    <dbl> 27, 84, 109, 66, 17, 3, 4, 1, 14, 82, 133, 62, 24, 6,...
#> $ series   <chr> "Officer-issued excess speed band", "Officer-issued e...
#> $ district <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auck...
#> $ area     <chr> "Auckland Central Area", "Auckland Central Area", "Au...
#> $ speed    <chr> "<11", "11-15", "16-20", "21-25", "26-30", "31-35", "...
#> $ month    <date> 2009-12-01, 2009-12-01, 2009-12-01, 2009-12-01, 2009...
glimpse(fleeing_area)
#> Observations: 3,996
#> Variables: 4
#> $ value    <dbl> 0, 0, 0, 10, 11, 4, 8, 4, 7, 6, 3, 2, 7, 6, 4, 13, 10...
#> $ district <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auck...
#> $ area     <chr> "Auckland Central Area", "Auckland Central Area", "Au...
#> $ month    <date> 2009-01-01, 2009-02-01, 2009-03-01, 2009-04-01, 2009...
glimpse(fleeing_district)
#> Observations: 1,296
#> Variables: 3
#> $ value    <dbl> 10, 14, 26, 22, 24, 17, 27, 19, 21, 15, 18, 14, 19, 1...
#> $ district <chr> "Auckland City", "Auckland City", "Auckland City", "A...
#> $ month    <date> 2009-01-01, 2009-02-01, 2009-03-01, 2009-04-01, 2009...
glimpse(police_speeding)
#> Observations: 6,412
#> Variables: 5
#> $ value    <dbl> 1, 1, 4, 2, 2, 1, 1, 3, 1, 1, 2, 2, 1, 1, 1, 1, 2, 4,...
#> $ series   <chr> "Police vehicle speed - detections by speed camera", ...
#> $ district <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auck...
#> $ area     <chr> "Auckland Central Area", "Auckland Central Area", "Au...
#> $ month    <date> 2010-08-01, 2010-09-01, 2010-10-01, 2011-10-01, 2011...
glimpse(police_speeding_band)
#> Observations: 1,738
#> Variables: 6
#> $ value    <dbl> 5, 1, 3, 2, 1, 3, 1, 1, 2, 1, 1, 1, 1, 1, 1, 15, 4, 1...
#> $ series   <chr> "Police vehicle speed detections by calendar year* an...
#> $ district <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auck...
#> $ area     <chr> "Auckland Central Area", "Auckland Central Area", "Au...
#> $ speed    <chr> "11-15", "16-20", "<11", "11-15", "<11", "11-15", "<1...
#> $ year     <date> 2010-01-01, 2010-01-01, 2011-01-01, 2011-01-01, 2012...
```

## Other New Zealand datasets by the same author:

  - [nzlifetables](https://github.com/nacnudus/nzlifetables) – cohort
    life tables
  - [nzcensus2013](https://github.com/nacnudus/nzcensus2013) – summary
    statistics from the 2013 New Zealand census
  - [nzbabynames](https://github.com/nacnudus/nzbabynames) – the top 100
    baby names annually since 1954, and annual birth
statistics.

## Lots more graphs

![](figures/README-unnamed-chunk-3-1.png)<!-- -->![](figures/README-unnamed-chunk-3-2.png)<!-- -->![](figures/README-unnamed-chunk-3-3.png)<!-- -->![](figures/README-unnamed-chunk-3-4.png)<!-- -->![](figures/README-unnamed-chunk-3-5.png)<!-- -->![](figures/README-unnamed-chunk-3-6.png)<!-- -->![](figures/README-unnamed-chunk-3-7.png)<!-- -->![](figures/README-unnamed-chunk-3-8.png)<!-- -->![](figures/README-unnamed-chunk-3-9.png)<!-- -->![](figures/README-unnamed-chunk-3-10.png)<!-- -->![](figures/README-unnamed-chunk-3-11.png)<!-- -->![](figures/README-unnamed-chunk-3-12.png)<!-- -->![](figures/README-unnamed-chunk-3-13.png)<!-- -->![](figures/README-unnamed-chunk-3-14.png)<!-- -->![](figures/README-unnamed-chunk-3-15.png)<!-- -->![](figures/README-unnamed-chunk-3-16.png)<!-- -->![](figures/README-unnamed-chunk-3-17.png)<!-- -->![](figures/README-unnamed-chunk-3-18.png)<!-- -->![](figures/README-unnamed-chunk-3-19.png)<!-- -->![](figures/README-unnamed-chunk-3-20.png)<!-- -->
