% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataset-partition.R
\name{hive_partition}
\alias{hive_partition}
\title{Construct Hive partitioning}
\usage{
hive_partition(..., null_fallback = NULL)
}
\arguments{
\item{...}{named list of \link[=data-type]{data types}, passed to \code{\link[=schema]{schema()}}}

\item{null_fallback}{character to be used in place of missing values (\code{NA} or \code{NULL})
in partition columns. Default is \code{"__HIVE_DEFAULT_PARTITION__"},
which is what Hive uses.}
}
\value{
A \link[=Partitioning]{HivePartitioning}, or a \code{HivePartitioningFactory} if
calling \code{hive_partition()} with no arguments.
}
\description{
Hive partitioning embeds field names and values in path segments, such as
"/year=2019/month=2/data.parquet".
}
\details{
Because fields are named in the path segments, order of fields passed to
\code{hive_partition()} does not matter.
}
\examples{
\dontshow{if (arrow_with_dataset()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
hive_partition(year = int16(), month = int8())
\dontshow{\}) # examplesIf}
}
