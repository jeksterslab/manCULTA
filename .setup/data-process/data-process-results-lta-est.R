data_process_results_lta_est <- function(overwrite = TRUE) {
  cat("\ndata_process_results_lta_est\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  data_raw <- root$find_file(
    ".setup",
    "data-raw"
  )
  if (!dir.exists(data_raw)) {
    dir.create(
      data_raw,
      recursive = TRUE
    )
  }
  source(
    root$find_file(
      ".setup",
      "r-dependencies",
      "simTools",
      "simTools-sim-suffix-dot.R"
    )
  )
  results_lta_est_file <- file.path(
    data_folder,
    "results_lta_est.rda"
  )
  if (!file.exists(results_lta_est_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    reps <- 5L
    tasks <- 9L
    foo <- function(taskid,
                    reps) {
      suffix <- .SimSuffix(
        taskid = taskid,
        repid = reps
      )
      fn <- file.path(
        data_raw,
        paste0(
          "manCULTA-summary-ltaparams-",
          suffix
        )
      )
      readRDS(fn)
    }
    results_lta_est <- lapply(
      X = seq_len(tasks),
      FUN = foo,
      reps = reps
    )
    results_lta_est <- do.call(
      what = "rbind",
      args = results_lta_est
    )
    results_lta_est$bias <- results_lta_est$parameter - results_lta_est$est
    results_lta_est$separation <- factor(
      x = results_lta_est$separation,
      levels = c("Low", "Moderate", "High")
    )
    results_lta_est$parnames <- factor(
      x = results_lta_est$parnames,
      levels = c(
        "theta_11",
        "theta_22",
        "theta_33",
        "theta_44",
        "nu_0",
        "kappa_0",
        "alpha_0",
        "beta_00",
        "gamma_00",
        "gamma_10",
        "mu_10",
        "mu_20",
        "mu_30",
        "mu_40",
        "mu_11",
        "mu_21",
        "mu_31",
        "mu_41"
      )
    )
    results_lta_est$zero_hit <- NULL
    names(results_lta_est)[names(results_lta_est) == "method"] <- "model"
    rownames(results_lta_est) <- NULL
    save(
      results_lta_est,
      file = results_lta_est_file,
      compress = "xz"
    )
  }
}
data_process_results_lta_est()
rm(data_process_results_lta_est)
