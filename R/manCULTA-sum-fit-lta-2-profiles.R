#' Summary (FitLTA2Profiles)
#'
#' @details This function is executed via the `Sum` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @import manCULTA
#' @keywords manCULTA summary simulation
SumFitLTA2Profiles <- function(taskid,
                               reps,
                               output_folder,
                               overwrite,
                               integrity,
                               ncores = 1L) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sum` function.
  fn_output <- SimFN(
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
  run <- .SimCheck(
    fn = fn_output,
    overwrite = overwrite,
    integrity = integrity
  )
  if (run) {
    replication <- function(repid,
                            taskid) {
      suffix <- .SimSuffix(
        taskid = taskid,
        repid = repid
      )
      fn_input <- SimFN(
        output_type = "fit-lta-2-profiles",
        output_folder = output_folder,
        suffix = suffix
      )
      object <- readRDS(fn_input)
      ll <- logLik(object)
      df <- attributes(ll)[["df"]]
      correction <- attributes(ll)[["correction"]]
      aic <- AIC(object)
      bic <- BIC(object, adjust = FALSE)
      abic <- BIC(object, adjust = TRUE)
      entropy <- entropy(object)
      param <- params[taskid, ]
      n <- param$n
      separation <- param$separation
      method <- 1
      # 0 culta-2-profiles
      # 1 lta-2-profiles
      # 2 rilt-2-profiles
      # 3 culta-1-profile
      c(
        taskid = taskid,
        n = n,
        separation = separation,
        method = method,
        ll = ll,
        df = df,
        correction = correction,
        aic = aic,
        bic = bic,
        abic = abic,
        entropy = entropy
      )
    }
    i <- parallel::mclapply(
      X = seq_len(reps),
      FUN = replication,
      taskid = taskid,
      mc.cores = ncores
    )
    i <- do.call(
      what = "rbind",
      args = i
    )
    means <- colMeans(i)
    vars <- diag(stats::var(i))
    sds <- sqrt(vars)
    output <- list(
      replications = i,
      means = means,
      vars = vars,
      sds = sds
    )
    saveRDS(
      object = output,
      file = fn_output,
      compress = "xz"
    )
    .SimChMod(fn_output)
  }
}
