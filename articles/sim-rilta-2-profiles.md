# Comparing Two-Profile RILTA and CULTA Models

``` r

library(manCULTA)
```

We generate data using the CULTA model with two latent profiles, where
profile membership depends on a covariate and profile transitions follow
a multinomial structure. However, for model fitting, we impose a simpler
structure by fitting a random intercept latent transition analysis
(RILTA) model. We then compare this misspecified model to the correctly
specified two-profile CULTA model.

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

## Model Fitting

The `FitRILTA2Profiles` function fits the misspecified two-profile RILTA
model using `Mplus`. **Note:** This function requires that **Mplus** is
already installed on the system.

``` r

rilta <- FitRILTA2Profiles(data = data)
```

The `FitCULTA2Profiles` function fits the correct two-profile model
using `Mplus`. **Note:** This function requires that **Mplus** is
already installed on the system. To speed up model fitting, consider
using the `ncores` argument to leverage multiple cores.

``` r

culta <- FitCULTA2Profiles(data = data)
```

## Model Comparison

The `anova` function can be used to compare the two fitted models.

``` r

anova(rilta, culta)
#> $fit
#>                    logLik df correction      AIC     BIC     aBIC   entropy
#> 2-profile RILTA -6981.619 22   1.615733 14007.24 14079.8 14010.10 0.8836678
#> 2-profile CULTA -5850.928 33   1.023671 11767.86 11876.7 11772.15 0.7169988
#> 
#> $test
#>  chi_diff   df_diff   p_value 
#> -14093.62     11.00      1.00
```

## Parameter Recovery

Parameter recovery was assessed by calculating the relative bias of the
estimated profile-specific means, log-odds, and residual variances.

|          | Parameter | RILTA Estimate | Relative Bias | CULTA Estimate | Relative Bias |
|:---------|----------:|---------------:|--------------:|---------------:|--------------:|
| mu_10    |     2.253 |      2.2035760 |    -0.0219370 |      2.1694682 |    -0.0370758 |
| mu_20    |     1.493 |      1.6653136 |     0.1154143 |      1.5565449 |     0.0425619 |
| mu_30    |     1.574 |      1.6534203 |     0.0504576 |      1.5795206 |     0.0035074 |
| mu_40    |     1.117 |      1.3752747 |     0.2312218 |      1.1605009 |     0.0389444 |
| mu_11    |    -0.278 |     -0.4207472 |     0.5134792 |     -0.2859422 |     0.0285691 |
| mu_21    |    -0.165 |     -0.2640176 |     0.6001068 |     -0.0880921 |    -0.4661086 |
| mu_31    |    -0.199 |     -0.2999945 |     0.5075099 |     -0.1544862 |    -0.2236876 |
| mu_41    |    -0.148 |     -0.3141873 |     1.1228870 |     -0.0510851 |    -0.6548303 |
| nu_0     |    -0.405 |     -0.0013525 |    -0.9966605 |     -0.2154072 |    -0.4681304 |
| alpha_0  |    -0.500 |     -0.4055947 |    -0.1888107 |     -0.3451484 |    -0.3097032 |
| kappa_0  |     0.100 |      0.4158691 |     3.1586911 |      0.3926138 |     2.9261377 |
| beta_00  |     0.850 |      0.8192341 |    -0.0361952 |      0.6689811 |    -0.2129634 |
| gamma_00 |     0.200 |      0.0853273 |    -0.5733633 |      0.2315390 |     0.1576949 |
| gamma_10 |     0.200 |      0.1172341 |    -0.4138297 |      0.2815591 |     0.4077955 |
| theta_11 |     0.200 |      0.8114558 |     3.0572789 |      0.2216670 |     0.1083351 |
| theta_22 |     0.200 |      0.6660180 |     2.3300901 |      0.2296140 |     0.1480698 |
| theta_33 |     0.200 |      0.6553469 |     2.2767343 |      0.2072222 |     0.0361108 |
| theta_44 |     0.200 |      0.6757793 |     2.3788964 |      0.1752072 |    -0.1239641 |

Parameter Recovery {.table}

## Mplus Script Used

