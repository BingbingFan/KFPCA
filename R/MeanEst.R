#' @title Local linear estimates of mean function
#'
#' @description Local linear estimates of mean function.
#'
#' @param Lt A \code{list} of \emph{n} vectors, where \emph{n} is the sample size. Each entry contains the observation time in ascending order for each subject.
#' @param Ly A \code{list} of \emph{n} vectors, where \emph{n} is the sample size. Each entry contains the measurements of each subject at the observation time correspond to \code{Lt}.
#' @param kern A \code{character} denoting the kernel type; 'epan'(Epanechnikov), 'unif'(Uniform), 'quar'(Quartic), 'gauss'(Gaussian).
#' @param bw A scalar denoting the bandwidth.
#' @param gridout A \code{vector} denoting the time points that the mean function need to be estimated.
#'
#' @return A \code{list} containing the following components:
#' \item{Grid}{A \code{vector} denoting the time points that the mean function need to be estimated.}
#' \item{mean}{A \code{vector} containing the mean function estimates.}
#' @export
#' @examples
#' # Generate data
#' n <- 100
#' interval <- c(0, 10)
#' lambda_1 <- 9 #the first eigenvalue
#' lambda_2 <- 1.5 #the second eigenvalue
#' eigfun <- list()
#' eigfun[[1]] <- function(x){cos(pi * x/10)/sqrt(5)}
#' eigfun[[2]] <- function(x){sin(pi * x/10)/sqrt(5)}
#' score <- cbind(rnorm(n, 0, sqrt(lambda_1)), rnorm(n, 0, sqrt(lambda_2)))
#' DataNew <- GenDataKL(n, interval = interval, sparse = 6:8, regular = FALSE,
#'                      meanfun = function(x){x}, score = score,
#'                      eigfun = eigfun, sd = sqrt(0.1))
#' # Mean function estimate at all observation time points
#' bwOpt <- GetGCVbw1D(DataNew$Lt, DataNew$Ly, kern = "epan")
#' meanest <- MeanEst(DataNew$Lt, DataNew$Ly, kern = "epan", bw = bwOpt,
#'                    gridout = sort(unique(unlist(DataNew$Lt))))
#' plot(meanest$Grid, meanest$mean)
MeanEst <- function(Lt, Ly, kern, bw, gridout){
  xinraw <- unlist(Lt)
  yinraw <- unlist(Ly)

  #time in ascending order
  xin <- sort(xinraw)
  yin <- yinraw[order(xinraw)]

  meanest <- fdapace::Lwls1D(bw, kern, xin = xin, yin = yin, xout = gridout)

  ret <- list()
  ret$Grid <- gridout
  ret$mean <- meanest

  return(ret)
}
