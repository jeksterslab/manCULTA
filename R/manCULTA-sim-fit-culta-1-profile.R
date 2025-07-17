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
  if (run) {
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = FitCULTA1Profile(
        data = readRDS(fn_input),
        wd = output_folder,
        mplus_bin = mplus_bin,
        starts = starts
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
        starts = starts
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
