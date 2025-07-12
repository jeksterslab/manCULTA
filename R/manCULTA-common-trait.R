#' Generate a Matrix of Common Trait Variates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param n Positive integer.
#'   Sample size.
#' @param psi_t Numeric matrix.
#'   Positive definite covariance matrix
#'   \eqn{\boldsymbol{\Psi}_{T}}.
#' @param mu_t Numeric vector.
#'   Mean vector
#'   \eqn{\boldsymbol{\mu}_{T}}.
#'   If `mu_t = NULL`,
#'   the mean vector is set to zero.
#'
#' @return Returns a matrix of common trait variates.
#'
#' @examples
#' set.seed(42)
#' CommonTrait(n = 10, psi_t = diag(2))
#' CommonTrait(n = 10, psi_t = diag(2), mu_t = c(1, 1))
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim trait
#' @noRd
CommonTrait <- function(n,
                        psi_t,
                        mu_t = NULL) {
  if (is.null(mu_t)) {
    out <- .RandMultiNorm(
      n = n,
      sigma = psi_t
    )
  } else {
    out <- .RandMultiNormMean(
      n = n,
      mu = mu_t,
      sigma = psi_t
    )
  }
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
