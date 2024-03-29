% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GenDataKL.R
\name{GenDataKL}
\alias{GenDataKL}
\title{Generate functional/longitudinal data via KL expansion}
\usage{
GenDataKL(n, interval, sparse, regular, meanfun, score, eigfun, sd)
}
\arguments{
\item{n}{number of sample size.}

\item{interval}{A \code{vector} of length two denoting the supporting interval.}

\item{sparse}{A \code{vector} denoting the possible numbers of observation size. The elements are chosen with equal chance. The length of \code{sparse} must be one if \code{regular = TRUE}.}

\item{regular}{Logical; If \code{TRUE}, the observation grids are equally-spaced.}

\item{meanfun}{A function for the mean.}

\item{score}{A \emph{n} by \code{nK} \code{matrix} containing the estimates of the FPC scores, where \code{nK} is the number of FPCs.}

\item{eigfun}{A \code{list} containing the eigenfunctions.}

\item{sd}{A scalar denoting the standard deviation of measurement errors.}
}
\value{
A \code{list} containing the following components:
\item{Lt}{A \code{list} of \emph{n} vectors, where \emph{n} is the sample size. Each entry contains the observation time in ascending order for each subject.}
\item{Ly}{A \code{list} of \emph{n} vectors, where \emph{n} is the sample size. Each entry contains the measurements of each subject at the observation time correspond to \code{Lt}.}
}
\description{
Generate functional/longitudinal data via Karhunen–Loève expansion.
}
\examples{
n <- 100
interval <- c(0, 10)
lambda_1 <- 9 #the first eigenvalue
lambda_2 <- 1.5 #the second eigenvalue
eigfun <- list()
eigfun[[1]] <- function(x){cos(pi * x/10)/sqrt(5)}
eigfun[[2]] <- function(x){sin(pi * x/10)/sqrt(5)}
score <- cbind(rnorm(n, 0, sqrt(lambda_1)), rnorm(n, 0, sqrt(lambda_2)))
DataNew <- GenDataKL(n, interval = interval, sparse = 6:8, regular = FALSE,
                     meanfun = function(x){0}, score = score,
                     eigfun = eigfun, sd = sqrt(0.1))
}
