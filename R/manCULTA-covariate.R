#' Generate a Vector of Covariates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param mu_x Numeric.
#'   Mean of covariate.
#' @param sigma_x Numeric.
#'   Variance of covariate.
#' @inheritParams CommonTrait
#'
#' @return Returns a vector of covariates.
#'
#' @examples
#' set.seed(42)
#' Covariate(n = 10, mu_x = 0, sigma_x = 1)
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim covariate
#' @noRd
Covariate <- function(n,
                      mu_x,
                      sigma_x) {
  stats::rnorm(
    n = n,
    mean = mu_x,
    sd = sqrt(sigma_x)
  )
}
