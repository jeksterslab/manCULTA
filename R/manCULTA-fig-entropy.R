#' Plot Entropy
#'
#' Plot average entropy.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param results_entropy Summary entropy results data frame.
#'
#' @examples
#' \dontrun{
#' data(results_entropy, package = "manCULTA")
#' FigEntropy(results_entropy)
#' }
#'
#' @family Figure Functions
#' @keywords manCULTA figure
#' @export
FigEntropy <- function(results_entropy) {
  N <- Entropy <- Model <- NULL
  ggplot2::ggplot(
    data = results_entropy,
    ggplot2::aes(
      x = N,
      y = Entropy,
      shape = Model,
      color = Model,
      group = Model,
      linetype = Model
    )
  ) +
    ggplot2::geom_point(
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      na.rm = TRUE
    ) +
    ggplot2::facet_grid(
      ~Separation
    ) +
    ggplot2::xlab(
      "Sample Size"
    ) +
    ggplot2::ylab(
      "Entropy"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
