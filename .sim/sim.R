#!/usr/bin/env Rscript

# SIMULATION ARGUMENTS ---------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manCULTA)
  )
)
source(
  file.path(
    "/scratch",
    Sys.getenv("USER"),
    "manCULTA",
    ".sim",
    "sim-args.R"
  )
)
# ------------------------------------------------------------------------------

# RUN --------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
repid <- as.integer(args[1])
taskid <- as.integer(args[2])
tryCatch(
  {
    Sim(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      overwrite = overwrite,
      integrity = TRUE, # FALSE to prioritize speed, TRUE to prioritize output
      seed = seed,
      mplus_bin = mplus_bin,
      starts = starts,
      stiterations = stiterations,
      stscale = stscale,
      max_iter = max_iter
    )
  },
  error = function(e) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  },
  warning = function(w) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  }
)
warnings()
# ------------------------------------------------------------------------------
