# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 9L
reps <- 1000L
overwrite <- FALSE
seed <- NULL
mplus_bin <- "mplus"
starts <- c(1000, 500)
stiterations <- 200
stscale <- 2
max_iter <- 100
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
