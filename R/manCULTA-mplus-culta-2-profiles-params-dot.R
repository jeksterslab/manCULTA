.MPlusCULTA2ProfileParams <- function(p) {
  idx <- seq_len(
    length.out = p
  )
  mu_0 <- paste0(
    "mu_",
    idx,
    "0"
  )
  lt_ls <- as.vector(
    rbind(
      paste0("lambda_t", 2:p),
      paste0("lambda_s", 2:p)
    )
  )
  theta_diag <- paste0(
    "theta_",
    idx,
    idx
  )
  psi_p_diag <- paste0(
    "psi_p_",
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
    lt_ls,
    theta_diag,
    "phi_0",
    "psi_t",
    psi_p_diag,
    "psi_s0",
    "psi_s",
    mu_1,
    "phi_1",
    "nu_0",
    "alpha_0",
    "kappa_0",
    "beta_00",
    "gamma_00",
    "gamma_10"
  )
}
