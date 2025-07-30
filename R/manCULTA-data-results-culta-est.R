#' Simulation Results (CULTA Estimates)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @docType data
#' @name results_culta_est
#' @usage data(results_culta_est)
#' @format A dataframe with 165 rows and 22 columns:
#'
#' \describe{
#'   \item{taskid}{
#'     Task ID.
#'   }
#'   \item{replications}{
#'     Number of replications.
#'   }
#'   \item{parnames}{
#'     Parameter names
#'   }
#'   \item{parameter}{
#'     Population parameter value.
#'   }
#'   \item{model}{
#'     Fitted model.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{est}{
#'     Mean parameter estimate.
#'   }
#'   \item{se}{
#'     Mean standard error.
#'   }
#'   \item{z}{
#'     Mean \eqn{z} statistic.
#'   }
#'   \item{p}{
#'     Mean \eqn{p}-value.
#'   }
#'   \item{ll}{
#'     Mean lower limit of the 95% confidence interval.
#'   }
#'   \item{ul}{
#'     Mean upper limit of the 95% confidence interval.
#'   }
#'   \item{sig}{
#'     Proportion of statistically significant results.
#'   }
#'   \item{theta_hit}{
#'     Proportion of replications
#'     where the confidence intervals
#'     contained the population parameter.
#'   }
#'   \item{sq_error}{
#'     Mean squared error.
#'   }
#'   \item{bias}{
#'     Bias.
#'   }
#'   \item{rel_bias}{
#'     Relative bias.
#'   }
#'   \item{se_bias}{
#'     Bias in standard error estimate.
#'   }
#'   \item{rel_se_bias}{
#'     Relative bias in standard error estimate.
#'   }
#'   \item{rmse}{
#'     Root mean square error.
#'   }
#'   \item{coverage}{
#'     Coverage probability.
#'   }
#'   \item{power}{
#'     Statistical power.
#'   }
#' }
#'
#' @keywords data parameters
"results_culta_est"
