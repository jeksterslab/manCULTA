data_process_params <- function(overwrite = TRUE) {
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
      to = 300,
      by = 100
    )
    mod <- rep(x = 0, times = length(n))
    low <- rep(x = -1, times = length(n))
    hi <- rep(x = 1, times = length(n))
    separation <- c(
      hi,
      mod,
      low
    )
    taskid <- seq_len(
      length(separation)
    )
    params <- data.frame(
      taskid = taskid,
      n = n,
      separation = separation
    )

    # parameters
    m <- 6 # measurement occasions
    p <- 4 # number of items
    q <- 1 # common trait dimension

    # covariate parameters
    mu_x <- 11.4009
    sigma_x <- 24.67566

    # profile membership and transition parameters
    nu_0 <- -3.563
    kappa_0 <- 0.122
    alpha_0 <- -3.586
    beta_00 <- 2.250
    gamma_00 <- 0.063
    gamma_10 <- 0.094

    # trait parameters
    psi_t <- 0.10 * diag(1)
    mu_t <- 0
    # psi_p <- diag(p)
    psi_p <- diag(p)
    psi_p_1 <- 0.10
    psi_p_2 <- 0.10
    psi_p_3 <- 0.50
    psi_p_4 <- 0.50
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
    psi_s <- 0.25
    theta <- 0.15 * diag(p)

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
    for (i in seq_len(length(params$taskid))) {
      if (params[i, "separation"] == 0) {
        # half of the original separation
        mu_profile <- cbind(
          c(1.130, 0.750, 0.790, 0.560),
          c(-0.140, -0.080, -0.100, -0.075)
        )
        params[i, c("mu_10", "mu_20", "mu_30", "mu_40")] <- mu_profile[, 1]
        params[i, c("mu_11", "mu_21", "mu_31", "mu_41")] <- mu_profile[, 2]
      }
      if (params[i, "separation"] == -1) {
        # quarter of original separation
        mu_profile <- cbind(
          c(0.560, 0.370, 0.400, 0.280),
          c(-0.070, -0.040, -0.050, -0.0375)
        )
        params[i, c("mu_10", "mu_20", "mu_30", "mu_40")] <- mu_profile[, 1]
        params[i, c("mu_11", "mu_21", "mu_31", "mu_41")] <- mu_profile[, 2]
      }
    }
    rownames(params) <- params$taskid
    save(
      params,
      file = params_file,
      compress = "xz"
    )
  }
}
data_process_params()
rm(data_process_params)
