url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-31mar2018.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-30june2018.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)
library(stringr)

cells <- xlsx_cells(path_source)
formats <- xlsx_formats(path_source)

font_rgb <- formats$local$font$color$rgb
font_size <- formats$local$font$size

excess <- dplyr::filter(cells,
                        sheet == "Speed by Excess Dec-Jan",
                        is.na(character) | character != "Total")

corners <-
  excess %>%
  dplyr::filter(font_rgb[local_format_id] == "FFFF0000",
                font_size[local_format_id] == 10) %>%
  select(row, col, character)

excess_tidied <-
  excess %>%
  partition(corners) %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("NNW", "month") %>%
                       behead("N", "speed",
                              formatters = list(character = str_trim),
                              drop_na = FALSE) %>%
                       behead("W", "district") %>%
                       behead("W", "area"))) %>%
  unnest() %>%
  dplyr::filter(year != "Total", area != "Sum:", !is.na(numeric), !is.na(speed)) %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(value = numeric, series, district, area, speed, month)

write.csv(excess_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/speed-by-excess.csv.gz"))
