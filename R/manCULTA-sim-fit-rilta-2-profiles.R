#' Simulation Replication - FitRILTA2Profiles
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @inheritParams FitRILTA2Profiles
#' @export
#' @keywords manCULTA fit simulation
SimFitRILTA2Profiles <- function(taskid,
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
    output_type = "fit-rilta-2-profiles",
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
  p <- 4 # number of items
  q <- 1 # common trait dimension

  # profile membership and transition parameters
  nu_0 <- param$nu_0
  kappa_0 <- param$kappa_0
  alpha_0 <- param$alpha_0
  beta_00 <- param$beta_00
  gamma_00 <- param$gamma_00
  gamma_10 <- param$gamma_10

  # trait parameters
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
    common_trait_loading = common_trait_loading,
    theta = theta,
    mu_profile = mu_profile
  )
  if (run) {
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = FitRILTA2Profiles(
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
      object = FitRILTA2Profiles(
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
