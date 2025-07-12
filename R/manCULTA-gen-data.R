#' Simulate Data
#'
#' The function simulates data using
#' the [GenCULTA2Profiles()] function.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' sim <- GenData(taskid = 1)
#' as.matrix(sim)
#' }
#' @family Data Generation Functions
#' @keywords manCULTA gendata
#' @export
GenData <- function(taskid) {
  param <- params[taskid, ]
  # dimensions
  n <- param$n # number of individuals
  m <- param$m # measurement occasions
  p <- 4 # number of items
  q <- 1 # common trait dimension

  # covariate parameters
  mu_x <- param$mu_x
  sigma_x <- param$sigma_x

  # profile membership and transition parameters
  nu_0 <- param$nu_0
  kappa_0 <- param$kappa_0
  alpha_0 <- param$alpha_0
  beta_00 <- param$beta_00
  gamma_00 <- param$gamma_00
  gamma_10 <- param$gamma_10

  # trait parameters
  psi_t <- matrix(
    data = param$psi_t,
    nrow = 1,
    ncol = 1
  )
  mu_t <- 0
  psi_p <- diag(p)
  diag(psi_p) <- c(
    param$psi_p_11,
    param$psi_p_22,
    param$psi_p_33,
    param$psi_p_44
  )
  mu_p <- rep(
    x = 0,
    times = p
  )
  common_trait_loading <- c(
    1,
    param$lambda_t2,
    param$lambda_t3,
    param$lambda_t4
  )
  common_trait_loading <- matrix(
    data = common_trait_loading,
    nrow = p,
    ncol = q
  )

  # state parameters
  common_state_loading <- c(
    1,
    param$lambda_s2,
    param$lambda_s3,
    param$lambda_s4
  )
  common_state_loading <- matrix(
    data = common_state_loading,
    nrow = p,
    ncol = 1
  )
  phi_0 <- param$phi_0
  phi_1 <- param$phi_1
  psi_s0 <- param$psi_s0
  psi_s <- param$psi_s
  theta <- diag(4)
  diag(theta) <- c(
    param$theta_11,
    param$theta_22,
    param$theta_33,
    param$theta_44
  )
  mu_profile <- cbind(
    c(param$mu_10, param$mu_20, param$mu_30, param$mu_40),
    c(param$mu_11, param$mu_21, param$mu_31, param$mu_41)
  )
  GenCULTA2Profiles(
    n = n,
    m = m,
    mu_x = mu_x,
    sigma_x = sigma_x,
    nu_0 = nu_0,
    kappa_0 = kappa_0,
    alpha_0 = alpha_0,
    beta_00 = beta_00,
    gamma_00 = gamma_00,
    gamma_10 = gamma_10,
    mu_t = mu_t,
    psi_t = psi_t,
    mu_p = mu_p,
    psi_p = psi_p,
    common_trait_loading = common_trait_loading,
    common_state_loading = common_state_loading,
    phi_0 = phi_0,
    phi_1 = phi_1,
    psi_s0 = psi_s0,
    psi_s = psi_s,
    theta = theta,
    mu_profile = mu_profile
  )
}
