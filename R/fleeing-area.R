#' Driving offences in New Zealand
#'
#' A dataset of fleeing-driver incidents in New Zealand between 2009 and 2016,
#' where area-level detail is available.  Total fleeing driver incidents are
#' available with district-level detail only, in the dataset
#' \code{\link{fleeing_district}}.
#'
#' @format A data frame with 3441 rows and 5 variables:
#' \describe{
#'   \item{value}{Number of incidents}
#'   \item{district}{Police district}
#'   \item{area}{Police area (subdivision of district)}
#'   \item{month}{Month of the event}
#' }
#'
#' @details
#' General notes and caveats by the New Zealand Police:
#'
#' This data contains provisional data which is drawn from a dynamic operational
#' database. This is subject to change as new information is recorded or
#' recoded.
#'
#' Police’s Fleeing Driver Policy is based on the premise that drivers who fail
#' to stop for Police and who flee to avoid apprehension pose risks to the
#' public, police employees and themselves. In deciding whether or not to pursue
#' a fleeing driver, Police must balance their responsibility to protect lives
#' with their duty to enforce the law. If the decision is made to pursue, Police
#' must prioritise safety by driving with a high standard of care and
#' professionalism and in a manner appropriate to the situation. Total fleeing
#' driver incidents are available with district-level detail only. Approximately
#' 96% of incidents are were recorded with Area-level detail.
#'
#' @source
#' \url{http://www.police.govt.nz/about-us/publication/road-policing-driver-offence-data-january-2009-september-2016}
#'
#' @seealso \code{\link{driving_offences}}, \code{\link{excess}},
#' \code{\link{fleeing_district}}, \code{\link{police_speeding}}
"fleeing_area"
