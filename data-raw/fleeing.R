url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-jan2009-sep2006.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-jan2009-sep2006.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)
book <- tidy_xlsx(path_source)

font_rgb <- book$formats$local$font$color$rgb
font_size <- book$formats$local$font$size

fleeing <- book$data[["Fleeing Drivers" ]]

# The first table on the sheet "Fleeing Drivers" is similar to the first
# tranche, except that "Sum:" is in the first, not the second, column, and there
# is no 'area' header.

tidydistrict <- function(.anchor, cells) {
  districts <-
    .anchor %>%
    offset_S(cells, 3) %>%
    extend_S(cells, boundary = ~ character == "Sum:") %>%
    select(row, col, district = character)
  .months <-
    .anchor %>%
    offset_S(cells, 2) %>%
    offset_E(cells, 2) %>%
    extend_E(cells, boundary = ~ is.na(character)) %>%
    filter(character != "Total") %>%
    select(row, col, month = character)
  .years <-
    .months %>%
    offset_N(cells, 1) %>%
    filter(!is.na(content),
           col %in% .months$col) %>%
    select(row, col, year = numeric)
  .data <-
    cells %>%
    filter(row %in% districts$row, col %in% .months$col, !is.na(numeric)) %>%
    select(row, col, value = numeric)
  .data %>%
    NNW(.anchor) %>%
    W(districts) %>%
    N(.months) %>%
    NNW(.years) %>%
    select(-row, -col)
}

get_series <- function(sheet) {
  sheet %>%
    filter(font_rgb[local_format_id] == "FFFF0000", # Red
           font_size[local_format_id] == 10,
           !is.na(character)) %>%
    select(row, col, series = character) %>%
    split(.$row)
}

fleeing_district_tidied <-
  fleeing %>%
  get_series %>%
  .[[1]] %>%
  tidydistrict(fleeing) %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(-year, -series)

# The second table on the sheet "Fleeing Drivers" is similar to the first
# tranche, except that "Sum:" is in the first, not the second, column.

tidyarea <- function(.anchor, cells) {
  districts <-
    .anchor %>%
    offset_S(cells, 3) %>%
    extend_S(cells, boundary = ~ character == "Sum:") %>%
    select(row, col, district = character)
  areas <-
    .anchor %>%
    offset_S(cells, 3) %>%
    offset_E(cells, 1) %>%
    extend_S(cells, boundary = ~ is.na(character)) %>%
    select(row, col, area = character)
  .months <-
    .anchor %>%
    offset_S(cells, 2) %>%
    offset_E(cells, 2) %>%
    extend_E(cells, boundary = ~ is.na(character)) %>%
    filter(character != "Total") %>%
    select(row, col, month = character)
  .years <-
    .months %>%
    offset_N(cells, 1) %>%
    filter(!is.na(content),
           col %in% .months$col) %>%
    select(row, col, year = numeric)
  .data <-
    cells %>%
    filter(row %in% areas$row, col %in% .months$col, !is.na(numeric)) %>%
    select(row, col, value = numeric)
  .data %>%
    NNW(.anchor) %>%
    W(districts) %>%
    W(areas) %>%
    N(.months) %>%
    NNW(.years) %>%
    select(-row, -col)
}

fleeing_area_tidied <-
  fleeing %>%
  get_series %>%
  .[[2]] %>%
  tidyarea(fleeing) %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(-year, -series)

write.csv(fleeing_district_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/fleeing-drivers-district.csv.gz"))
write.csv(general, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/general-offences.csv.gz"))
