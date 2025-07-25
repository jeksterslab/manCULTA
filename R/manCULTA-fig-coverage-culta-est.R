#' Plot Coverage Probabilities (CULTA Estimates)
#'
#' Plot coverage probabilities for CULTA estimates.
#'
#' @details Coverage probability is the proportion of simulation replications
#' in which the confidence interval contains the population parameter.
#' The parameters are indexed as follows:
#' \describe{
#'   \item{1}{
#'     \eqn{\psi_{T}} parameter.
#'     Variance in the common trait;
#'     reflects stable between-person differences.
#'   }
#'   \item{2}{
#'     \eqn{\lambda_{t2}} parameter.
#'     Factor loading for the common trait and item 2.
#'   }
#'   \item{3}{
#'     \eqn{\lambda_{t3}} parameter.
#'     Factor loading for the common trait and item 3.
#'   }
#'   \item{4}{
#'     \eqn{\lambda_{t4}} parameter.
#'     Factor loading for the common trait and item 4.
#'   }
#'   \item{5}{
#'     \eqn{\psi_{p11}} parameter.
#'     Trait-specific item 1 variance.
#'   }
#'   \item{6}{
#'     \eqn{\psi_{p22}} parameter.
#'     Trait-specific item 2 variance.
#'   }
#'   \item{7}{
#'     \eqn{\psi_{p33}} parameter.
#'     Trait-specific item 3 variance.
#'   }
#'   \item{8}{
#'     \eqn{\psi_{p44}} parameter.
#'     Trait-specific item 4 variance.
#'   }
#'   \item{9}{
#'     \eqn{\psi_{s0}} parameter.
#'     Initial-day variance of the common state;
#'     reflects variability in intoxication levels at observation start.
#'   }
#'   \item{10}{
#'     \eqn{\psi_{s}} parameter.
#'     Residual state variance over days;
#'     captures within-person daily fluctuations
#'     not explained by trait or AR effects.
#'   }
#'   \item{11}{
#'     \eqn{\lambda_{s2}} parameter.
#'     Factor loading for the common state and item 2.
#'   }
#'   \item{12}{
#'     \eqn{\lambda_{s3}} parameter.
#'     Factor loading for the common state and item 3.
#'   }
#'   \item{13}{
#'     \eqn{\lambda_{s4}} parameter.
#'     Factor loading for the common state and item 4.
#'   }
#'   \item{14}{
#'     \eqn{\theta_{11}} parameter.
#'     Unique state variance for item 1.
#'   }
#'   \item{15}{
#'     \eqn{\theta_{22}} parameter.
#'     Unique state variance for item 2.
#'   }
#'   \item{16}{
#'     \eqn{\theta_{33}} parameter.
#'     Unique state variance for item 3.
#'   }
#'   \item{17}{
#'     \eqn{\theta_{44}} parameter.
#'     Unique state variance for item 4.
#'   }
#'   \item{18}{
#'     \eqn{\nu_{0}} parameter.
#'     Intercept for initial log-odds of profile 0
#'     (vs. profile 1) when \eqn{X = 0}.
#'   }
#'   \item{19}{
#'     \eqn{\kappa_{0}} parameter.
#'     Covariate effect on initial profile membership;
#'     higher \eqn{X} increases odds of profile 0.
#'   }
#'   \item{20}{
#'     \eqn{\alpha_{0}} parameter.
#'     Baseline log-odds of being in profile 0 across days.
#'   }
#'   \item{21}{
#'     \eqn{\beta_{00}} parameter.
#'     Increased odds of staying in profile 0
#'     if previously in that profile; reflects persistence.
#'   }
#'   \item{22}{
#'     \eqn{\gamma_{00}} parameter.
#'     Covariate effect on staying in profile 0;
#'     higher \eqn{X} increases persistence.
#'   }
#'   \item{23}{
#'     \eqn{\gamma_{10}} parameter.
#'     Covariate effect on switching from state to profile 0;
#'     higher \eqn{X} increases transition odds.
#'   }
#'   \item{24}{
#'     \eqn{\mu_{10}} parameter.
#'     Profile specific mean for profile 0 and item 1.
#'   }
#'   \item{25}{
#'     \eqn{\mu_{20}} parameter.
#'     Profile specific mean for profile 0 and item 2.
#'   }
#'   \item{26}{
#'     \eqn{\mu_{30}} parameter.
#'     Profile specific mean for profile 0 and item 3.
#'   }
#'   \item{27}{
#'     \eqn{\mu_{40}} parameter.
#'     Profile specific mean for profile 0 and item 4.
#'   }
#'   \item{28}{
#'     \eqn{\mu_{11}} parameter.
#'     Profile specific mean for profile 1 and item 1.
#'   }
#'   \item{29}{
#'     \eqn{\mu_{21}} parameter.
#'     Profile specific mean for profile 1 and item 2.
#'   }
#'   \item{30}{
#'     \eqn{\mu_{31}} parameter.
#'     Profile specific mean for profile 1 and item 3.
#'   }
#'   \item{31}{
#'     \eqn{\mu_{41}} parameter.
#'     Profile specific mean for profile 1 and item 4.
#'   }
#'   \item{32}{
#'     \eqn{\phi_{0}} parameter.
#'     Autoregressive coefficient for profile 0.
#'   }
#'   \item{33}{
#'     \eqn{\phi_{1}} parameter.
#'     Autoregressive coefficient for profile 1.
#'   }
#' }
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param results_culta_est Summary CULTA estimates results data frame.
#'
#' @examples
#' \dontrun{
#' data(results_culta_est, package = "manCULTA")
#' FigCoverageCULTAEst(results_culta_est)
#' }
#'
#' @family Figure Functions
#' @keywords manCULTA figure
#' @export
FigCoverageCULTAEst <- function(results_culta_est) {
  Parameters <- theta_hit <- Separation <- NULL
  results_culta_est$Model <- results_culta_est$model
  results_culta_est$Separation <- factor(
    x = results_culta_est$separation,
    levels = c(-1, 0, 1),
    labels = c("LO", "MO", "HI")
  )
  results_culta_est$Parameters <- as.integer(results_culta_est$parnames)
  results_culta_est$n_label <- paste0(
    "N = ",
    results_culta_est$n
  )
  results_culta_est$n_label <- factor(
    results_culta_est$n_label,
    levels = c(
      paste0(
        "N = ",
        sort(unique(results_culta_est$n))
      )
    )
  )
  ggplot2::ggplot(
    data = results_culta_est,
    ggplot2::aes(
      x = Parameters,
      y = theta_hit,
      shape = Separation,
      color = Separation,
      group = Separation,
      linetype = Separation
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0.95,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 0.925,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 0.975,
      alpha = 0.5
    ) +
    ggplot2::annotate(
      geom = "rect",
      fill = "grey",
      alpha = 0.50,
      xmin = -Inf,
      xmax = Inf,
      ymin = 0.925,
      ymax = 0.975
    ) +
    ggplot2::geom_point(
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      na.rm = TRUE
    ) +
    ggplot2::facet_grid(
      ~n_label
    ) +
    ggplot2::xlab(
      "Parameter No."
    ) +
    ggplot2::ylab(
      "Coverage Probability"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
