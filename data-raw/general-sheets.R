url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-30jun2017.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-30jun2017.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)

cells <- xlsx_cells(path_source)
formats <- xlsx_formats(path_source)

font_rgb <- formats$local$font$color$rgb
font_size <- formats$local$font$size

tidy <- function(.anchor, cells) {
  districts <-
    .anchor %>%
    offset_S(cells, 3) %>%
    extend_S(cells, boundary = ~ is.na(character)) %>%
    select(row, col, district = character)
  areas <-
    .anchor %>%
    offset_S(cells, 3) %>%
    offset_E(cells, 1) %>%
    extend_S(cells, boundary = ~ character == "Sum:") %>%
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
    filter(!is_blank,
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

get_series <- function(sheet) {
  sheet %>%
    filter(font_rgb[local_format_id] == "FFFF0000", # Red
           font_size[local_format_id] == 10,
           !is.na(character)) %>%
    select(row, col, series = character) %>%
    split(.$row)
}

tidy_sheets <- function(sheet) {
  # The main series are labelled in red, font-size 10
  sheet %>%
    get_series %>%
    map_df(tidy, cells = sheet)
}

general <-
  cells %>%
  nest(-sheet) %>%
  filter(sheet %in% c("Red Light"
                      , "Restraints"
                      , "Alcohol & Drugs"
                      , "Mobile phone"
                      , "Camera-issued Speed"
                      , "Vehicles past cameras"
                      , "Officer-issued Speed")) %>%
  mutate(data = map(data, tidy_sheets)) %>%
  unnest() %>%
  rename(category = sheet) %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(-year)

police_speeding <- filter(cells, sheet == "Police Speeding")
police_speeding_tidied <-
  police_speeding %>%
  get_series %>%
  map_df(tidy, cells = police_speeding)

police_speeding_band <-
  police_speeding_tidied %>%
  filter(series == "Police vehicle speed detections by calendar year* and speed band") %>%
  rename(speed = month) %>%
  mutate(year = ymd(paste(year, 1, 1)))

police_speeding_tidied <-
  filter(police_speeding_tidied,
        series != "Police vehicle speed detections by calendar year* and speed band") %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(-year)

write.csv(general, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/general-offences.csv.gz"))
write.csv(police_speeding_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/police_speeding.csv.gz"))
write.csv(police_speeding_band, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/police-speeding-band.csv.gz"))
