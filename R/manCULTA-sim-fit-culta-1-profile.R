#' Simulation Replication - FitCULTA1Profile
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
SimFitCULTA1Profile <- function(taskid,
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
        mplus_bin = "mplus",
        starts = 10
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
