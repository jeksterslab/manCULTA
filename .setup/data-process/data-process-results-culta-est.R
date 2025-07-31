data_process_results_culta_est <- function(overwrite = FALSE,
                                           tasks = 5L,
                                           reps = 1000L) {
  cat("\ndata_process_results_culta_est\n")
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
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  results_culta_est_file <- file.path(
    data_folder,
    "results_culta_est.rda"
  )
  if (!file.exists(results_culta_est_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    foo <- function(taskid,
                    reps) {
      suffix <- .SimSuffix(
        taskid = taskid,
        repid = reps
      )
      fn <- file.path(
        data_raw,
        paste0(
          "manCULTA-summary-params-culta-2-profiles-",
          suffix
        )
      )
      culta <- readRDS(fn)
      culta <- as.data.frame(
        culta$means
      )
      culta$method <- "CULTA"
      culta
    }
    results_culta_est <- lapply(
      X = seq_len(tasks),
      FUN = foo,
      reps = reps
    )
    results_culta_est <- as.data.frame(
      do.call(
        what = "rbind",
        args = results_culta_est
      )
    )
    # replace relayive bias with absolute bias for parameter == 0
    results_culta_est$rel_bias <- ifelse(
      test = results_culta_est$rel_bias < -999,
      yes = results_culta_est$bias,
      no = results_culta_est$rel_bias
    )
    results_culta_est$parnames <- factor(
      x = results_culta_est$parnames,
      levels = c(
        "phi_0",
        "phi_1",
        "psi_t",
        "lambda_t2",
        "lambda_t3",
        "lambda_t4",
        "psi_p_11",
        "psi_p_22",
        "psi_p_33",
        "psi_p_44",
        "psi_s0",
        "psi_s",
        "lambda_s2",
        "lambda_s3",
        "lambda_s4",
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
    results_culta_est$zero_hit <- NULL
    names(results_culta_est)[names(results_culta_est) == "method"] <- "model"
    rownames(results_culta_est) <- NULL
    save(
      results_culta_est,
      file = results_culta_est_file,
      compress = "xz"
    )
  }
}
data_process_results_culta_est()
rm(data_process_results_culta_est)
