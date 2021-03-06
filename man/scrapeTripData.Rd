% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/singleDatasetScraper.R
\name{scrapeTripData}
\alias{scrapeTripData}
\title{Scrape a single data-set from nyc.gov for tlc trip-record dat}
\usage{
scrapeTripData(category, month, year = "2020")
}
\arguments{
\item{category}{either "yellow", "green", "hire", or "highvol"}

\item{month}{character string representing two digit numerical month, e.g. "01", "02", etc.}

\item{year}{charcter string representing four-digit numerical year, e.g. "2019", "2019,}
}
\value{
data.frame
}
\description{
{This function scrapes a single data-set .csv from nyc.gov for TLC trip-record data.
The data-set is chosen by category, month and year. The file is relatively large and this scraper takes at least a minute.}
}
