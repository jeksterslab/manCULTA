#' Fit the One-Profile CULTA Model (CUTS Model with AR)
#'
#' Fits the one-profile CULTA model using `Mplus`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#' @param starts Positive integer.
#'   Number of initial stage starting values.
#'
#' @inheritParams FitCULTA2Profiles
#'
#' @return Returns an object of class `fitculta`.
#'   which is a list with the following elements:
#'   - `call`: Function call.
#'   - `fun`: Function used ("FitCULTA1Profile").
#'   - `args`: Function arguments.
#'   - `output`: `Mplus` output files.
#'   - `elapsed`: Elapsed time.
#'
#' @examples
#' \dontrun{
#' # complete list of R function arguments -------------------------------------
#'
#' # random seed for reproducibility
#' set.seed(42)
#'
#' # dimensions
#' n <- 5000 # number of individuals
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
#' psi_t <- diag(1)
#' mu_t <- 0
#' psi_p <- diag(p)
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
#' beta_0 <- 0.000
#' beta_1 <- 0.311
#' psi_s0 <- 0.151
#' psi_s <- 0.290
#' theta <- diag(p)
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
#'   beta_0 = beta_0,
#'   beta_1 = beta_1,
#'   psi_s0 = psi_s0,
#'   psi_s = psi_s,
#'   theta = theta,
#'   mu_profile = mu_profile
#' )
#'
#' # model fitting -------------------------------------------------------------
#' # NOTE: Model fitting takes time
#' FitCULTA1Profile(data = data)
#' }
#'
#' @family Model Fitting Functions
#' @keywords manCULTA fit state trait mixture culta
#' @export
FitCULTA1Profile <- function(data,
                             wd = ".",
                             mplus_bin = NULL,
                             starts = 10) {
  start <- Sys.time()
  stopifnot(
    inherits(
      x = data,
      what = "simculta"
    )
  )
  # arguments
  args <- list(
    data = data,
    wd = wd,
    mplus_bin = mplus_bin
  )
  # directory
  old_wd <- getwd()
  on.exit(
    setwd(old_wd)
  )
  new_wd <- .CreateFolder(
    x = normalizePath(
      path = wd,
      mustWork = FALSE
    )
  )
  on.exit(
    unlink(
      x = new_wd,
      recursive = TRUE
    ),
    add = TRUE
  )
  setwd(new_wd)
  # filenames
  prefix <- .RandomFile()
  fn_data <- "data.dat"
  fn_inp <- paste0(
    prefix,
    ".inp"
  )
  fn_out <- paste0(
    prefix,
    ".out"
  )
  fn_estimates <- paste0(
    prefix,
    "_",
    "estimates.dat"
  )
  fn_results <- paste0(
    prefix,
    "_",
    "results.dat"
  )
  fn_tech3 <- paste0(
    prefix,
    "_",
    "tech3.dat"
  )
  fn_tech4 <- paste0(
    prefix,
    "_",
    "tech4.dat"
  )
  # data
  WriteData(
    x = data,
    file = fn_data
  )
  # input
  writeLines(
    text = .MplusCULTA1Profile(
      p = data$args$p,
      m = data$args$m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      starts = starts
    ),
    con = fn_inp
  )
  # output
  if (is.null(mplus_bin)) {
    mplus_bin <- .WhichMplus()
  }
  if (.Platform$OS.type == "windows") {
    nullfile <- "NUL"
  } else {
    nullfile <- "/dev/null"
  }
  if (interactive()) {
    message(
      "Fitting the model...\n"
    )
  }
  system2(
    mplus_bin,
    args = c(
      fn_inp,
      fn_out
    ),
    stdout = nullfile,
    stderr = nullfile
  )
  output <- list(
    data = .ReadLines(
      con = fn_data
    ),
    input = .ReadLines(
      con = fn_inp
    ),
    output = .ReadLines(
      con = fn_out
    ),
    estimates = .ReadLines(
      con = fn_estimates
    ),
    results = .ReadLines(
      con = fn_results
    ),
    tech3 = .ReadLines(
      con = fn_tech3
    ),
    tech4 = .ReadLines(
      con = fn_tech4
    )
  )
  call <- match.call()
  fun <- "FitCULTA1Profile"
  end <- Sys.time()
  elapsed <- end - start
  out <- list(
    call = call,
    fun = fun,
    args = args,
    output = output,
    elapsed = elapsed
  )
  class(out) <- c(
    "fitculta",
    class(out)
  )
  out
}
