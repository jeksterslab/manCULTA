#' Transition Probability from Log-odds Table
#' (2 Profiles)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @details The log-odds transition table for a two-profile model
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
#'   The probability table is given by
#'   \deqn{
#'     \left(
#'       \begin{array}{cc}
#'         \frac{
#'           \exp
#'           \left(
#'             \alpha_{0} + \beta_{00} + \gamma_{00}
#'             \times \mathrm{Covariate}
#'           \right)
#'         }{
#'           \exp
#'           \left(
#'             \alpha_{0} + \beta_{00} + \gamma_{00}
#'             \times \mathrm{Covariate}
#'           \right) + 1
#'         }
#'         &
#'         \frac{1}{
#'           \exp
#'           \left(
#'             \alpha_{0} + \beta_{00} + \gamma_{00}
#'             \times \mathrm{Covariate}
#'           \right) + 1
#'         } \\
#'         \frac{
#'           \exp
#'           \left(
#'             \alpha_{0} + \gamma_{10} \times \mathrm{Covariate}
#'           \right)
#'         }{
#'           \exp
#'           \left(
#'             \alpha_{0} + \gamma_{10} \times \mathrm{Covariate}
#'           \right) + 1
#'         }
#'         &
#'         \frac{1}{
#'           \exp
#'           \left(
#'             \alpha_{0} + \gamma_{10} \times \mathrm{Covariate}
#'           \right) + 1
#'         } \\
#'       \end{array}
#'     \right) .
#'   }
#'
#' @param alpha_0 Numeric.
#'   \eqn{\alpha_{0}} parameter.
#' @param beta_00 Numeric.
#'   \eqn{\beta_{00}} parameter.
#' @param gamma_00 Numeric.
#'   \eqn{\gamma_{00}} parameter.
#' @param gamma_10 Numeric.
#'   \eqn{\gamma_{10}} parameter.
#' @inheritParams InitialProb2Profiles
#'
#' @return Returns a matrix of transition probabilities.
#'
#' @examples
#' x <- 0:40
#' y <- TransitionProb2Profiles(
#'   covariate = x,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094
#' )
#' plot(
#'   x = x,
#'   y = y[, 1],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Remaining in the First Profile" # nolint
#' )
#' plot(
#'   x = x,
#'   y = y[, 2],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Transitioning from the Second Profile to the First Profile" # nolint
#' )
#' plot(
#'   x = x,
#'   y = y[, 3],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Transitioning from the First Profile to the Second Profile" # nolint
#' )
#' plot(
#'   x = x,
#'   y = y[, 4],
#'   type = "l",
#'   xlab = "Covariate",
#'   ylab = "Probability",
#'   main = "Probability of Remaining in the Second Profile" # nolint
#' )
#'
#' @family Simulation Functions
#' @keywords manCULTA sim mixture
#' @noRd
TransitionProb2Profiles <- function(covariate,
                                    alpha_0,
                                    beta_00,
                                    gamma_00,
                                    gamma_10) {
  y1 <- exp(
    alpha_0 + beta_00 + gamma_00 * covariate
  )
  y2 <- exp(
    alpha_0 + gamma_10 * covariate
  )
  y11 <- y1 / (1 + y1)
  y12 <- 1 - y11
  y21 <- y2 / (1 + y2)
  y22 <- 1 - y21
  out <- cbind(
    y11,
    y21,
    y12,
    y22
  )
  colnames(out) <- NULL
  out
}
