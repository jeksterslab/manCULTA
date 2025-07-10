#' Vector of Covariates from the Sample
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of covariates.
#'
#' @examples
#' CovariateSample()
#'
#' @family Simulation Functions
#' @keywords manCULTA sim covariate
#' @noRd
CovariateSample <- function() {
  c(
    rep(x = 2, times = 1),
    rep(x = 3, times = 1),
    rep(x = 4, times = 3),
    rep(x = 5, times = 12),
    rep(x = 6, times = 17),
    rep(x = 7, times = 15),
    rep(x = 8, times = 18),
    rep(x = 9, times = 24),
    rep(x = 10, times = 22),
    rep(x = 11, times = 18),
    rep(x = 12, times = 18),
    rep(x = 13, times = 7),
    rep(x = 14, times = 11),
    rep(x = 15, times = 11),
    rep(x = 16, times = 12),
    rep(x = 17, times = 7),
    rep(x = 18, times = 7),
    rep(x = 19, times = 2),
    rep(x = 20, times = 6),
    rep(x = 21, times = 1),
    rep(x = 22, times = 2),
    rep(x = 24, times = 3),
    rep(x = 25, times = 1),
    rep(x = 27, times = 1),
    rep(x = 28, times = 1),
    rep(x = 31, times = 1)
  )
}
