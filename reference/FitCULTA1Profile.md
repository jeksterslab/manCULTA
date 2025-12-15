# Fit the One-Profile CULTA Model (CUTS Model with AR)

Fits the one-profile CULTA model using `Mplus`.

## Usage

``` r
FitCULTA1Profile(
  data,
  wd = ".",
  mplus_bin = NULL,
  starts = 10,
  starting_values = NULL
)
```

## Arguments

- data:

  R object. Object of class `simculta`.

- wd:

  Character string. Working directory.

- mplus_bin:

  Character string. Path to Mplus binary. If `mplus_bin = NULL`, the
  function will try to find the appropriate binary.

- starts:

  Positive integer. Number of initial stage starting values.

- starting_values:

  Optional list of starting values.

## Value

Returns an object of class `fitculta`. which is a list with the
following elements:

- `call`: Function call.

- `fun`: Function used ("FitCULTA1Profile").

- `args`: Function arguments.

- `output`: `Mplus` output files.

- `elapsed`: Elapsed time.

## See also

Other Model Fitting Functions:
[`FitCULTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/FitCULTA2Profiles.md),
[`FitLTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/FitLTA2Profiles.md),
[`FitRILTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/FitRILTA2Profiles.md),
[`InputCULTA1Profile()`](https://github.com/jeksterslab/manCULTA/reference/InputCULTA1Profile.md),
[`InputCULTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/InputCULTA2Profiles.md),
[`InputLTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/InputLTA2Profiles.md),
[`InputRILTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/InputRILTA2Profiles.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
if (FALSE) { # \dontrun{
# complete list of R function arguments -------------------------------------

# random seed for reproducibility
set.seed(42)

# dimensions
n <- 1000 # number of individuals
m <- 6 # measurement occasions
p <- 4 # number of items
q <- 1 # common trait dimension

# covariate parameters
mu_x <- 11.4009
sigma_x <- 24.67566

# profile membership and transition parameters
nu_0 <- -3.563
kappa_0 <- 0.122
alpha_0 <- -3.586
beta_00 <- 2.250
gamma_00 <- 0.063
gamma_10 <- 0.094

# trait parameters
psi_t <- 0.10 * diag(1)
mu_t <- 0
psi_p <- diag(p)
psi_p_1 <- 0.10
psi_p_2 <- 0.10
psi_p_3 <- 0.50
psi_p_4 <- 0.50
diag(psi_p) <- c(
  psi_p_1,
  psi_p_2,
  psi_p_3,
  psi_p_4
)
mu_p <- rep(x = 0, times = p)
common_trait_loading <- matrix(
  data = 1,
  nrow = p,
  ncol = q
)

# state parameters
common_state_loading <- matrix(
  data = 1,
  nrow = p,
  ncol = 1
)
phi_0 <- 0.000
phi_1 <- 0.311
psi_s0 <- 1.00
psi_s <- 0.25
theta <- 0.15 * diag(p)

# profile-specific means
mu_profile <- cbind(
  c(2.253, 1.493, 1.574, 1.117),
  c(-0.278, -0.165, -0.199, -0.148)
)

# data generation -----------------------------------------------------------
data <- GenCULTA2Profiles(
  n = n,
  m = m,
  mu_x = mu_x,
  sigma_x = sigma_x,
  nu_0 = nu_0,
  kappa_0 = kappa_0,
  alpha_0 = alpha_0,
  beta_00 = beta_00,
  gamma_00 = gamma_00,
  gamma_10 = gamma_10,
  mu_t = mu_t,
  psi_t = psi_t,
  mu_p = mu_p,
  psi_p = psi_p,
  common_trait_loading = common_trait_loading,
  common_state_loading = common_state_loading,
  phi_0 = phi_0,
  phi_1 = phi_1,
  psi_s0 = psi_s0,
  psi_s = psi_s,
  theta = theta,
  mu_profile = mu_profile
)

# model fitting -------------------------------------------------------------
# NOTE: Model fitting takes time
FitCULTA1Profile(data = data)
} # }
```
