# Plot Root Mean Square Error (CULTA Estimates)

Plot root mean square error for CULTA estimates.

## Usage

``` r
FigRMSECULTAEst(results_culta_est)
```

## Arguments

- results_culta_est:

  Summary CULTA estimates results data frame.

## Details

The parameters are indexed as follows:

- 1:

  \\\phi\_{0}\\ parameter. Autoregressive coefficient for profile 0.

- 2:

  \\\phi\_{1}\\ parameter. Autoregressive coefficient for profile 1.

- 3:

  \\\psi\_{T}\\ parameter. Variance in the common trait; reflects stable
  between-person differences.

- 4:

  \\\lambda\_{t2}\\ parameter. Factor loading for the common trait and
  item 2.

- 5:

  \\\lambda\_{t3}\\ parameter. Factor loading for the common trait and
  item 3.

- 6:

  \\\lambda\_{t4}\\ parameter. Factor loading for the common trait and
  item 4.

- 7:

  \\\psi\_{p11}\\ parameter. Trait-specific item 1 variance.

- 8:

  \\\psi\_{p22}\\ parameter. Trait-specific item 2 variance.

- 9:

  \\\psi\_{p33}\\ parameter. Trait-specific item 3 variance.

- 10:

  \\\psi\_{p44}\\ parameter. Trait-specific item 4 variance.

- 11:

  \\\psi\_{s0}\\ parameter. Initial-day variance of the common state;
  reflects variability in intoxication levels at observation start.

- 12:

  \\\psi\_{s}\\ parameter. Residual state variance over days; captures
  within-person daily fluctuations not explained by trait or AR effects.

- 13:

  \\\lambda\_{s2}\\ parameter. Factor loading for the common state and
  item 2.

- 14:

  \\\lambda\_{s3}\\ parameter. Factor loading for the common state and
  item 3.

- 15:

  \\\lambda\_{s4}\\ parameter. Factor loading for the common state and
  item 4.

- 16:

  \\\theta\_{11}\\ parameter. Unique state variance for item 1.

- 17:

  \\\theta\_{22}\\ parameter. Unique state variance for item 2.

- 18:

  \\\theta\_{33}\\ parameter. Unique state variance for item 3.

- 19:

  \\\theta\_{44}\\ parameter. Unique state variance for item 4.

- 20:

  \\\nu\_{0}\\ parameter. Intercept for initial log-odds of profile 0
  (vs. profile 1) when \\X = 0\\.

- 21:

  \\\kappa\_{0}\\ parameter. Covariate effect on initial profile
  membership; higher \\X\\ increases odds of profile 0.

- 22:

  \\\alpha\_{0}\\ parameter. Baseline log-odds of being in profile 0
  across days.

- 23:

  \\\beta\_{00}\\ parameter. Increased odds of staying in profile 0 if
  previously in that profile; reflects persistence.

- 24:

  \\\gamma\_{00}\\ parameter. Covariate effect on staying in profile 0;
  higher \\X\\ increases persistence.

- 25:

  \\\gamma\_{10}\\ parameter. Covariate effect on switching from state
  to profile 0; higher \\X\\ increases transition odds.

- 26:

  \\\mu\_{10}\\ parameter. Profile specific mean for profile 0 and item
  1.

- 27:

  \\\mu\_{20}\\ parameter. Profile specific mean for profile 0 and item
  2.

- 28:

  \\\mu\_{30}\\ parameter. Profile specific mean for profile 0 and item
  3.

- 29:

  \\\mu\_{40}\\ parameter. Profile specific mean for profile 0 and item
  4.

- 30:

  \\\mu\_{11}\\ parameter. Profile specific mean for profile 1 and item
  1.

- 31:

  \\\mu\_{21}\\ parameter. Profile specific mean for profile 1 and item
  2.

- 32:

  \\\mu\_{31}\\ parameter. Profile specific mean for profile 1 and item
  3.

- 33:

  \\\mu\_{41}\\ parameter. Profile specific mean for profile 1 and item
  4.

## See also

Other Figure Functions:
[`FigBiasCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigBiasCULTAEst.md),
[`FigBiasLTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigBiasLTAEst.md),
[`FigCoverageCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigCoverageCULTAEst.md),
[`FigCoverageLTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigCoverageLTAEst.md),
[`FigEntropy()`](https://github.com/jeksterslab/manCULTA/reference/FigEntropy.md),
[`FigIC()`](https://github.com/jeksterslab/manCULTA/reference/FigIC.md),
[`FigPowerCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigPowerCULTAEst.md),
[`FigPowerLTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigPowerLTAEst.md),
[`FigRMSELTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigRMSELTAEst.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
if (FALSE) { # \dontrun{
data(results_culta_est, package = "manCULTA")
FigRMSECULTAEst(results_culta_est)
} # }
```
