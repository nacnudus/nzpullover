url_source <- "http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-31dec2017.xlsx"
path_source <-  "./inst/extdata/road-policing-driver-offence-data-1jan2009-31dec2017.xlsx"

download.file(url_source, path_source, mode = "wb")

source("./data-raw/general-sheets.R")
source("./data-raw/fleeing.R")
source("./data-raw/speed-by-excess.R")

driving_offences <- general
excess <- excess_tidied
police_speeding <- police_speeding_tidied
police_speeding_band <- police_speeding_band
fleeing_area <- fleeing_area_tidied
fleeing_district <- fleeing_district_tidied

use_data(driving_offences, overwrite = TRUE)
use_data(excess, overwrite = TRUE)
use_data(police_speeding, overwrite = TRUE)
use_data(police_speeding_band, overwrite = TRUE)
use_data(fleeing_area, overwrite = TRUE)
use_data(fleeing_district, overwrite = TRUE)
