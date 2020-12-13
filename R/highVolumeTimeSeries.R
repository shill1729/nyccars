#' Download entire time-series of High-Volume For-Hire records
#'
#' @param from integer representing first month to scrape, i.e. 3 for march
#' @param to integer representing last month to scrape, i.e. 6 for june
#'
#' @description {Scrape all months from \code{from} to \code{to} and combine into
#' one time-series.}
#' @return time-series of data-sets combined
#' @export highVolumeTimeSeries
highVolumeTimeSeries <- function(from = 3, to = 6)
{
  # Loop from March to April
  dataList <- list()
  for(i in from:to)
  {
    mth <- paste("0", i, sep = "")
    print(paste("Scraping", mth))
    dataList[[i-2]] <- scrapeTripData(category = "highvol", month = mth, year = "2020")
  }
  dims <- lapply(dataList, dim)
  dims <- do.call(rbind, dims)
  colnames(dims) <- c("nrows", "ncols")
  rownames(dims) <- c(from:to)
  print(dims)
  if(!all.equal(dims[, 2], dims[, 2]))
  {
    warning("Not all data-sets have same # of column-variables")
  }
  dat <- do.call(dplyr::bind_rows, dataList)
  # # Extract date and time-stamp into separate columns
  output <- data.frame(date = lubridate::as_date(dat$pickup_datetime),
                       weekydays = lubridate::wday(dat$pickup_datetime),
                       hour = lubridate::hour(dat$pickup_datetime),
                       puZone = dat$PULocationID
                       )
  return(output)

}
