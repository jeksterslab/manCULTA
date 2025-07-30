data_process_params <- function(overwrite = FALSE) {
  cat("\ndata_process_params\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  params_file <- file.path(
    data_folder,
    "params.rda"
  )
  if (!file.exists(params_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    n <- seq(
      from = 100,
      to = 500,
      by = 100
    )
    taskid <- seq_len(
      length(n)
    )
    params <- data.frame(
      taskid = taskid,
      n = n
    )

    # parameters
    m <- 6 # measurement occasions
    p <- 4 # number of items
    q <- 1 # common trait dimension

    # covariate parameters
    mu_x <- 0
    sigma_x <- 1

    # profile membership and transition parameters
    nu_0 <- -0.405
    kappa_0 <- 0.10
    alpha_0 <- -0.50
    beta_00 <- 0.85
    gamma_00 <- 0.20
    gamma_10 <- 0.20

    # trait parameters
    psi_t <- 0.30 * diag(1)
    mu_t <- 0
    psi_p <- diag(p)
    psi_p_1 <- 0.3
    psi_p_2 <- 0.3
    psi_p_3 <- 0.3
    psi_p_4 <- 0.3
    diag(psi_p) <- c(
      psi_p_1,
      psi_p_2,
      psi_p_3,
      psi_p_4
    )
    mu_p <- rep(x = 0, times = p)
    common_trait_loading <- matrix(
      data = 1,
      nrow = p,
      ncol = q
    )

    # state parameters
    common_state_loading <- matrix(
      data = 1,
      nrow = p,
      ncol = 1
    )
    phi_0 <- 0.000
    phi_1 <- 0.311
    psi_s0 <- 1.00
    psi_s <- 0.5
    theta <- 0.2 * diag(p)

    # profile-specific means
    mu_profile <- cbind(
      c(2.253, 1.493, 1.574, 1.117),
      c(-0.278, -0.165, -0.199, -0.148)
    )

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
    varnames <- c(
      "m",
      "mu_x",
      "sigma_x",
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
    parameters <- c(
      m,
      mu_x,
      sigma_x,
      mu_profile[, 1],
      common_trait_loading[2, 1],
      common_state_loading[2, 1],
      common_trait_loading[3, 1],
      common_state_loading[3, 1],
      common_trait_loading[4, 1],
      common_state_loading[4, 1],
      diag(theta),
      phi_0,
      c(psi_t),
      diag(psi_p),
      psi_s0,
      psi_s,
      mu_profile[, 2],
      phi_1,
      nu_0,
      alpha_0,
      kappa_0,
      beta_00,
      gamma_00,
      gamma_10
    )
    parameters <- matrix(
      data = rep(
        x = parameters,
        each = length(params$n)
      ),
      nrow = length(params$n)
    )
    colnames(parameters) <- varnames
    params <- cbind(
      params,
      parameters
    )
    save(
      params,
      file = params_file,
      compress = "xz"
    )
  }
}
data_process_params()
rm(data_process_params)
