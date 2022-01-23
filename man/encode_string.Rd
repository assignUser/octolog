% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util.R
\name{encode_string}
\alias{encode_string}
\title{Encode String for Github Actions}
\usage{
encode_string(string)
}
\arguments{
\item{string}{A character vector.}
}
\value{
A character vector.
}
\description{
Encodes a multiline string into one line for Github Action output.
}
\examples{
chrs <- c("100\% This is some output with \n", "a new line")
encode_string(chrs)
}