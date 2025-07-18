#' Summary
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCULTA summary simulation
Sum <- function(taskid,
                reps,
                output_folder,
                overwrite,
                integrity) {
  # Do not include default arguments here.
  # All arguments should be set in `.sim/sim-args.R.R`.
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
  SumFitCULTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumFitCULTA1Profile(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumFitLTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumFitRILTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumParamsCULTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumLTAParamsCULTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumLTAParamsLTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumLTAParamsRILTA2Profiles(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  # save model fit results
  culta <- readRDS(
    SimFN(
      output_type = "summary-fit-culta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  culta <- culta$means
  lta <- readRDS(
    SimFN(
      output_type = "summary-fit-lta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  lta <- lta$means
  rilta <- readRDS(
    SimFN(
      output_type = "summary-fit-rilta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  rilta <- rilta$means
  cutsar <- readRDS(
    SimFN(
      output_type = "summary-fit-culta-1-profile",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  cutsar <- cutsar$means
  fit <- as.data.frame(
    rbind(
      cutsar,
      lta,
      rilta,
      culta
    )
  )
  fit$method <- c(
    "CUTSAR",
    "LTA",
    "RILTA",
    "CULTA"
  )
  fit$separation <- factor(
    x = fit$separation,
    levels = c(-1, 0, 1),
    labels = c("LO", "MO", "HI")
  )
  fit_fn <- SimFN(
    output_type = "summary-fit",
    output_folder = output_folder,
    suffix = paste0(
      sprintf(
        "%05d",
        taskid
      ),
      "-",
      sprintf(
        "%05d",
        reps
      ),
      ".Rds"
    )
  )
  saveRDS(
    object = fit,
    file = fit_fn,
    compress = "xz"
  )
  # save lta param results
  culta <- readRDS(
    SimFN(
      output_type = "summary-ltaparams-culta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  culta <- culta$means
  culta$method <- "CULTA"
  lta <- readRDS(
    SimFN(
      output_type = "summary-ltaparams-lta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  lta <- lta$means
  lta$method <- "LTA"
  rilta <- readRDS(
    SimFN(
      output_type = "summary-ltaparams-rilta-2-profiles",
      output_folder = output_folder,
      suffix = paste0(
        sprintf(
          "%05d",
          taskid
        ),
        "-",
        sprintf(
          "%05d",
          reps
        ),
        ".Rds"
      )
    )
  )
  rilta <- rilta$means
  rilta$method <- "RILTA"
  ltaparams <- rbind(
    lta,
    rilta,
    culta
  )
  ltaparams$separation <- factor(
    x = ltaparams$separation,
    levels = c(-1, 0, 1),
    labels = c("LO", "MO", "HI")
  )
  ltaparams_fn <- SimFN(
    output_type = "summary-ltaparams",
    output_folder = output_folder,
    suffix = paste0(
      sprintf(
        "%05d",
        taskid
      ),
      "-",
      sprintf(
        "%05d",
        reps
      ),
      ".Rds"
    )
  )
  saveRDS(
    object = ltaparams,
    file = ltaparams_fn,
    compress = "xz"
  )
}
