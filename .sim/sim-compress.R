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
    Compress(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder
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
