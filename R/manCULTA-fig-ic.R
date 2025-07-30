#' Plot Information Criteria
#'
#' Plot average information criteria.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param results_ic Summary information criteria results data frame.
#'
#' @examples
#' \dontrun{
#' data(results_ic, package = "manCULTA")
#' FigIC(results_ic)
#' }
#'
#' @family Figure Functions
#' @keywords manCULTA figure
#' @export
FigIC <- function(results_ic) {
  N <- Value <- Model <- NULL
  ggplot2::ggplot(
    data = results_ic[
      which(
        results_ic$Model != "CUTSAR"
      ),
    ],
    ggplot2::aes(
      x = N,
      y = Value,
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
      rows = results_ic$IC
    ) +
    ggplot2::xlab(
      "N"
    ) +
    ggplot2::ylab(
      "Information Criteria"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
