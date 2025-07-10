.MPlusCULTA1ProfileParams <- function(p) {
  idx <- seq_len(
    length.out = p
  )
  mu <- paste0(
    "mu_",
    idx
  )
  lt_ls <- as.vector(
    rbind(
      paste0("lambda_t_", 2:p),
      paste0("lambda_s_", 2:p)
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
  c(
    mu,
    lt_ls,
    theta_diag,
    "beta",
    "psi_t",
    psi_p_diag,
    "psi_s0",
    "psi_s"
  )
}
