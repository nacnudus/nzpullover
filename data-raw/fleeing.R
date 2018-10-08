url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-31mar2018.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-30june2018.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)

cells <- xlsx_cells(path_source)
formats <- xlsx_formats(path_source)

font_rgb <- formats$local$font$color$rgb
font_size <- formats$local$font$size

fleeing <- dplyr::filter(cells, sheet == "Fleeing Drivers")

corners <-
  fleeing %>%
  dplyr::filter(font_rgb[local_format_id] == "FFFF0000",
                font_size[local_format_id] == 10,
                !is_blank,
                !is.na(character)) %>%
  select(row, col, series = character)

partitions <-
  fleeing %>%
  dplyr::filter(!is_blank,
                font_size[local_format_id] == 10) %>%
  select(row, col, data_type, character, numeric) %>%
  partition(corners)

fleeing_district_tidied <-
  partitions %>%
  dplyr::filter(str_detect(series, regex("district", ignore_case = TRUE))) %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("N", "month") %>%
                       behead("W", "district"))) %>%
  unnest() %>%
  dplyr::filter(month != "Total",
                district != "Sum:") %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(value = numeric, series, district, month)

fleeing_area_tidied <-
  partitions %>%
  dplyr::filter(str_detect(series, regex("area", ignore_case = TRUE))) %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("N", "month") %>%
                       behead("W", "district") %>%
                       behead("W", "area"))) %>%
  unnest() %>%
  dplyr::filter(month != "Total",
                district != "Sum:") %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(value = numeric, series, district, area, month)

write.csv(fleeing_district_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/fleeing-drivers-district.csv.gz"))

write.csv(fleeing_area_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/fleeing-drivers-area.csv.gz"))
