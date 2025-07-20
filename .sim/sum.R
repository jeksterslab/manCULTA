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

lapply(
  X = seq_len(tasks),
  FUN = Sum,
  reps = reps,
  output_folder = output_folder,
  overwrite = FALSE,
  integrity = TRUE,
  ncores = parallel::detectCores()
)
