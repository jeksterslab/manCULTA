data_process_results_fit <- function(overwrite = TRUE,
                                     reps = 5L) {
  cat("\ndata_process_results_fit\n")
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
  results_ic_file <- file.path(
    data_folder,
    "results_ic.rda"
  )
  results_entropy_file <- file.path(
    data_folder,
    "results_entropy.rda"
  )
  if (!file.exists(results_ic_file) || !file.exists(results_entropy_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
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
          "manCULTA-summary-fit-",
          suffix
        )
      )
      readRDS(fn)
    }
    results_fit <- lapply(
      X = seq_len(tasks),
      FUN = foo,
      reps = reps
    )
    results_fit <- as.data.frame(
      do.call(
        what = "rbind",
        args = results_fit
      )
    )
    results_ic <- results_fit
    results_entropy <- results_fit
    # ic
    results_ic$ll <- NULL
    results_ic$df <- NULL
    results_ic$correction <- NULL
    results_ic$entropy <- NULL
    colnames(results_ic) <- c(
      "TaskID",
      "N",
      "Separation",
      "Model",
      "AIC",
      "BIC",
      "aBIC"
    )
    rownames(results_ic) <- NULL
    results_ic <- reshape(
      results_ic,
      varying = c("AIC", "BIC", "aBIC"),
      v.names = "Value",
      timevar = "IC",
      times = c("AIC", "BIC", "aBIC"),
      direction = "long"
    )
    results_ic$IC <- factor(
      x = results_ic$IC,
      levels = c("AIC", "BIC", "aBIC")
    )
    results_ic$id <- NULL
    rownames(results_ic) <- NULL
    save(
      results_ic,
      file = results_ic_file,
      compress = "xz"
    )
    # entropy
    results_entropy <- results_entropy[results_entropy$method != "CUTSAR", ]
    results_entropy$ll <- NULL
    results_entropy$df <- NULL
    results_entropy$correction <- NULL
    results_entropy$aic <- NULL
    results_entropy$bic <- NULL
    results_entropy$abic <- NULL
    colnames(results_entropy) <- c(
      "TaskID",
      "N",
      "Separation",
      "Model",
      "Entropy"
    )
    rownames(results_entropy) <- NULL
    save(
      results_entropy,
      file = results_entropy_file,
      compress = "xz"
    )
  }
}
data_process_results_fit()
rm(data_process_results_fit)
