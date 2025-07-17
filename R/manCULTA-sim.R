#' Simulation Replication
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @inheritParams FitCULTA2Profiles
#' @export
#' @keywords manCULTA simulation
Sim <- function(taskid,
                repid,
                output_folder,
                overwrite,
                integrity,
                seed,
                mplus_bin,
                starts,
                stiterations,
                stscale,
                max_iter) {
  # Do not include default arguments here.
  # All arguments should be set in `.sim/sim-args.R`.
  # Add taskid to output_folder
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      sprintf(
        "%05d",
        taskid
      )
    )
  )
  if (!file.exists(output_folder)) {
    dir.create(
      path = output_folder,
      showWarnings = FALSE,
      recursive = TRUE
    )
    .SimChMod(output_folder)
  }
  if (is.null(seed)) {
    seed <- .SimSeed(
      taskid = taskid,
      repid = repid
    )
  }
  suffix <- .SimSuffix(
    taskid = taskid,
    repid = repid
  )
  SimGenData(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity
  )
  try(
    SimFitCULTA2Profiles(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      mplus_bin = mplus_bin,
      starts = starts,
      stiterations = stiterations,
      stscale = stscale,
      max_iter = max_iter
    )
  )
  try(
    SimFitLTA2Profiles(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      mplus_bin = mplus_bin,
      starts = starts,
      stiterations = stiterations,
      stscale = stscale,
      max_iter = max_iter
    )
  )
  try(
    SimFitRILTA2Profiles(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      mplus_bin = mplus_bin,
      starts = starts,
      stiterations = stiterations,
      stscale = stscale,
      max_iter = max_iter
    )
  )
  try(
    SimFitCULTA1Profile(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      mplus_bin = mplus_bin,
      starts = starts[1],
      max_iter = max_iter
    )
  )
}
