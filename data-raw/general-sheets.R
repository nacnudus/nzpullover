url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-31mar2018.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-31mar2018.xlsx"

library(tidyxl)
library(unpivotr)
library(tidyverse)
library(lubridate)

cells <- xlsx_cells(path_source)
formats <- xlsx_formats(path_source)

font_rgb <- formats$local$font$color$rgb
font_size <- formats$local$font$size

general_cells <-
  cells %>%
  dplyr::filter(!is_blank,
                sheet %in% c("Red Light",
                             "Restraints",
                             "Alcohol & Drugs",
                             "Mobile phone",
                             "Mobile Speed Camera",
                             "Officer-issued Speed")) %>%
  select(sheet, row, col, data_type, numeric, character, local_format_id)

corners <-
  general_cells %>%
  dplyr::filter(font_rgb[local_format_id] == "FFFF0000",
                font_size[local_format_id] == 10) %>%
  select(sheet, row, col, character) %>%
  nest(-sheet)

general <-
  general_cells %>%
  nest(-sheet) %>%
  dplyr::mutate(data = map2(data, corners$data, partition)) %>%
  unnest() %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("N", "month") %>%
                       behead("W", "district") %>%
                       behead("W", "area") %>%
                       mutate(year = as.character(year)))) %>%
  unnest() %>%
  dplyr::filter(month != "Total", area != "Sum:", !is.na(numeric)) %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(category = sheet, value = numeric, series, district, area, month)

static_camera_cells <-
  cells %>%
  dplyr::filter(!is_blank, sheet == "Static Speed Camera") %>%
  select(row, col, data_type, numeric, character, local_format_id)

static_camera_corners <-
  static_camera_cells %>%
  dplyr::filter(font_rgb[local_format_id] == "FFFF0000",
                font_size[local_format_id] == 10) %>%
  select(row, col, character)

static_camera <-
  static_camera_cells %>%
  partition(static_camera_corners) %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("N", "month") %>%
                       behead("W", "district") %>%
                       behead("W", "area") %>%
                       behead("W", "site", formatters = list(character = str_trim)) %>%
                       behead("W", "road", formatters = list(character = str_trim)) %>%
                       behead("W", "section"))) %>%
  unnest() %>%
  dplyr::filter(month != "Total", section != "Sum:") %>%
  mutate(month = ymd(paste(year, month, 1))) %>%
  select(value = numeric, series, district, area, site, road, section, month)

police_speeding_cells <-
  cells %>%
  dplyr::filter(!is_blank, sheet == "Police Speeding") %>%
  select(row, col, data_type, numeric, character, local_format_id)

police_speeding_corners <-
  police_speeding_cells %>%
  dplyr::filter(font_rgb[local_format_id] == "FFFF0000",
                font_size[local_format_id] == 10) %>%
  select(row, col, character)

police_speeding <-
  police_speeding_cells %>%
  partition(police_speeding_corners) %>%
  mutate(cells = map(cells,
                     ~ .x %>%
                       behead("NNW", "series") %>%
                       behead("NNW", "year") %>%
                       behead("N", "month/speed") %>%
                       behead("W", "district") %>%
                       behead("W", "area"))) %>%
  unnest() %>%
  dplyr::filter(`month/speed` != "Total", area != "Sum:")

police_speeding_band <-
  police_speeding %>%
  dplyr::filter(series == "Police vehicle speed detections by calendar year* and speed band") %>%
  mutate(speed = `month/speed`, year = ymd(paste(year, 1, 1))) %>%
  select(value = numeric, series, district, area, speed, year)

police_speeding_tidied <-
  police_speeding %>%
  dplyr::filter(series != "Police vehicle speed detections by calendar year* and speed band") %>%
  mutate(month = ymd(paste(year, `month/speed`, 1))) %>%
  select(value = numeric, series, district, area, month)

write.csv(general, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/general-offences.csv.gz"))
write.csv(static_camera, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/static-camera.csv.gz"))
write.csv(police_speeding, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/police_speeding.csv.gz"))
write.csv(police_speeding_band, row.names = FALSE, quote = FALSE,
          file=gzfile("./inst/extdata/police-speeding-band.csv.gz"))
