#' Generate a Matrix of Observed Variables
#' (2 Profiles)
#'
#' @details The observed variable
#'   for item \eqn{k} and individual \eqn{i}
#'   at occasion \eqn{t}
#'   is given by
#'   \deqn{
#'     Y_{k, i, t}
#'     =
#'     \mu_{k, c}
#'     +
#'     \mathrm{Trait}_{k, i}
#'     +
#'     \mathrm{State}_{k, i, t}
#'   }
#'   where \eqn{\mu_{k, c}} is the profile specific mean,
#'   while \eqn{\mathrm{Trait}_{k, i}}
#'   and \eqn{\mathrm{State}_{k, i, t}}
#'   correspond to the trait and state components of the model.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param mu_profile Numeric matrix.
#'   `p` by 2 matrix of means by profile.
#' @param trait Numeric matrix.
#'   `p` by `n` trait matrix.
#'   Output of the [Trait()] function.
#'   Note that the `grand_mean` argument is equal to `NULL`.
#' @param state Numeric matrix.
#'   `(p * m)` by `n` state matrix.
#'   Output of the [State()] function.
#' @param categorical Numeric matrix (zeros and ones).
#'   `n` by `t` matrix of categories.
#'   Output of the [Categorical2Profiles()] function.
#'
#' @return Returns a matrix of observed variables
#'   generated from the CULTA model with two-profiles.
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
#' covariate <- Covariate(
#'   n = n,
#'   mu_x = 0,
#'   sigma_x = 1
#' )
#' categorical <- Categorical2Profiles(
#'   covariate = covariate,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   m = m
#' )
#' common_state <- CommonState2Profiles(
#'   categorical = categorical,
#'   phi_0 = 0.311,
#'   phi_1 = 0,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#' common_state_loading <- matrix(
#'   data = c(1, 1.25, 1.75, 2),
#'   nrow = p,
#'   ncol = 1
#' )
#' state <- State(
#'   common_state,
#'   common_state_loading,
#'   theta = diag(p)
#' )
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#' TraitState2Profiles(
#'   mu_profile = mu_profile,
#'   trait = trait,
#'   state = state,
#'   categorical = categorical
#' )
#'
#' @family Data Generation Functions
#' @keywords manCULTA sim state trait mixture
#' @noRd
TraitState2Profiles <- function(mu_profile,
                                trait,
                                state,
                                categorical) {
  out <- .TraitState2Profiles(
    mu_profile = mu_profile,
    trait = trait,
    state = state,
    categorical = categorical
  )
  class(out) <- c(
    "components",
    class(out)
  )
  out
}
