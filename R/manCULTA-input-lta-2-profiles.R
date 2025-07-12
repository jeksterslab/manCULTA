#' Generate Mplus Input file for the
#' Two-Profile LTA Model
#'
#' Generates `Mplus` input file for
#' the two-profile LTA model.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams FitLTA2Profiles
#'
#' @return Writes data and input files in `wd`.
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
#' # generate data and Mplus input files fitting -------------------------------
#' InputLTA2Profiles(data = data)
#' }
#'
#' @family Model Fitting Functions
#' @keywords manCULTA input state trait mixture culta
#' @export
InputLTA2Profiles <- function(data,
                              wd = ".",
                              ncores = 1L,
                              starts = c(20, 4),
                              stiterations = 10,
                              stscale = 5) {
  stopifnot(
    inherits(
      x = data,
      what = "simculta"
    )
  )
  # directory
  new_wd <- .CreateFolder(
    x = normalizePath(
      path = wd,
      mustWork = FALSE
    )
  )
  # filenames
  prefix <- .RandomFile()
  fn_data <- "data.dat"
  fn_inp <- paste0(
    prefix,
    ".inp"
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
  fn_cprobs <- paste0(
    prefix,
    "_",
    "cprobs.dat"
  )
  # data
  WriteData(
    x = data,
    file = file.path(
      new_wd,
      fn_data
    )
  )
  # input
  writeLines(
    text = .MplusLTA2Profiles(
      p = data$args$p,
      m = data$args$m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      fn_cprobs = fn_cprobs,
      ncores = as.integer(ncores),
      starts = starts,
      stiterations = stiterations,
      stscale = stscale
    ),
    con = file.path(
      new_wd,
      fn_inp
    )
  )
  message(
    paste0(
      "Check data and Mplus input files in",
      "\n",
      new_wd
    )
  )
  invisible(NULL)
}
