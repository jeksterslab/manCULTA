# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 5L
reps <- 1000L
overwrite <- FALSE
seed <- NULL
mplus_bin <- "mplus"
starts <- c(500, 100)
stiterations <- 200
stscale <- 2
max_iter <- 0
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
