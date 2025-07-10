#' Initial Profile Membership Probabilities from the Log-odds Table
#' (2 Profiles)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The log-odds table for initial profile membership
#'   for a two-profile model
#'   is given by
#'   \deqn{
#'     \left(
#'       \begin{array}{cc}
#'         \nu_{0} + \kappa_{0} \times \mathrm{Covariate} & 0 \\
#'       \end{array}
#'     \right) .
#'   }
#'   The probability table is given by
#'   \deqn{
#'     \left(
#'       \begin{array}{cc}
#'           \frac{
#'             \exp
#'             \left(
#'               \nu_{0} + \kappa_{0} \times \mathrm{Covariate}
#'             \right)
#'           }{
#'             \exp
#'             \left(
#'               \nu_{0} + \kappa_{0} \times \mathrm{Covariate}
#'             \right) + 1
#'           }
#'           &
#'           \frac{1}{
#'             \exp
#'             \left(
#'               \nu_{0} + \kappa_{0} \times \mathrm{Covariate}
#'             \right) + 1
#'           } \\
#'       \end{array}
#'     \right) .
#'   }
#'
#' @param covariate Numeric.
#'   Covariate value.
#' @param nu_0 Numeric.
#'   \eqn{\nu_{0}} parameter.
#' @param kappa_0 Numeric.
#'   \eqn{\kappa_{0}} parameter.
#'
#' @return Returns a matrix of initial profile membership probabilities.
#'
#' @examples
#' x <- 0:40
#' y <- InitialProb2Profiles(
#'   covariate = x,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122
#' )
#' plot(
#'   x = x,
#'   y = y[, 1],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Profile Membership in the First Group" # nolint
#' )
#' plot(
#'   x = x,
#'   y = y[, 2],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Profile Membership in the Second Group" # nolint
#' )
#'
#' @family Simulation Functions
#' @keywords manCULTA sim mixture
#' @noRd
InitialProb2Profiles <- function(covariate,
                                 nu_0,
                                 kappa_0) {
  y <- exp(
    nu_0 + kappa_0 * covariate
  )
  c0_1 <- y / (1 + y)
  out <- cbind(
    c0_1,
    1 - c0_1
  )
  colnames(out) <- NULL
  out
}
