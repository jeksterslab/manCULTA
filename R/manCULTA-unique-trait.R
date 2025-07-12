#' Generate a Matrix of Unique Trait Variates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams CommonTrait
#' @param psi_p Numeric matrix.
#'   Positive definite covariance matrix
#'   \eqn{\boldsymbol{\Psi}_{P}}.
#' @param mu_p Numeric vector.
#'   Mean vector
#'   \eqn{\boldsymbol{\mu}_{P}}.
#'   If `mu_p = NULL`,
#'   the mean vector is set to zero.
#'
#' @return Returns a matrix of unique trait variates.
#'
#' @examples
#' set.seed(42)
#' UniqueTrait(n = 10, psi_p = diag(2))
#' UniqueTrait(n = 10, psi_p = diag(2), mu_p = c(1, 1))
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim trait
#' @noRd
UniqueTrait <- function(n,
                        psi_p,
                        mu_p = NULL) {
  if (is.null(mu_p)) {
    out <- .RandMultiNorm(
      n = n,
      sigma = psi_p
    )
  } else {
    out <- .RandMultiNormMean(
      n = n,
      mu = mu_p,
      sigma = psi_p
    )
  }
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
