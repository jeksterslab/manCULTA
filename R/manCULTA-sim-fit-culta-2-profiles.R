#' Simulation Replication - FitCULTA2Profiles
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @inheritParams FitCULTA2Profiles
#' @export
#' @keywords manCULTA fit simulation
SimFitCULTA2Profiles <- function(taskid,
                                 repid,
                                 output_folder,
                                 seed,
                                 suffix,
                                 overwrite,
                                 integrity,
                                 mplus_bin,
                                 starts,
                                 stiterations,
                                 stscale,
                                 max_iter) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_input <- SimFN(
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "fit-culta-2-profiles",
    output_folder = output_folder,
    suffix = suffix
  )
  run <- .SimCheck(
    fn = fn_output,
    overwrite = overwrite,
    integrity = integrity
  )
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
  starting_values <- list(
    nu_0 = nu_0,
    kappa_0 = kappa_0,
    alpha_0 = alpha_0,
    beta_00 = beta_00,
    gamma_00 = gamma_00,
    gamma_10 = gamma_10,
    psi_t = psi_t,
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
  if (run) {
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = FitCULTA2Profiles(
        data = readRDS(fn_input),
        wd = output_folder,
        ncores = 1L,
        mplus_bin = mplus_bin,
        starts = starts,
        stiterations = stiterations,
        stscale = stscale,
        starting_values = starting_values
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
  # rerun
  rerun <- .SimCheck(
    fn = fn_output,
    overwrite = FALSE,
    integrity = FALSE
  )
  if (!rerun) {
    rerun <- !(
      converged(
        readRDS(fn_output)
      )
    )
  }
  iteration <- 0
  starts <- starts + 100
  while (rerun) {
    iteration <- iteration + 1
    starts <- starts + 100
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = FitCULTA2Profiles(
        data = readRDS(fn_input),
        wd = output_folder,
        ncores = 1L,
        mplus_bin = mplus_bin,
        starts = starts,
        stiterations = stiterations,
        stscale = stscale,
        starting_values = starting_values
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
    # rerun
    rerun <- .SimCheck(
      fn = fn_output,
      overwrite = FALSE,
      integrity = FALSE
    )
    if (!rerun) {
      rerun <- !(
        converged(
          readRDS(fn_output)
        )
      )
    }
    if (iteration >= max_iter) {
      message(
        paste0(
          "check taskid: ",
          taskid,
          " ",
          "repid: ",
          repid,
          "\n",
          "Maximum iterations reached.",
          "\n"
        )
      )
      break()
    }
  }
}
