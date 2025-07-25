#' Generate a Matrix of Common State Variates
#'
#' @details The common state variate is given by
#' \deqn{
#'   \mathrm{Common\ State}_{i, t}
#'   =
#'   \phi_{c} \times \mathrm{Common\ State}_{i, t - 1}
#'   +
#'   \zeta_{i, t}
#' }
#' where
#' the initial state variate
#' \eqn{\mathrm{State}_{i, 0} \sim \mathcal{N} \left( 0, \psi_{s_{0}}\right)}
#' and
#' \eqn{\zeta \sim \mathcal{N} \left( 0, \psi_{s}\right)}.
#' The autoregressive parameter is given by
#' \deqn{\phi_{c} = \phi_{0} + \left( \phi_{1} - \phi_{0} \right) c}
#' where
#' \eqn{\phi_{0}}
#' and
#' \eqn{\phi_{1}} are autoregressive order 1 coefficients
#' for dummy coded 0 and 1 in a two-profile solution.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param categorical Output of [Categorical2Profiles()].
#' @param phi_0 Numeric.
#'   \eqn{\phi_0} parameter.
#' @param phi_1 Numeric.
#'   \eqn{\phi_1} parameter.
#' @param psi_s0 Numeric.
#'   \eqn{\psi_{s_{0}}} parameter.
#' @param psi_s Numeric.
#'   \eqn{\psi_{s}} parameter.
#'
#' @return Returns a matrix of common state variates.
#'
#' @examples
#' set.seed(42)
#' covariate <- Covariate(
#'   n = 10,
#'   mu_x = 0,
#'   sigma_x = 1
#' )
#' categorical <- Categorical2Profiles(
#'   covariate = covariate,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   m = 6
#' )
#' CommonState2Profiles(
#'   categorical = categorical,
#'   phi_0 = 0,
#'   phi_1 = 0.311,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim state
#' @noRd
CommonState2Profiles <- function(categorical,
                                 phi_0,
                                 phi_1,
                                 psi_s0,
                                 psi_s) {
  out <- .CommonState2Profiles(
    categorical = categorical,
    phi_0 = phi_0,
    phi_1 = phi_1,
    psi_s0 = psi_s0,
    psi_s = psi_s
  )
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
