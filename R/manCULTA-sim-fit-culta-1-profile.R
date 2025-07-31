#' Simulation Replication - FitCULTA1Profile
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @inheritParams FitCULTA1Profile
#' @export
#' @keywords manCULTA fit simulation
SimFitCULTA1Profile <- function(taskid,
                                repid,
                                output_folder,
                                seed,
                                suffix,
                                overwrite,
                                integrity,
                                mplus_bin,
                                starts,
                                max_iter) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_input <- SimFN(
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "fit-culta-1-profile",
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

  # trait parameters
  psi_t <- matrix(
    data = param$psi_t,
    nrow = 1,
    ncol = 1
  )
  psi_p <- diag(p)
  diag(psi_p) <- c(
    param$psi_p_11,
    param$psi_p_22,
    param$psi_p_33,
    param$psi_p_44
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
  psi_s0 <- param$psi_s0
  psi_s <- param$psi_s
  theta <- diag(4)
  diag(theta) <- c(
    param$theta_11,
    param$theta_22,
    param$theta_33,
    param$theta_44
  )
  starting_values <- list(
    psi_t = psi_t,
    psi_p = psi_p,
    common_trait_loading = common_trait_loading,
    common_state_loading = common_state_loading,
    psi_s0 = psi_s0,
    psi_s = psi_s,
    theta = theta
  )
  if (run) {
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = FitCULTA1Profile(
        data = readRDS(fn_input),
        wd = output_folder,
        mplus_bin = mplus_bin,
        starts = starts,
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
      object = FitCULTA1Profile(
        data = readRDS(fn_input),
        wd = output_folder,
        mplus_bin = mplus_bin,
        starts = starts,
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
