# Simulation Parameters

Simulation Parameters

## Usage

``` r
data(params)
```

## Format

A dataframe with 5 rows and 38 columns:

- taskid:

  Simulation Task ID.

- n:

  Sample size.

- m:

  Measurement occasions.

- mu_x:

  \\\mu\_{x}\\ parameter. Mean of the covariate.

- sigma_x:

  \\\sigma\_{x}\\ parameter. Variance of the covariate.

- mu_10:

  \\\mu\_{10}\\ parameter. Profile specific mean for profile 0 and item
  1.

- mu_20:

  \\\mu\_{20}\\ parameter. Profile specific mean for profile 0 and item
  2.

- mu_30:

  \\\mu\_{30}\\ parameter. Profile specific mean for profile 0 and item
  3.

- mu_40:

  \\\mu\_{40}\\ parameter. Profile specific mean for profile 0 and item
  4.

- lambda_t2:

  \\\lambda\_{t2}\\ parameter. Factor loading for the common trait and
  item 2.

- lambda_s2:

  \\\lambda\_{s2}\\ parameter. Factor loading for the common state and
  item 2.

- lambda_t3:

  \\\lambda\_{t3}\\ parameter. Factor loading for the common trait and
  item 3.

- lambda_s3:

  \\\lambda\_{s3}\\ parameter. Factor loading for the common state and
  item 3.

- lambda_t4:

  \\\lambda\_{t4}\\ parameter. Factor loading for the common trait and
  item 4.

- lambda_s4:

  \\\lambda\_{s4}\\ parameter. Factor loading for the common state and
  item 4.

- theta_11:

  \\\theta\_{11}\\ parameter. Unique state variance for item 1.

- theta_22:

  \\\theta\_{22}\\ parameter. Unique state variance for item 2.

- theta_33:

  \\\theta\_{33}\\ parameter. Unique state variance for item 3.

- theta_44:

  \\\theta\_{44}\\ parameter. Unique state variance for item 4.

- phi_0:

  \\\phi\_{0}\\ parameter. Autoregressive coefficient for profile 0.

- psi_t:

  \\\psi\_{T}\\ parameter. Variance in the common trait; reflects stable
  between-person differences.

- psi_p_11:

  \\\psi\_{p11}\\ parameter. Trait-specific item 1 variance.

- psi_p_22:

  \\\psi\_{p22}\\ parameter. Trait-specific item 2 variance.

- psi_p_33:

  \\\psi\_{p33}\\ parameter. Trait-specific item 3 variance.

- psi_p_44:

  \\\psi\_{p44}\\ parameter. Trait-specific item 4 variance.

- psi_s0:

  \\\psi\_{s0}\\ parameter. Initial-day variance of the common state;
  reflects variability in intoxication levels at observation start.

- psi_s:

  \\\psi\_{s}\\ parameter. Residual state variance over days; captures
  within-person daily fluctuations not explained by trait or AR effects.

- mu_11:

  \\\mu\_{11}\\ parameter. Profile specific mean for profile 1 and item
  1.

- mu_21:

  \\\mu\_{21}\\ parameter. Profile specific mean for profile 1 and item
  2.

- mu_31:

  \\\mu\_{31}\\ parameter. Profile specific mean for profile 1 and item
  3.

- mu_41:

  \\\mu\_{41}\\ parameter. Profile specific mean for profile 1 and item
  4.

- phi_1:

  \\\phi\_{1}\\ parameter. Autoregressive coefficient for profile 1.

- nu_0:

  \\\nu\_{0}\\ parameter. Intercept for initial log-odds of profile 0
  (vs. profile 1) when \\X = 0\\.

- alpha_0:

  \\\alpha\_{0}\\ parameter. Baseline log-odds of being in profile 0
  across days.

- kappa_0:

  \\\kappa\_{0}\\ parameter. Covariate effect on initial profile
  membership; higher \\X\\ increases odds of profile 0.

- beta_00:

  \\\beta\_{00}\\ parameter. Increased odds of staying in profile 0 if
  previously in that profile; reflects persistence.

- gamma_00:

  \\\gamma\_{00}\\ parameter. Covariate effect on staying in profile 0;
  higher \\X\\ increases persistence.

- gamma_10:

  \\\gamma\_{10}\\ parameter. Covariate effect on switching from state
  to profile 0; higher \\X\\ increases transition odds.

## Author

Ivan Jacob Agaloos Pesigan
