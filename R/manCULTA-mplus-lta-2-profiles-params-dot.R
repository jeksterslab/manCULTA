.MPlusLTA2ProfileParams <- function(p) {
  idx <- seq_len(
    length.out = p
  )
  mu_0 <- paste0(
    "mu_",
    idx,
    "0"
  )
  theta_diag <- paste0(
    "theta_",
    idx,
    idx
  )
  mu_1 <- paste0(
    "mu_",
    idx,
    "1"
  )
  c(
    mu_0,
    theta_diag,
    mu_1,
    "nu_0",
    "alpha_0",
    "kappa_0",
    "beta_00",
    "gamma_00",
    "gamma_10"
  )
}
