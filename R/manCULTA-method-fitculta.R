#' Convergence Status of a Model Fit
#'
#' Checks whether the model fitting procedure for an object of class `fitculta`
#' has successfully converged based on the presence of
#' the string `"THE BEST LOGLIKELIHOOD VALUE HAS BEEN REPLICATED."`
#' in the Mplus output.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @return Logical.
#'   `TRUE` if the model has converged,
#'   `FALSE` otherwise.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' converged(fit)
#' }
#'
#' @keywords methods
#' @export
converged <- function(object,
                      ...) {
  UseMethod("converged")
}

#' Convergence Status of a Model Fit
#'
#' Checks whether the model fitting procedure for an object of class `fitculta`
#' has successfully converged based on the presence of
#' the string `"THE BEST LOGLIKELIHOOD VALUE HAS BEEN REPLICATED."`
#' in the Mplus output.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @return Logical.
#'   `TRUE` if the model has converged,
#'   `FALSE` otherwise.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' converged(fit)
#' }
#'
#' @keywords internal
#' @export
converged.fitculta <- function(object,
                               ...) {
  lines <- object$output$output
  terminated <- grep(
    pattern = "THE MODEL ESTIMATION TERMINATED NORMALLY",
    x = lines,
    value = TRUE
  )
  replicated <- grep(
    pattern = "THE BEST LOGLIKELIHOOD VALUE HAS BEEN REPLICATED",
    x = lines,
    value = TRUE
  )
  if (object$fun == "FitCULTA1Profile") {
    out <- TRUE # assume that the model will always converge
  } else {
    out <- (
      (
        length(x = terminated) > 0
      ) && (
        length(x = replicated) > 0
      )
    )
  }
  out
}

#' Print Method for an Object of Class `fitculta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Prints a matrix of
#'   standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param x Object of class `fitculta`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use `alpha = 0.05`.
#' @param digits Digits to print.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' print(fit)
#' }
#'
#' @keywords methods
#' @export
print.fitculta <- function(x,
                           alpha = NULL,
                           digits = 4,
                           ...) {
  base::print(
    summary.fitculta(
      object = x,
      alpha = alpha,
      digits = digits,
      ...
    )
  )
}

#' Summary Method for an Object of Class `fitculta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of
#'   standardized regression slopes,
#'   standard errors,
#'   test statistics,
#'   p-values,
#'   and
#'   confidence intervals.
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#' @param alpha Numeric vector.
#'   Significance level \eqn{\alpha}.
#'   If `alpha = NULL`,
#'   use `alpha = 0.05`.
#' @param digits Digits to print.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' summary(fit)
#' }
#'
#' @keywords methods
#' @export
summary.fitculta <- function(object,
                             alpha = NULL,
                             digits = 4,
                             ...) {
  if (is.null(alpha)) {
    alpha <- 0.05
  }
  stopifnot(
    all(alpha > 0 & alpha < 1)
  )
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  params <- object$args$params
  est <- results[
    seq_len(length.out = q)
  ]
  se <- results[
    seq_len(length.out = q) + q
  ]
  names(est) <- params
  cat("Call:\n")
  base::print(object$call)
  round(
    .CIWald(
      est = est,
      se = se,
      theta = 0,
      alpha = alpha,
      z = TRUE
    ),
    digits = digits
  )
}

#' Parameter Estimates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a vector of parameter estimates.
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' coef(fit)
#' }
#'
#' @keywords methods
#' @export
coef.fitculta <- function(object,
                          ...) {
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  params <- object$args$params
  est <- results[
    seq_len(length.out = q)
  ]
  names(est) <- params
  est
}

