#' Simulation Replication - FitRILTA2Profiles
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCULTA fit simulation
SimFitRILTA2Profiles <- function(taskid,
                                 repid,
                                 output_folder,
                                 seed,
                                 suffix,
                                 overwrite,
                                 integrity) {
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
        mplus_bin = "mplus",
        starts = c(200, 100),
        stiterations = 200,
        stscale = 2
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
