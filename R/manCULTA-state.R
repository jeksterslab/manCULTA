#' Generate a Matrix of State Variates
#' (Common State Plus Unique State)
#'
#' @details The state variate
#'   for item `k` and individual `i`
#'   at time `t`
#'   is decomposed into
#'   common and unique states given by
#'   \deqn{
#'     \mathrm{State}_{k, i, t}
#'     =
#'     \mathrm{Common\ State\ Loading}_{k}
#'     \times \mathrm{Common\ State}_{i, t}
#'     +
#'     \mathrm{Unique\ State}_{k, i, t}
#'   }
#'   where \eqn{
#'     \mathrm{Unique\ State}_{i, t}
#'     \sim \mathcal{N}
#'     \left( 0, \boldsymbol{\theta} \right)
#'   }
#'   and
#'   the common state variate is given by
#'   \deqn{
#'     \mathrm{Common\ State}_{i, t}
#'     =
#'     \beta_{c} \times \mathrm{Common\ State}_{i, t - 1}
#'     +
#'     \zeta_{i, t}
#'   }
#'   where
#'   the initial state variate
#'   \eqn{\mathrm{State}_{i, 0} \sim \mathcal{N} \left( 0, \psi_{s_{0}}\right)}
#'   and
#'   \eqn{\zeta_{i, t} \sim \mathcal{N} \left( 0, \psi_{s}\right)}.
#'   The autoregressive parameter is given by
#'   \deqn{\beta_{c} = \beta_{0} + \left( \beta_{1} - \beta_{0} \right) c}
#'   where
#'   \eqn{\beta_{0}}
#'   and
#'   \eqn{\beta_{1}} are autoregressive order 1 coefficients
#'   for dummy coded 0 and 1 in a two-profile solution.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param common_state Numeric matrix.
#'   `m` by `n` matrix of
#'   values for the common state latent factor.
#' @param common_state_loading Numeric matrix.
#'   `p` by 1 matrix of
#'   factor loadings.
#' @inheritParams UniqueState
#'
#' @return Returns a matrix of common state variates.
#'
#' @examples
#' set.seed(42)
#' n <- 10
#' m <- 6
#' p <- 4
#' q <- 1
#' covariate <- Covariate(
#'   n = n,
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
#'   m = m
#' )
#' common_state <- CommonState2Profiles(
#'   categorical = categorical,
#'   beta_0 = 0,
#'   beta_1 = 0.311,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#' common_state_loading <- matrix(
#'   data = c(1, 1.25, 1.75, 2),
#'   nrow = p,
#'   ncol = 1
#' )
#' State(
#'   common_state,
#'   common_state_loading,
#'   theta = diag(p)
#' )
#' @family Simulation Functions
#' @keywords manCULTA sim state
#' @noRd
State <- function(common_state,
                  common_state_loading,
                  theta) {
  out <- .State(
    common_state = common_state,
    common_state_loading = common_state_loading,
    theta = theta
  )
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