#' Sampling Covariance Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of the
#'   variance-covariance matrix
#'   of parameter estimates.
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' vcov(fit)
#' }
#'
#' @keywords methods
#' @export
vcov.fitculta <- function(object,
                          ...) {
  tech3 <- scan(
    text = object$output$tech3,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  params <- object$args$params
  out <- .SymofVech2(
    x = tech3[
      seq_len(
        length.out = q * (q + 1) / 2
      )
    ],
    k = q
  )
  colnames(out) <- rownames(out) <- params
  out
}

#' Confidence Intervals for Parameter Estimates
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a matrix of confidence intervals.
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#' @param parm a specification of which parameters
#'   are to be given confidence intervals,
#'   either a vector of numbers or a vector of names.
#'   If missing, all parameters are considered.
#' @param level the confidence level required.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' confint(fit, level = 0.95)
#' }
#'
#' @keywords methods
#' @export
confint.fitculta <- function(object,
                             parm = NULL,
                             level = 0.95,
                             ...) {
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  params <- object$args$params
  est <- results[
    seq_len(length.out = q)
  ]
  se <- results[
    seq_len(length.out = q) + q
  ]
  names(est) <- params
  if (is.null(parm)) {
    parm <- seq_len(length.out = q)
  }
  ci <- .CIWald(
    est = est,
    se = se,
    theta = 0,
    alpha = 1 - level[1],
    z = TRUE
  )[parm, 5:6, drop = FALSE] # always z
  varnames <- colnames(ci)
  varnames <- gsub(
    pattern = "%",
    replacement = " %",
    x = varnames
  )
  colnames(ci) <- varnames
  ci
}

#' Extract Log-Likelihood
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an object of class `logLik`.
#'   This is a number with at
#'   the attribute, `"df"` (degrees of freedom),
#'   giving the number of (estimated) parameters in the model,
#'   and `"correction"` which is the scaling correction factor for MLR.
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' logLik(fit, level = 0.95)
#' }
#'
#' @importFrom stats logLik
#' @keywords methods
#' @export
logLik.fitculta <- function(object,
                            ...) {
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  m <- (q * 2)
  if (object$fun == "FitCULTA1Profile") {
    df <- results[m + 1]
    ll <- results[m + 2]
    correction <- results[m + 3]
  } else {
    df <- results[m + 1]
    ll <- results[m + 2]
    correction <- results[m + 3]
  }
  attr(ll, "df") <- df
  attr(ll, "correction") <- correction
  ll
}

#' Akaike's Information Criterion
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns Akaike's information criterion (AIC).
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' AIC(fit)
#' }
#'
#' @importFrom stats AIC
#' @keywords methods
#' @export
AIC.fitculta <- function(object,
                         ...) {
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  m <- (q * 2)
  if (object$fun == "FitCULTA1Profile") {
    aic <- results[m + 6]
  } else {
    aic <- results[m + 4]
  }
  aic
}

#' Bayesian Information Criterion
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns Bayesian information criterion (BIC).
#'
#' @param object Object of class `fitculta`.
#' @param adjust Logical.
#'   If `adjust = TRUE`,
#'   return the sample size adjusted BIC.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' BIC(fit)
#' BIC(fit, adjust = TRUE)
#' }
#'
#' @importFrom stats BIC
#' @keywords methods
#' @export
BIC.fitculta <- function(object,
                         adjust = FALSE,
                         ...) {
  results <- scan(
    text = object$output$results,
    what = numeric(),
    quiet = TRUE
  )
  q <- object$args$q
  m <- (q * 2)
  if (object$fun == "FitCULTA1Profile") {
    if (adjust) {
      bic <- results[m + 8]
    } else {
      bic <- results[m + 7]
    }
  } else {
    if (adjust) {
      bic <- results[m + 6]
    } else {
      bic <- results[m + 5]
    }
  }
  bic
}

#' Entropy
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns Akaike's information criterion (AIC).
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' entropy(fit)
#' }
#'
#' @keywords methods
#' @export
entropy <- function(object,
                    ...) {
  UseMethod("entropy")
}

#' Entropy
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns Akaike's information criterion (AIC).
#'
#' @param object Object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' fit <- FitCULTA2Profiles(data = data)
#' entropy(fit)
#' }
#'
#' @keywords internal
#' @export
entropy.fitculta <- function(object,
                             ...) {
  if (object$fun == "FitCULTA1Profile") {
    entropy <- 0
  } else {
    results <- scan(
      text = object$output$results,
      what = numeric(),
      quiet = TRUE
    )
    q <- object$args$q
    m <- (q * 2)
    entropy <- results[m + 7]
  }
  entropy
}

#' Compare Two Nested `fitculta` Models Using Scaled Chi-Square Difference Test
#'
#' This function compares two `fitculta` models
#' using the Satorra-Bentler scaled chi-square
#' difference test based on log-likelihoods,
#' number of free parameters,
#' and scaling correction factors.
#' It also returns model fit indices for both models,
#' including AIC, BIC, adjusted BIC, and entropy.
#'
#' @param object Model object of class `fitculta`.
#' @param other Another model object of class `fitculta`.
#' @param ... additional arguments.
#'
#' @return A list with two elements:
#' \describe{
#'   \item{`fit`}{A matrix summarizing model fit indices for both models,
#'     including:
#'     \code{logLik},
#'     \code{df} (number of free parameters),
#'     \code{correction} (scaling factor),
#'     \code{AIC},
#'     \code{BIC},
#'     \code{aBIC} (adjusted BIC), and
#'     \code{entropy}.}
#'   \item{`diff`}{A named numeric vector with scaled chi-square difference,
#'   degrees of freedom difference, and p-value.}
#' }
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 1000 # number of individuals
#' m <- 6 # measurement occasions
#' p <- 4 # number of items
#' q <- 1 # common trait dimension
#'
#' # covariate parameters
#' mu_x <- 11.4009
#' sigma_x <- 24.67566
#'
#' # profile membership and transition parameters
#' nu_0 <- -3.563
#' kappa_0 <- 0.122
#' alpha_0 <- -3.586
#' beta_00 <- 2.250
#' gamma_00 <- 0.063
#' gamma_10 <- 0.094
#'
#' # trait parameters
#' psi_t <- 0.10 * diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
#' psi_p_1 <- 0.10
#' psi_p_2 <- 0.10
#' psi_p_3 <- 0.50
#' psi_p_4 <- 0.50
#' diag(psi_p) <- c(
#'   psi_p_1,
#'   psi_p_2,
#'   psi_p_3,
#'   psi_p_4
#' )
#' mu_p <- rep(x = 0, times = p)
#' common_trait_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = q
#' )
#'
#' # state parameters
#' common_state_loading <- matrix(
#'   data = 1,
#'   nrow = p,
#'   ncol = 1
#' )
#' phi_0 <- 0.000
#' phi_1 <- 0.311
#' psi_s0 <- 1.00
#' psi_s <- 0.25
#' theta <- 0.15 * diag(p)
#'
#' # profile-specific means
#' mu_profile <- cbind(
#'   c(2.253, 1.493, 1.574, 1.117),
#'   c(-0.278, -0.165, -0.199, -0.148)
#' )
#'
#' # data generation -----------------------------------------------------------
#' data <- GenCULTA2Profiles(
#'   n = n,
#'   m = m,
#'   mu_x = mu_x,
#'   sigma_x = sigma_x,
#'   nu_0 = nu_0,
#'   kappa_0 = kappa_0,
#'   alpha_0 = alpha_0,
#'   beta_00 = beta_00,
#'   gamma_00 = gamma_00,
#'   gamma_10 = gamma_10,
#'   mu_t = mu_t,
#'   psi_t = psi_t,
#'   mu_p = mu_p,
#'   psi_p = psi_p,
#'   common_trait_loading = common_trait_loading,
#'   common_state_loading = common_state_loading,
#'   phi_0 = phi_0,
#'   phi_1 = phi_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' one_profile <- FitCULTA1Profile(data = data)
#' two_profiles <- FitCULTA2Profiles(data = data)
#' anova(one_profile, two_profiles)
#' }
#'
#' @importFrom stats anova
#' @keywords methods
#' @export
anova.fitculta <- function(object,
                           other,
                           ...) {
  fun_1 <- object$fun
  ll_1 <- logLik(object)
  df_1 <- attributes(ll_1)[["df"]]
  c_1 <- attributes(ll_1)[["correction"]]
  aic_1 <- AIC(object)
  bic_1 <- BIC(object, adjust = FALSE)
  abic_1 <- BIC(object, adjust = TRUE)
  entropy_1 <- entropy(object)
  fun_2 <- other$fun
  ll_2 <- logLik(other)
  df_2 <- attributes(ll_2)[["df"]]
  c_2 <- attributes(ll_2)[["correction"]]
  aic_2 <- AIC(other)
  bic_2 <- BIC(other, adjust = FALSE)
  abic_2 <- BIC(other, adjust = TRUE)
  entropy_2 <- entropy(other)
  fun_name <- function(x) {
    if (x == "FitCULTA1Profile") {
      out <- "1-profile CULTA"
    }
    if (x == "FitCULTA2Profiles") {
      out <- "2-profile CULTA"
    }
    if (x == "FitCULTA3Profiles") {
      out <- "3-profile CULTA"
    }
    if (x == "FitLTA2Profiles") {
      out <- "2-profile LTA"
    }
    if (x == "FitRILTA2Profiles") {
      out <- "2-profile RILTA"
    }
    out
  }
  if (df_1 >= df_2) {
    name_lower <- fun_name(
      x = fun_1
    )
    ll_lower <- ll_1
    df_lower <- df_1
    c_lower <- c_1
    aic_lower <- aic_1
    bic_lower <- bic_1
    abic_lower <- abic_1
    entropy_lower <- entropy_1
    name_higher <- fun_name(
      x = fun_2
    )
    ll_higher <- ll_2
    df_higher <- df_2
    c_higher <- c_2
    aic_higher <- aic_2
    bic_higher <- bic_2
    abic_higher <- abic_2
    entropy_higher <- entropy_2
  } else {
    name_lower <- fun_name(
      x = fun_2
    )
    ll_lower <- ll_2
    df_lower <- df_2
    c_lower <- c_2
    aic_lower <- aic_2
    bic_lower <- bic_2
    abic_lower <- abic_2
    entropy_lower <- entropy_2
    name_higher <- fun_name(
      x = fun_1
    )
    ll_higher <- ll_1
    df_higher <- df_1
    c_higher <- c_1
    aic_higher <- aic_1
    bic_higher <- bic_1
    abic_higher <- abic_1
    entropy_higher <- entropy_1
  }
  model <- rbind(
    c(
      ll_higher,
      df_higher,
      c_higher,
      aic_higher,
      bic_higher,
      abic_higher,
      entropy_higher
    ),
    c(
      ll_lower,
      df_lower,
      c_lower,
      aic_lower,
      bic_lower,
      abic_lower,
      entropy_lower
    )
  )
  colnames(model) <- c(
    "logLik",
    "df",
    "correction",
    "AIC",
    "BIC",
    "aBIC",
    "entropy"
  )
  rownames(model) <- c(
    name_higher,
    name_lower
  )
  test <- .ChiDiffScaled(
    ll_higher = ll_higher,
    df_higher = df_higher,
    c_higher = c_higher,
    ll_lower = ll_lower,
    df_lower = df_lower,
    c_lower = c_lower
  )
  list(
    fit = model,
    test = test
  )
}
