#' Summary Method for an Object of Class `categoricalstate`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `categoricalstate`.
#' @param sort Logical.
#'   If `sort = TRUE`, sort results.
#'
#' @param ... additional arguments.
#'
#' @return Returns a table of proportions.
#'
#' @examples
#' out <- Categorical2Profiles(
#'   covariate = CovariateSample(),
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   m = 6
#' )
#' summary(out)
#'
#' @keywords methods
#' @noRd
summary.categoricalstate <- function(object,
                                     sort = TRUE,
                                     ...) {
  patterns <- apply(
    X = object,
    MARGIN = 2,
    FUN = paste0,
    collapse = ""
  )
  prop_table <- prop.table(
    x = table(patterns)
  )
  sort(
    x = prop_table,
    decreasing = TRUE
  )
}
