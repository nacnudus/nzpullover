# nzpullover

[![Travis-CI Build Status](https://travis-ci.org/nacnudus/nzpullover.svg?branch=master)](https://travis-ci.org/nacnudus/nzpullover) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/nacnudus/nzpullover?branch=master&svg=true)](https://ci.appveyor.com/project/nacnudus/nzpullover) ![Cran Status](http://www.r-pkg.org/badges/version/nzpullover) ![Cran Downloads](https://cranlogs.r-pkg.org/badges/nzpullover)

The nzpullover package makes available road policing data from the New Zealand
Police in a convenient 'tidy' form.

The original data published by the New Zealand Police is available as a
spreadsheet here:
[http://www.police.govt.nz/about-us/publication/road-policing-driver-offence-data-january-2009-september-2016](http://www.police.govt.nz/about-us/publication/road-policing-driver-offence-data-january-2009-september-2016).

The spreadsheet data has been made tidy by using the
[tidyxl](https://github.com/nacnudus/tidyxl)
[unpivotr](https://github.com/nacnudus/unpivotr) packages.  See the scripts in
[/data-raw](https://github.com/nacnudus/nzpullover/tree/master/data-raw).

The New Zealand Police refreshes the data approximately quarterly.  If this
package lags behind, then please open an issue
[https://github.com/nacnudus/nzpullover/issues](https://github.com/nacnudus/nzpullover/issues).
