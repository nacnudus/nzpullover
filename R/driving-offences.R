#' Driving offences in New Zealand
#'
#' A dataset containing driving offences, fines, and vehicle observations by
#' cameras, in New Zealand between 2009 and 2018.
#'
#' The categories of offence are Red Light, Restraints, Alcohol & Drugs, Mobile
#' phone, Mobile-camera-issued Speed, Officer-issued Speed, and Vehicles past
#' cameras.
#'
#' @format A data frame with 62345 rows and 6 variables:
#' \describe{
#'   \item{category}{Type of offence, fine or observation}
#'   \item{value}{Number of offences, value of fines in New Zealand dollars, or
#'   number of observations}
#'   \item{series}{Subcategory of offence, fine or observation}
#'   \item{district}{Police district}
#'   \item{area}{Police area (subdivision of district)}
#'   \item{month}{Month of the event}
#' }
#'
#' @details
#' \describe{
#' \item{Red Light}{Red light running offences at intersections for both
#' vehicles and pedestrians (separated by officer issued and red light camera)}
#' \item{Restraints}{ All restraint use offences (seatbelt and child restraint),
#' excludes restraint equipment offences}
#' \item{Alcohol & Drugs}{Offences relating to driving under the influence of
#' alcohol and drugs (including under 20 year old alcohol infringements) -
#' Alcohol and drug combined offence types are excluded.}
#' \item{Mobile phone}{ Offences for using a hand held device for calling or
#' texting while driving}
#' \item{Camera-issued Speed}{Offences for exceeding the speed limit detected by
#' mobile speed cameras.  Static speed camera data is in the
#' \code{\link{static_camera}} dataset.}
#' \item{Officer-issued Speed}{ Offences for exceeding the speed limit detected
#' by Police officers}
#' \item{Vehicles past cameras}{The number of radar vehicle detections (whether
#' exceeding the speed limit or otherwise) recorded by deployed speed cameras.}
#' }
#'
#' General notes and caveats by the New Zealand Police:
#'
#' This data contains provisional data which is drawn from a dynamic operational
#' database. This is subject to change as new information is recorded or
#' recoded.
#'
#' During entry, a small number of infringements were coded to an incorrect
#' Police Area (e.g., there are a small number of red light offences showing in
#' Wairarapa Area where there are no traffic lights).
#'
#' The data does not include cancelled infringements and proceedings, but does
#' include minor infringements cleared as Written Traffic Warnings (WTWs) since
#' the adoption of Police's Written Traffic Warning Policy in 2014. As WTWs do
#' not have a fee these are not included in monetary value tables.
#'
#' Legislation for the mobile phone, youth zero alcohol driving and lowered
#' adult alcohol driving limit infringement types were introduced in November
#' 2009, August 2011 and December 2014, respectively. These infringement types
#' do not show in the data prior to these months.
#'
#' Alcohol- and drug-specific infringements and proceedings do not include
#' impaired driving offences in which the substance type is not explicitly
#' identified in the offence description. Presently, no drug offences are
#' processed as an infringement notice, so there is no drug-specific monetary
#' fee table.
#'
#' Infringement data resulting from the lowered Adult alcohol impairment limit
#' introduced on 1 December 2014 (250mcg/litre breath and 50mg/100ml blood) are
#' included in the 'Alcohol Specific' tables, and are also broken out into
#' separate tables for convenience.
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
#' \code{\link{police_speeding_band}}, \code{\link{static_camera}}
"driving_offences"
