# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 9L
reps <- 1000L
overwrite <- FALSE
seed <- NULL
# ------------------------------------------------------------------------------
output_root <- file.path(
  "/scratch",
  Sys.getenv("USER"),
  "manCULTA",
  ".sim"
)
project <- manCULTA::SimProj()
output_folder <- manCULTA:::.SimPath(
  root = output_root,
  project = project
)
# ------------------------------------------------------------------------------
