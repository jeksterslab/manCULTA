#' Summary (LTAParamsRILTA2Profiles)
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
SumLTAParamsRILTA2Profiles <- function(taskid,
                                       reps,
                                       output_folder,
                                       overwrite,
                                       integrity,
                                       ncores = 1L) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sum` function.
  fn_output <- SimFN(
    output_type = "summary-ltaparams-rilta-2-profiles",
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
        output_type = "fit-rilta-2-profiles",
        output_folder = output_folder,
        suffix = suffix
      )
      raw <- as.data.frame(
        summary(
          object = readRDS(fn_input),
          alpha = 0.05,
          digits = NULL
        )
      )
      raw <- raw[
        c(
          "mu_10",
          "mu_20",
          "mu_30",
          "mu_40",
          "mu_11",
          "mu_21",
          "mu_31",
          "mu_41",
          "theta_11",
          "theta_22",
          "theta_33",
          "theta_44",
          "nu_0",
          "alpha_0",
          "kappa_0",
          "beta_00",
          "gamma_00",
          "gamma_10"
        ),
      ]
      param <- params[taskid, ]
      n <- param$n
      parameter <- c(
        param$mu_10,
        param$mu_20,
        param$mu_30,
        param$mu_40,
        param$mu_11,
        param$mu_21,
        param$mu_31,
        param$mu_41,
        param$theta_11,
        param$theta_22,
        param$theta_33,
        param$theta_44,
        param$nu_0,
        param$alpha_0,
        param$kappa_0,
        param$beta_00,
        param$gamma_00,
        param$gamma_10
      )
      df <- data.frame(
        est = raw$est,
        se = raw$se,
        z = raw$z,
        p = raw$p,
        ll = raw[["2.5%"]],
        ul = raw[["97.5%"]],
        sig = as.integer(
          raw$p < 0.05
        ),
        zero_hit = as.integer(
          raw[["p"]] > 0.05
        ),
        theta_hit = as.integer(
          (
            raw[["2.5%"]] <= parameter
          ) & (
            parameter <= raw[["97.5%"]]
          )
        ),
        sq_error = (raw$est - parameter)^2,
        bias = raw$est - parameter,
        rel_bias = .SimRelBias(
          thetahat = raw$est,
          theta = parameter
        )
      )
      attr(df, "taskid") <- taskid
      attr(df, "n") <- n
      attr(df, "parnames") <- rownames(raw)
      attr(df, "parameter") <- parameter
      attr(df, "method") <- "rilta-2-profiles"
      df
    }
    i <- parallel::mclapply(
      X = seq_len(reps),
      FUN = replication,
      taskid = taskid,
      mc.cores = ncores
    )
    means <- (
      1 / reps
    ) * Reduce(
      f = `+`,
      x = i
    )
    sq_errors <- parallel::mclapply(
      X = i,
      FUN = function(x, means) {
        (means - x)^2
      },
      means = means,
      mc.cores = ncores
    )
    vars <- (
      1 / (reps - 1)
    ) * Reduce(
      f = `+`,
      x = sq_errors
    )
    sds <- sqrt(vars)
    means <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = means$est,
      se = means$se,
      z = means$z,
      p = means$p,
      ll = means$ll,
      ul = means$ul,
      sig = means$sig,
      zero_hit = means$zero_hit,
      theta_hit = means$theta_hit,
      sq_error = means$sq_error,
      bias = means$bias,
      rel_bias = means$rel_bias
    )
    vars <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = vars$est,
      se = vars$se,
      z = vars$z,
      p = vars$p,
      ll = vars$ll,
      ul = vars$ul,
      sig = vars$sig,
      zero_hit = vars$zero_hit,
      theta_hit = vars$theta_hit,
      sq_error = vars$sq_error,
      bias = vars$bias,
      rel_bias = vars$rel_bias
    )
    sds <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = sds$est,
      se = sds$se,
      z = sds$z,
      p = sds$p,
      ll = sds$ll,
      ul = sds$ul,
      sig = sds$sig,
      zero_hit = sds$zero_hit,
      theta_hit = sds$theta_hit,
      sq_error = sds$sq_error,
      bias = sds$bias,
      rel_bias = sds$rel_bias
    )
    means$se_bias <- means$se - sds$est
    means$rel_se_bias <- (means$se - sds$est) / sds$est
    means$rmse <- sqrt(means$sq_error)
    means$coverage <- means$theta_hit
    means$power <- 1 - means$zero_hit
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
