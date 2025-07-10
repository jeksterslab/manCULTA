.MatComponents <- function(x) {
  t(x)
}

#' Coerce an Object of Class `components` to a Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `components`.
#' @param ... Additional arguments.
#'
#' @examples
#' set.seed(42)
#' n <- 10
#' m <- 6
#' p <- 4
#' q <- 1
#' common_trait <- CommonTrait(
#'   n = n,
#'   psi_t = diag(q)
#' )
#' unique_trait <- UniqueTrait(
#'   n = n,
#'   psi_p = diag(p)
#' )
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#' trait <- Trait(
#'   common_trait = common_trait,
#'   unique_trait = unique_trait,
#'   common_trait_loading = common_trait_loading,
#'   grand_mean = NULL
#' )
#' as.matrix(trait)
#'
#' @keywords methods
#' @noRd
as.matrix.components <- function(x,
                                 ...) {
  out <- .MatComponents(x = x)
  class(out) <- class(out)[-1]
  out
}

#' Coerce an Object of Class `components` to a Data Frame
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `components`.
#' @param ... Additional arguments.
#'
#' @examples
#' set.seed(42)
#' n <- 10
#' m <- 6
#' p <- 4
#' q <- 1
#' common_trait <- CommonTrait(
#'   n = n,
#'   psi_t = diag(q)
#' )
#' unique_trait <- UniqueTrait(
#'   n = n,
#'   psi_p = diag(p)
#' )
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#' trait <- Trait(
#'   common_trait = common_trait,
#'   unique_trait = unique_trait,
#'   common_trait_loading = common_trait_loading,
#'   grand_mean = NULL
#' )
#' as.data.frame(trait)
#'
#' @keywords methods
#' @noRd
as.data.frame.components <- function(x,
                                     ...) {
  as.data.frame(
    as.matrix.components(x)
  )
}
