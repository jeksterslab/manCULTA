#' Generate a Matrix of Trait Variates
#' (Common Trait Plus Unique Trait)
#'
#' @details The trait variate is decomposed into
#'   common and unique traits given by
#'   \deqn{
#'     \mathrm{Trait}_{i}
#'     =
#'     \mathrm{Grand\ Mean}
#'     +
#'     \mathrm{Common\ Trait\ Loading}
#'     \times \mathrm{Common\ Trait}_{i}
#'     +
#'     \mathrm{Unique\ Trait}_{i}
#'   }
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param common_trait Numeric matrix.
#'   `q` by `n` matrix of
#'   values for the common trait latent factor.
#' @param unique_trait Numeric matrix.
#'   `p` by `n` matrix of
#'   values for the unique trait latent factor.
#' @param common_trait_loading Numeric matrix.
#'   `p` by `q` matrix of
#'   factor loadings.
#' @param grand_mean Numeric vector.
#'   `p` by 1 vector of grand mean values.
#'
#' @return Returns a matrix of common trait variates.
#'
#' @examples
#' set.seed(42)
#' n <- 10
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
#' grand_mean <- rep(x = 2, times = p)
#' Trait(
#'   common_trait = common_trait,
#'   unique_trait = unique_trait,
#'   common_trait_loading = common_trait_loading,
#'   grand_mean = grand_mean
#' )
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim trait
#' @noRd
Trait <- function(common_trait,
                  unique_trait,
                  common_trait_loading,
                  grand_mean = NULL) {
  if (is.null(grand_mean)) {
    out <- .Trait(
      common_trait = common_trait,
      unique_trait = unique_trait,
      common_trait_loading = common_trait_loading
    )
  } else {
    out <- .TraitMean(
      common_trait = common_trait,
      unique_trait = unique_trait,
      common_trait_loading = common_trait_loading,
      grand_mean = grand_mean
    )
  }
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
