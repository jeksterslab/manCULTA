#' Generate a Matrix of Unique State Variates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams CommonTrait
#' @param theta Numeric matrix.
#'   Positive definite covariance matrix
#'   \eqn{\boldsymbol{\Theta}}.
#'   The covariance matrix of the unique states.
#'
#' @return Returns a matrix of unique trait variates.
#'
#' @examples
#' set.seed(42)
#' UniqueState(n = 10, theta = diag(2))
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim state
#' @noRd
UniqueState <- function(n,
                        theta) {
  out <- .RandMultiNorm(
    n = n,
    sigma = theta
  )
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
