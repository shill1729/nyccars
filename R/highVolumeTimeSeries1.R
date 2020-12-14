#' Download entire time-series of High-Volume For-Hire records
#'
#' @param month integer representing first month to scrape, i.e. 3 for march
#'
#' @description {Scrape all months from \code{from} to \code{to} and combine into
#' one time-series.}
#' @return time-series of data-sets combined
highVolumeTimeSeries1 <- function(month = 3)
{
  # Loop from March to April
  mth <- paste("0", month, sep = "")
  print(paste("Scraping", mth))
  dat <- scrapeTripData(category = "highvol", month = mth, year = "2020")
  # Extract date, weekday, hour, time-stamp and hour
  print("Extracting dates")
  dates <- lubridate::as_date(dat$pickup_datetime)

  print("Extracting weekdays")
  wkdys <- lubridate::wday(dates)

  print("Extracting time-stamps")
  tstmp <- format(lubridate::fast_strptime(dat$pickup_datetime, format = "%Y-%m-%d %H:%M:%S"), "%H:%M:%S")

  print("Extracting hours")
  hours <- lubridate::hour(dat$pickup_datetime)

  # Combine into one data.frame
  output <- data.frame(dates = dates, weekday = wkdys, time = tstmp, hours = hours, PULocationID = dat$PULocationID)
  return(output)

}
