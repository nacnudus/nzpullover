url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-31dec2017.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-31dec2017.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)
library(stringr)

cells <- xlsx_cells(path_source)
formats <- xlsx_formats(path_source)

font_rgb <- formats$local$font$color$rgb
font_size <- formats$local$font$size

tidy <- function(.anchor, cells) {
  districts <-
    .anchor %>%
    offset_S(cells, 4) %>%
    extend_S(cells, boundary = ~ is.na(character)) %>%
    select(row, col, district = character)
  areas <-
    .anchor %>%
    offset_S(cells, 4) %>%
    offset_E(cells, 1) %>%
    extend_S(cells, boundary = ~ character == "Sum:") %>%
    select(row, col, area = character)
  .speeds <-
    .anchor %>%
    offset_S(cells, 3) %>%
    offset_E(cells, 2) %>%
    # Two sequential NAs mark the end of the row
    extend_E(cells, boundary = ~ is.na(character) & is.na(lag(character))) %>%
    filter(character != "Total") %>%
    mutate(character = str_trim(character)) %>%
    select(row, col, speed = character)
  .months <-
    .speeds %>%
    offset_N(cells, 1) %>%
    filter(!is_blank,
           col %in% .speeds$col) %>%
    select(row, col, month = character)
  .years <-
    .speeds %>%
    offset_N(cells, 2) %>%
    filter(!is_blank,
           col %in% .speeds$col) %>%
    select(row, col, year = numeric)
  .data <-
    cells %>%
    filter(row %in% areas$row, col %in% .speeds$col, !is.na(numeric)) %>%
    select(row, col, value = numeric)
  .data %>%
    NNW(.anchor) %>%
    W(districts) %>%
    W(areas) %>%
    N(.speeds) %>%
    NNW(.months) %>%
    NNW(.years) %>%
    select(-row, -col)
}

excess <- filter(cells, sheet == "Speed by Excess Dec-Jan")
excess_tidied <-
  excess %>%
    filter(font_rgb[local_format_id] == "FFFF0000", # Red
           font_size[local_format_id] == 10,
           !is.na(character)) %>%
    select(row, col, series = character) %>%
    split(.$row) %>%
    map_df(tidy, cells = excess) %>%
    mutate(month = ymd(paste(year, month, 1))) %>%
    select(-year)

write.csv(excess_tidied, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/speed-by-excess.csv.gz"))
