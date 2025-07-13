#' Scaled Chi-Square Difference Test (Satorra-Bentler Correction)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param ll_higher Log-likelihood of higher (more restricted) model.
#' @param df_higher Number of free parameters in higher model.
#' @param c_higher Scaling correction factor of higher model.
#' @param ll_lower Log-likelihood of lower (less restricted) model.
#' @param df_lower Number of free parameters in lower model.
#' @param c_lower Scaling correction factor of lower model.
#'
#' @return Named numeric vector with
#' scaled chi-square difference,
#' df difference, and
#' p-value.
#' @noRd
.ChiDiffScaled <- function(ll_higher,
                           df_higher,
                           c_higher,
                           ll_lower,
                           df_lower,
                           c_lower) {
  if (df_lower <= df_higher) {
    stop(
      paste0(
        "`df_lower` must be greater than `df_higher`:",
        "\n",
        "Models are not properly nested or ordered."
      )
    )
  }
  chi_diff <- -2 * (ll_higher - ll_lower)
  df_diff <- df_lower - df_higher
  cd <- (
    (df_lower * c_lower) - (df_higher * c_higher)
  ) / df_diff
  td <- chi_diff / cd
  p_value <- stats::pchisq(
    q = td,
    df = df_diff,
    lower.tail = FALSE
  )
  c(
    chi_diff = td,
    df_diff = df_diff,
    p_value = p_value
  )
}
