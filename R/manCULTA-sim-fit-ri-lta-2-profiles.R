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
        stscale = stscale
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
        stscale = stscale
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
