# Print Method for an Object of Class `simculta`

Print Method for an Object of Class `simculta`

## Usage

``` r
# S3 method for class 'simculta'
print(x, ...)
```

## Arguments

- x:

  Object of class `simculta`.

- ...:

  Additional arguments.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
x <- GenCULTA2Profiles(
  n = 10,
  m = 6,
  common_trait_loading = matrix(
    data = c(1, 1.25, 1.50, 1.75),
    ncol = 1
  ),
  common_state_loading = matrix(
    data = c(1, 1.5, 1.75, 2.00),
    ncol = 1
  ),
  mu_t = NULL,
  psi_t = NULL,
  mu_p = NULL,
  psi_p = NULL,
  theta = diag(4),
  mu_profile = cbind(
    c(-3, -3, -3, -3),
    c(3, 3, 3, 3)
  ),
  mu_x = 0,
  sigma_x = 1,
  nu_0 = -3.563,
  kappa_0 = 0.122,
  alpha_0 = -3.586,
  beta_00 = 2.250,
  gamma_00 = 0.063,
  gamma_10 = 0.094,
  phi_0 = 0.311,
  phi_1 = 0,
  psi_s0 = 0.151,
  psi_s = 0.290
)
print(x)
#> Call:
#> GenCULTA2Profiles(n = 10, m = 6, mu_x = 0, sigma_x = 1, nu_0 = -3.563, 
#>     kappa_0 = 0.122, alpha_0 = -3.586, beta_00 = 2.25, gamma_00 = 0.063, 
#>     gamma_10 = 0.094, mu_t = NULL, psi_t = NULL, mu_p = NULL, 
#>     psi_p = NULL, common_trait_loading = matrix(data = c(1, 1.25, 
#>         1.5, 1.75), ncol = 1), common_state_loading = matrix(data = c(1, 
#>         1.5, 1.75, 2), ncol = 1), phi_0 = 0.311, phi_1 = 0, psi_s0 = 0.151, 
#>     psi_s = 0.29, theta = diag(4), mu_profile = cbind(c(-3, -3, 
#>         -3, -3), c(3, 3, 3, 3)))
#> Use `as.data.frame` or `as.matrix` on the output of `GenCULTA2Profiles`
#> to convert it to a data frame or a matrix.
#> 
```
