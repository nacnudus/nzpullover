#' Speeding police vehicles in New Zealand
#'
#' A dataset containing speeding vehicle detections (by cameras) of vehicles
#' registered to Police, as well as waivers and fines, in New Zealand between
#' 2009 and 2017.
#'
#' @format A data frame with 6906 rows and 5 variables:
#' \describe{
#'   \item{value}{Number of speeding vehicle detections, number of waivers, or
#'   value of fines in New Zealand dollars}
#'   \item{series}{The thing being counted by \code{value}}
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
#' The data does not include cancelled infringements and proceedings, but does
#' include minor infringements cleared as Written Traffic Warnings (WTWs) since
#' the adoption of Police's Written Traffic Warning Policy in 2014. As WTWs do
#' not have a fee these are not included in monetary value tables.
#'
#' Police speeding data includes only speed camera detections of vehicles
#' registered to Police that were exceeding the speed limit. The data does not
#' include driver occupation or whether the vehicle was being driven while on
#' Police duty; however it could be reasonably presumed that staff were on duty
#' in the vast majority of cases.  Only in special circumstances are contract
#' vehicles and patrol vehicles permitted to be driven whilst off duty.  Police
#' does not maintain a database of officers issued with speeding fines while
#' driving Police vehicles. The table containing waived Police speed offences is
#' a subset of the numbers shown in the top table and include all waived
#' reasons. Specific reasons cannot be determined without review of individual
#' files. However, a notice is generally only waived when a Police officer is
#' undertaking urgent duty driving in response to an incident.  Police employees
#' who travel in excess of the speed limit are treated no differently to members
#' of the public, and depending on the circumstances may be subject to further
#' disciplinary action. All drivers of police vehicles detected travelling in
#' excess of the speed limit are liable for the relevant penalties unless a
#' legal defence applies. The Land Transport (Road User) Rule 2004 lists the
#' legal defences Police have when undertaking urgent duty driving, thereby
#' outlining the criteria for waiving a notice.
#'
#' Please note that Police vehicle speeding data from 2014 onward cannot be
#' compared to previous years due to a change in the way the infringements are
#' recorded. A change to the recording process means that there has been an
#' increase in the number of infringements recorded for 2014 when compared to
#' previous years. This is due to a change of process for speed camera photos of
#' police vehicles with red and blue flashing lights visible in the photographs.
#' Notices are now issued for many of these photos, pending an explanation from
#' the driver rather the previous process of presuming an urgent duty driving
#' defence and not issuing a notice.  "
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
#' affecting the rollout of digital mobile cameras primarily between January and
#' July 2009.
#'
#' @source
#' \url{http://www.police.govt.nz/sites/default/files/publications/road-policing-driver-offence-data-1jan2009-30june2018.xlsx}
#'
#' @seealso \code{\link{driving_offences}}, \code{\link{excess}},
#' \code{\link{fleeing_area}}, \code{\link{fleeing_district}},
#' \code{\link{police_speeding_band}}, \code{\link{static_camera}}
"police_speeding"
