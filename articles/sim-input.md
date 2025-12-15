# Generating Mplus Input Files

The `FitCULTA1Profile`, `FitCULTA2Profiles`, and `FitCULTA3Profiles`
functions require that **Mplus** is installed on the system.

In contrast, the `InputCULTA1Profile` and `InputCULTA2Profiles`
functions only generate Mplus-compatible data and input files. These
files can be transferred and run on another machine with **Mplus**
installed.

The accompanying vignette demonstrates the use of the
`InputCULTA1Profile` and `InputCULTA2Profiles` functions for preparing
and exporting the necessary `Mplus` files.

The workflow proceeds as follows:

1.  **Generate the data**.
2.  **Use the `InputCULTA*` functions** to create Mplus-compatible data
    and input files.
3.  **Transfer and run the generated files** on a system where **Mplus**
    is installed.

``` r

library(manCULTA)
```

## Data Generation

``` r

# complete list of R function arguments

# random seed for reproducibility
set.seed(42)

# dimensions
n # number of individuals
#> [1] 200
m # measurement occasions
#> [1] 6
p # number of items
#> [1] 4
q # common trait dimension
#> [1] 1

# covariate parameters
mu_x 
#> [1] 0
sigma_x
#> [1] 1

# profile membership and transition parameters
nu_0
#> [1] -0.405
kappa_0
#> [1] 0.1
alpha_0
#> [1] -0.5
beta_00
#> [1] 0.85
gamma_00
#> [1] 0.2
gamma_10
#> [1] 0.2

# trait parameters
psi_t
#>      [,1]
#> [1,]  0.3
mu_t
#> [1] 0
psi_p
#>      [,1] [,2] [,3] [,4]
#> [1,]  0.3  0.0  0.0  0.0
#> [2,]  0.0  0.3  0.0  0.0
#> [3,]  0.0  0.0  0.3  0.0
#> [4,]  0.0  0.0  0.0  0.3
mu_p
#> [1] 0 0 0 0
common_trait_loading
#>      [,1]
#> [1,]    1
#> [2,]    1
#> [3,]    1
#> [4,]    1

# state parameters
common_state_loading
#>      [,1]
#> [1,]    1
#> [2,]    1
#> [3,]    1
#> [4,]    1
phi_0
#> [1] 0
phi_1
#> [1] 0.311
psi_s0
#> [1] 1
psi_s
#> [1] 0.5
theta
#>      [,1] [,2] [,3] [,4]
#> [1,]  0.2  0.0  0.0  0.0
#> [2,]  0.0  0.2  0.0  0.0
#> [3,]  0.0  0.0  0.2  0.0
#> [4,]  0.0  0.0  0.0  0.2

# profile-specific means
mu_profile
#>       [,1]   [,2]
#> [1,] 2.253 -0.278
#> [2,] 1.493 -0.165
#> [3,] 1.574 -0.199
#> [4,] 1.117 -0.148

# starting values
starting_values
#> $nu_0
#> [1] -0.405
#> 
#> $kappa_0
#> [1] 0.1
#> 
#> $alpha_0
#> [1] -0.5
#> 
#> $beta_00
#> [1] 0.85
#> 
#> $gamma_00
#> [1] 0.2
#> 
#> $gamma_10
#> [1] 0.2
#> 
#> $psi_t
#>      [,1]
#> [1,]  0.3
#> 
#> $psi_p
#>      [,1] [,2] [,3] [,4]
#> [1,]  0.3  0.0  0.0  0.0
#> [2,]  0.0  0.3  0.0  0.0
#> [3,]  0.0  0.0  0.3  0.0
#> [4,]  0.0  0.0  0.0  0.3
#> 
#> $common_trait_loading
#>      [,1]
#> [1,]    1
#> [2,]    1
#> [3,]    1
#> [4,]    1
#> 
#> $common_state_loading
#>      [,1]
#> [1,]    1
#> [2,]    1
#> [3,]    1
#> [4,]    1
#> 
#> $phi_0
#> [1] 0
#> 
#> $phi_1
#> [1] 0.311
#> 
#> $psi_s0
#> [1] 1
#> 
#> $psi_s
#> [1] 0.5
#> 
#> $theta
#>      [,1] [,2] [,3] [,4]
#> [1,]  0.2  0.0  0.0  0.0
#> [2,]  0.0  0.2  0.0  0.0
#> [3,]  0.0  0.0  0.2  0.0
#> [4,]  0.0  0.0  0.0  0.2
#> 
#> $mu_profile
#>       [,1]   [,2]
#> [1,] 2.253 -0.278
#> [2,] 1.493 -0.165
#> [3,] 1.574 -0.199
#> [4,] 1.117 -0.148
```

``` r

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
```

## Generate Mplus Files

In this stage, we generate the Mplus-compatible data and input files
using the `InputCULTA1Profile`, `InputCULTA2Profiles`,
`InputLTA2Profiles`, and `InputRILTA2Profiles` functions. These
functions take the simulated dataset and export the necessary files to
run the model in `Mplus`.

Each function corresponds to a specific version of the CULTA model:

``` r

InputCULTA1Profile(data = data)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/cutsar_WKayjJr5WUxgJyKTtzXU
```

``` r

InputCULTA2Profiles(data = data)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/culta_ov5hJdvrSBedH3XIxwW0
```

``` r

InputLTA2Profiles(data = data)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/lta_SPiCltiQICpKB3TeB1br
```

``` r

InputRILTA2Profiles(data = data)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/rilta_Fp17CqRi4u9Q45VhC2La
```

### With Starting Values

``` r

InputCULTA1Profile(
  data = data,
  starting_values = starting_values
)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/cutsar_nUf3UQ9KpW1WXEHDFfvL
```

``` r

InputCULTA2Profiles(
  data = data,
  starting_values = starting_values
)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/culta_Q89nH7bEFAj4B1KjWWeI
```

``` r

InputLTA2Profiles(
  data = data,
  starting_values = starting_values
)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/lta_Jtkqiq9mE97W8ZaqGBbE
```

``` r

InputRILTA2Profiles(
  data = data,
  starting_values = starting_values
)
#> Check data and Mplus input files in
#> /scratch/ibp5092/manCULTA/vignettes/rilta_Oycr0UB7oC4typ1xG8LQ
```

## Run in Mplus

In the final stage, the Mplus-compatible data and input files generated
by the `InputCULTA1Profile`, `InputCULTA2Profiles`, `InputLTA2Profiles`,
and `InputRILTA2Profiles` functions can be transferred to a machine
where `Mplus` is installed.

To run the model:

- Open `Mplus` on the target system.
- Load the generated `.inp` (input) file.
- Execute the model to produce the desired output, including parameter
  estimates, fit statistics, and saved results (e.g., `TECH3`, `TECH4`,
  and `CPROBS`).

This stage completes the workflow by fitting the CULTA model using the
fully prepared files from earlier stages.
