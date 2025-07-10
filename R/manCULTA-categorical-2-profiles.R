#' Generate a Matrix of Categorical Variates
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
#' The log-odds transition table for a two-profile model
#'   is given by
#'   \deqn{
#'     \left(
#'       \begin{array}{cc}
#'         \alpha_{0} + \beta_{00} + \gamma_{00}
#'         \times \mathrm{Covariate} & 0 \\
#' 	       \alpha_{0} + \gamma_{10} \times \mathrm{Covariate} & 0 \\
#'       \end{array}
#'     \right) .
#'   }
#'
#' @inheritParams InitialProb2Profiles
#' @inheritParams TransitionProb2Profiles
#' @inheritParams Transition2Profiles
#'
#' @return Returns a matrix of profiles.
#'
#' @examples
#' x <- 0:40
#' Categorical2Profiles(
#'   covariate = x,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   m = 6
#' )
#'
#' @family Simulation Functions
#' @keywords manCULTA sim mixture
#' @noRd
Categorical2Profiles <- function(covariate,
                                 nu_0,
                                 kappa_0,
                                 alpha_0,
                                 beta_00,
                                 gamma_00,
                                 gamma_10,
                                 m) {
  initial_prob <- InitialProb2Profiles(
    covariate = covariate,
    nu_0 = nu_0,
    kappa_0 = kappa_0
  )
  initial_profile <- Initial2Profiles(
    initial_prob = initial_prob
  )
  transition_prob <- TransitionProb2Profiles(
    covariate = covariate,
    alpha_0 = alpha_0,
    beta_00 = beta_00,
    gamma_00 = gamma_00,
    gamma_10 = gamma_10
  )
  Transition2Profiles(
    initial_profile = initial_profile,
    transition_prob = transition_prob,
    m = m
  )
}
