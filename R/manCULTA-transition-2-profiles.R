#' Transition Profile from the Log-odds Table
#' (2 Profiles)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param initial_profile Numeric vector.
#'   Vector of initial profiles.
#'   See the [Initial2Profiles()] function.
#' @param transition_prob Numeric matrix.
#'   Transition probabilities.
#'   See the [TransitionProb2Profiles()] function.
#' @param m Positive integer.
#'   Number of measurement occasions.
#'
#' @return Returns a matrix of profiles.
#'
#' @examples
#' x <- 0:40
#' initial_prob <- InitialProb2Profiles(
#'   covariate = x,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122
#' )
#' initial_profile <- Initial2Profiles(
#'   initial_prob = initial_prob
#' )
#' transition_prob <- TransitionProb2Profiles(
#'   covariate = x,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094
#' )
#' m <- 6
#' Transition2Profiles(
#'   initial_profile = initial_profile,
#'   transition_prob = transition_prob,
#'   m = m
#' )
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim mixture
#' @noRd
Transition2Profiles <- function(initial_profile,
                                transition_prob,
                                m) {
  n <- length(initial_profile)
  out <- matrix(
    data = NA_integer_,
    nrow = m,
    ncol = n
  )
  out[1, ] <- initial_profile
  for (t in 2:m) {
    u <- stats::runif(n)
    prev <- out[t - 1, ]
    next_state <- integer(n)
    idx0 <- prev == 0
    idx1 <- !idx0
    # from 0 to 1
    next_state[idx0] <- (
      as.integer(
        u[idx0] < transition_prob[idx0, 3]
      )
    )
    # from 1 to 1
    next_state[idx1] <- as.integer(
      u[idx1] < transition_prob[idx1, 4]
    )
    out[t, ] <- next_state
  }
  class(out) <- c(
    "categoricalstate",
    class(out)
  )
  out
}
