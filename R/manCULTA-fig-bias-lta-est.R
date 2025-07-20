#' Plot Bias (LTA Estimates)
#'
#' Plot bias for common LTA estimates.
#'
#' @details The parameters are indexed as follows:
#' \describe{
#'   \item{1}{
#'     \eqn{\theta_{11}} parameter.
#'     Unique state variance for item 1.
#'   }
#'   \item{2}{
#'     \eqn{\theta_{22}} parameter.
#'     Unique state variance for item 2.
#'   }
#'   \item{3}{
#'     \eqn{\theta_{33}} parameter.
#'     Unique state variance for item 3.
#'   }
#'   \item{4}{
#'     \eqn{\theta_{44}} parameter.
#'     Unique state variance for item 4.
#'   }
#'   \item{5}{
#'     \eqn{\nu_{0}} parameter.
#'     Intercept for initial log-odds of profile 0
#'     (vs. profile 1) when \eqn{X = 0}.
#'   }
#'   \item{6}{
#'     \eqn{\kappa_{0}} parameter.
#'     Covariate effect on initial profile membership;
#'     higher \eqn{X} increases odds of profile 0.
#'   }
#'   \item{7}{
#'     \eqn{\alpha_{0}} parameter.
#'     Baseline log-odds of being in profile 0 across days.
#'   }
#'   \item{8}{
#'     \eqn{\beta_{00}} parameter.
#'     Increased odds of staying in profile 0
#'     if previously in that profile; reflects persistence.
#'   }
#'   \item{9}{
#'     \eqn{\gamma_{00}} parameter.
#'     Covariate effect on staying in profile 0;
#'     higher \eqn{X} increases persistence.
#'   }
#'   \item{10}{
#'     \eqn{\gamma_{10}} parameter.
#'     Covariate effect on switching from state to profile 0;
#'     higher \eqn{X} increases transition odds.
#'   }
#'   \item{11}{
#'     \eqn{\mu_{10}} parameter.
#'     Profile specific mean for profile 0 and item 1.
#'   }
#'   \item{12}{
#'     \eqn{\mu_{20}} parameter.
#'     Profile specific mean for profile 0 and item 2.
#'   }
#'   \item{13}{
#'     \eqn{\mu_{30}} parameter.
#'     Profile specific mean for profile 0 and item 3.
#'   }
#'   \item{14}{
#'     \eqn{\mu_{40}} parameter.
#'     Profile specific mean for profile 0 and item 4.
#'   }
#'   \item{15}{
#'     \eqn{\mu_{11}} parameter.
#'     Profile specific mean for profile 1 and item 1.
#'   }
#'   \item{16}{
#'     \eqn{\mu_{21}} parameter.
#'     Profile specific mean for profile 1 and item 2.
#'   }
#'   \item{17}{
#'     \eqn{\mu_{31}} parameter.
#'     Profile specific mean for profile 1 and item 3.
#'   }
#'   \item{18}{
#'     \eqn{\mu_{41}} parameter.
#'     Profile specific mean for profile 1 and item 4.
#'   }
#' }
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param results_lta_est Summary LTA estimates results data frame.
#'
#' @examples
#' \dontrun{
#' data(results_lta_est, package = "manCULTA")
#' FigBiasLTAEst(results_lta_est)
#' }
#'
#' @family Figure Functions
#' @keywords manCULTA figure
#' @export
FigBiasLTAEst <- function(results_lta_est) {
  Parameters <- bias <- Model <- NULL
  results_lta_est$Model <- results_lta_est$model
  results_lta_est$Separation <- factor(
    x = results_lta_est$separation,
    levels = c(-1, 0, 1),
    labels = c("LO", "MO", "HI")
  )
  results_lta_est$Parameters <- as.integer(results_lta_est$parnames)
  results_lta_est$n_label <- paste0(
    "N = ",
    results_lta_est$n
  )
  results_lta_est$n_label <- factor(
    results_lta_est$n_label,
    levels = c(
      paste0(
        "N = ",
        sort(unique(results_lta_est$n))
      )
    )
  )
  ggplot2::ggplot(
    data = results_lta_est,
    ggplot2::aes(
      x = Parameters,
      y = bias,
      shape = Model,
      color = Model,
      group = Model,
      linetype = Model
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0.0,
      alpha = 0.5
    ) +
    ggplot2::geom_point(
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      na.rm = TRUE
    ) +
    ggplot2::facet_grid(
      n_label ~ Separation
    ) +
    ggplot2::xlab(
      "Parameter No."
    ) +
    ggplot2::ylab(
      "Bias"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
