#' Speeeding offences detected by static cameras in New Zealand
#'
#' A dataset containing driving speed offences, fines, and vehicle observations by
#' static cameras, in New Zealand between 2009 and 2018.
#'
#' @format A data frame with 5522 rows and 8 variables:
#' \describe{
#'   \item{value}{Number of offences, value of fines in New Zealand dollars, or
#'   number of observations}
#'   \item{series}{Subcategory of offence, fine or observation}
#'   \item{district}{Police district}
#'   \item{area}{Police area (subdivision of district)}
#'   \item{site}{Site code of the site of the camera}
#'   \item{road}{Road name where the camera was sited}
#'   \item{section}{Description of where along the road the camera was sited}
#'   \item{month}{Month of the event}
#' }
#'
#' @details
#'
#' Mobile speed camera data is in the \code{\link{driving_offences}} dataset.
#'
#' General notes and caveats by the New Zealand Police:
#'
#' This data contains provisional data which is drawn from a dynamic operational
#' database. This is subject to change as new information is recorded or
#' recoded.
#'
#' The data does not include cancelled infringements and proceedings, but does
#' include minor infringements cleared as Written Traffic Warnings (WTWs) since
#' the adoption of Police's Written Traffic Warning Policy in 2014. As WTWs do
#' not have a fee these are not included in monetary value tables.
#'
#' Most speed cameras employ radar technology to detect speeding vehicles. The
#' process of issuing a speed camera notice involves verification of the
#' resulting vehicle photo to validate the detection. When counting all vehicles
#' passing speed cameras (i.e., all moving vehicles complying with the speed
#' limit and otherwise), a small number of detections may involve other causes.
#' These cannot be reliably excluded from the total number of detected vehicles
#' as Police record speed camera notice details separately from raw vehicle
#' counts. The total number of vehicles detected by speed cameras on deployment
#' may therefore include a small number of false radar detections. Note also
#' that this data starts from August 2009 as there were some technical issues
#' affecting the roll-out of digital mobile cameras primarily between January
#' and July 2009.
#'
#' @source
#' \url{http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-30june2018.xlsx}
#'
#' @seealso \code{\link{excess}}, \code{\link{fleeing_area}},
#' \code{\link{fleeing_district}}, \code{\link{police_speeding}},
#' \code{\link{police_speeding_band}}, \code{\link{driving_offences}}
"static_camera"