The RILTA model was estimated using the following `Mplus` script.

    TITLE:
      2-Profile RILTA with Covariate;

    DATA:
      FILE = rilta_data.dat;

    VARIABLE:
      NAMES =
        id
        x
        y1t0
        y2t0
        y3t0
        y4t0
        y1t1
        y2t1
        y3t1
        y4t1
        y1t2
        y2t2
        y3t2
        y4t2
        y1t3
        y2t3
        y3t3
        y4t3
        y1t4
        y2t4
        y3t4
        y4t4
        y1t5
        y2t5
        y3t5
        y4t5
      ;
      USEVARIABLES =
        x
        y1t0
        y2t0
        y3t0
        y4t0
        y1t1
        y2t1
        y3t1
        y4t1
        y1t2
        y2t2
        y3t2
        y4t2
        y1t3
        y2t3
        y3t3
        y4t3
        y1t4
        y2t4
        y3t4
        y4t4
        y1t5
        y2t5
        y3t5
        y4t5
      ;
      IDVARIABLE = id;
      CLASSES =
        c0(2)
        c1(2)
        c2(2)
        c3(2)
        c4(2)
        c5(2)
      ;

    ANALYSIS:
      TYPE = MIXTURE;
      STARTS = 500 100;
      STSCALE = 2;
      STITERATIONS = 200;
      PROCESS = 24;
      MODEL = NOCOV;

    MODEL:
      %OVERALL%
        ! random intercept --------------------------------------------------

        !! loadings
        !!! t = 0
        f BY y1t0* (lambdat1);
        f BY y2t0 (lambdat2);
        f BY y3t0 (lambdat3);
        f BY y4t0 (lambdat4);
        !!! t = 1
        f BY y1t1* (lambdat1);
        f BY y2t1 (lambdat2);
        f BY y3t1 (lambdat3);
        f BY y4t1 (lambdat4);
        !!! t = 2
        f BY y1t2* (lambdat1);
        f BY y2t2 (lambdat2);
        f BY y3t2 (lambdat3);
        f BY y4t2 (lambdat4);
        !!! t = 3
        f BY y1t3* (lambdat1);
        f BY y2t3 (lambdat2);
        f BY y3t3 (lambdat3);
        f BY y4t3 (lambdat4);
        !!! t = 4
        f BY y1t4* (lambdat1);
        f BY y2t4 (lambdat2);
        f BY y3t4 (lambdat3);
        f BY y4t4 (lambdat4);
        !!! t = 5
        f BY y1t5* (lambdat1);
        f BY y2t5 (lambdat2);
        f BY y3t5 (lambdat3);
        f BY y4t5 (lambdat4);

        !! latent mean
        [ f@0 ];

        !! latent variance
        f@1;

        ! unique states -----------------------------------------------------

        !! variances
        !!! t = 0
        y1t0 (theta11);
        y2t0 (theta22);
        y3t0 (theta33);
        y4t0 (theta44);
        !!! t = 1
        y1t1 (theta11);
        y2t1 (theta22);
        y3t1 (theta33);
        y4t1 (theta44);
        !!! t = 2
        y1t2 (theta11);
        y2t2 (theta22);
        y3t2 (theta33);
        y4t2 (theta44);
        !!! t = 3
        y1t3 (theta11);
        y2t3 (theta22);
        y3t3 (theta33);
        y4t3 (theta44);
        !!! t = 4
        y1t4 (theta11);
        y2t4 (theta22);
        y3t4 (theta33);
        y4t4 (theta44);
        !!! t = 5
        y1t5 (theta11);
        y2t5 (theta22);
        y3t5 (theta33);
        y4t5 (theta44);

        ! lta ---------------------------------------------------------------

        !! initial profile membership
        [ c0#1 ] (nu0);
        c0#1 ON x (kappa0);

        !! profile transitions
        [ c1#1 ] (alpha0);
        [ c2#1 ] (alpha0);
        [ c3#1 ] (alpha0);
        [ c4#1 ] (alpha0);
        [ c5#1 ] (alpha0);
        c1#1 ON c0#1 (beta00);
        c2#1 ON c1#1 (beta00);
        c3#1 ON c2#1 (beta00);
        c4#1 ON c3#1 (beta00);
        c5#1 ON c4#1 (beta00);

    MODEL c0:
      %c0#1%
        ! profile specific means
        [ y1t0 ] (mu10);
        [ y2t0 ] (mu20);
        [ y3t0 ] (mu30);
        [ y4t0 ] (mu40);

        ! covariate
        c1 ON x (gamma00);

      %c0#2%
        ! profile specific means
        [ y1t0 ] (mu11);
        [ y2t0 ] (mu21);
        [ y3t0 ] (mu31);
        [ y4t0 ] (mu41);

        ! covariate
        c1 ON x (gamma10);

    MODEL c1:
      %c1#1%
        ! profile specific means
        [ y1t1 ] (mu10);
        [ y2t1 ] (mu20);
        [ y3t1 ] (mu30);
        [ y4t1 ] (mu40);

        ! covariate
        c2 ON x (gamma00);

      %c1#2%
        ! profile specific means
        [ y1t1 ] (mu11);
        [ y2t1 ] (mu21);
        [ y3t1 ] (mu31);
        [ y4t1 ] (mu41);

        ! covariate
        c2 ON x (gamma10);

    MODEL c2:
      %c2#1%
        ! profile specific means
        [ y1t2 ] (mu10);
        [ y2t2 ] (mu20);
        [ y3t2 ] (mu30);
        [ y4t2 ] (mu40);

        ! covariate
        c3 ON x (gamma00);

      %c2#2%
        ! profile specific means
        [ y1t2 ] (mu11);
        [ y2t2 ] (mu21);
        [ y3t2 ] (mu31);
        [ y4t2 ] (mu41);

        ! covariate
        c3 ON x (gamma10);

    MODEL c3:
      %c3#1%
        ! profile specific means
        [ y1t3 ] (mu10);
        [ y2t3 ] (mu20);
        [ y3t3 ] (mu30);
        [ y4t3 ] (mu40);

        ! covariate
        c4 ON x (gamma00);

      %c3#2%
        ! profile specific means
        [ y1t3 ] (mu11);
        [ y2t3 ] (mu21);
        [ y3t3 ] (mu31);
        [ y4t3 ] (mu41);

        ! covariate
        c4 ON x (gamma10);

    MODEL c4:
      %c4#1%
        ! profile specific means
        [ y1t4 ] (mu10);
        [ y2t4 ] (mu20);
        [ y3t4 ] (mu30);
        [ y4t4 ] (mu40);

        ! covariate
        c5 ON x (gamma00);

      %c4#2%
        ! profile specific means
        [ y1t4 ] (mu11);
        [ y2t4 ] (mu21);
        [ y3t4 ] (mu31);
        [ y4t4 ] (mu41);

        ! covariate
        c5 ON x (gamma10);

    MODEL c5:
      %c5#1%
        ! profile specific means
        [ y1t5 ] (mu10);
        [ y2t5 ] (mu20);
        [ y3t5 ] (mu30);
        [ y4t5 ] (mu40);

      %c5#2%
        ! profile specific means
        [ y1t5 ] (mu11);
        [ y2t5 ] (mu21);
        [ y3t5 ] (mu31);
        [ y4t5 ] (mu41);


    MODEL CONSTRAINT:
      ! means for the first profile are higher than the second
      mu10 > mu11;
      mu20 > mu21;
      mu30 > mu31;
      mu40 > mu41;

      ! make sure variances are greater than zero
      theta11 > 0;
      theta22 > 0;
      theta33 > 0;
      theta44 > 0;

    OUTPUT:
      TECH1
      TECH3
      TECH4
      TECH7
      TECH8
      TECH12
      TECH13
      TECH15
      ENTROPY;

    SAVEDATA:
      ESTIMATES = rilta_lrIq31gaoeSlXSleIeIz_estimates.dat;
      RESULTS = rilta_lrIq31gaoeSlXSleIeIz_results.dat;
      TECH3 = rilta_lrIq31gaoeSlXSleIeIz_tech3.dat;
      TECH4 = rilta_lrIq31gaoeSlXSleIeIz_tech4.dat;
      FILE = rilta_lrIq31gaoeSlXSleIeIz_cprobs.dat;
      SAVE = CPROBABILITIES;
