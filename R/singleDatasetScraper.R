#' Scrape a single data-set from nyc.gov for tlc trip-record dat
#'
#' @param category either "yellow", "green", "hire", or "highvol"
#' @param month character string representing two digit numerical month, e.g. "01", "02", etc.
#' @param year charcter string representing four-digit numerical year, e.g. "2019", "2019,
#'
#' @description {This function scrapes a single data-set .csv from nyc.gov for TLC trip-record data.
#' The data-set is chosen by category, month and year. The file is relatively large and this scraper takes at least a minute.}
#' @return data.frame
#' @export scrapeTripData
scrapeTripData <- function(category, month, year = "2020")
{
  if(!category %in% c("yellow", "green", "hire", "highvol"))
  {
    stop("argument 'category' must be either 'yellow', 'green', 'hire', or 'highvol")
  }
  if(!is.character(year))
  {
    stop("year must be a string of four digit year, e.g. '2020'")

  }
  if(!is.character(month))
  {
    stop("month must be two digit string e.g. '03' or '11'")
  }
  # The NYT github repo of covid19 daily data
  yellow_url <- "https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_"
  green_url <- "https://s3.amazonaws.com/nyc-tlc/trip+data/green_tripdata_"
  forhire_url <- "https://nyc-tlc.s3.amazonaws.com/trip+data/fhv_tripdata_"
  fhv_url <- "https://nyc-tlc.s3.amazonaws.com/trip+data/fhvhv_tripdata_"
  fileEnd <- ".csv"

  if(category == "yellow")
  {
    url <- paste(yellow_url, year, "-", month, fileEnd, sep = "")
  } else if(category == "green")
  {
    url <- paste(green_url, year, "-", month, fileEnd, sep = "")
  } else if(category == "hire")
  {
    url <- paste(forhire_url, year, "-", month, fileEnd, sep = "")
  } else if(category == "highvol")
  {
    url <- paste(fhv_url, year, "-", month, fileEnd, sep = "")
  }
  temp <- tempfile()
  utils::download.file(url, temp)
  # data <- utils::read.csv(temp)
  if(category == "highvol")
  {
    data <- data.table::fread(temp, select = c("pickup_datetime", "PULocationID"))
  } else
  {
    data <- data.table::fread(temp)
  }
  unlink(temp)
  return(data)
}
