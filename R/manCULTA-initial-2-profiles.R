#' Initial Profile from the Log-odds Table
#' (2 Profiles)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param initial_prob Numeric matrix.
#'   Matrix if initial profile membership probabilities.
#'   See the [InitialProb2Profiles()] function.
#'
#' @examples
#' x <- 0:40
#' initial_prob <- InitialProb2Profiles(
#'   covariate = x,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122
#' )
#' Initial2Profiles(
#'   initial_prob = initial_prob
#' )
#'
#' @return Returns a vector of initial profiles.
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim mixture
#' @noRd
Initial2Profiles <- function(initial_prob) {
  y <- stats::runif(n = nrow(initial_prob))
  as.integer(y < initial_prob[, 2])
}
