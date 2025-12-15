# Plot Coverage Probabilities (LTA Estimates)

Plot coverage probabilities for common LTA estimates.

## Usage

``` r
FigCoverageLTAEst(results_lta_est)
```

## Arguments

- results_lta_est:

  Summary LTA estimates results data frame.

## Details

The parameters are indexed as follows:

- 1:

  \\\theta\_{11}\\ parameter. Unique state variance for item 1.

- 2:

  \\\theta\_{22}\\ parameter. Unique state variance for item 2.

- 3:

  \\\theta\_{33}\\ parameter. Unique state variance for item 3.

- 4:

  \\\theta\_{44}\\ parameter. Unique state variance for item 4.

- 5:

  \\\nu\_{0}\\ parameter. Intercept for initial log-odds of profile 0
  (vs. profile 1) when \\X = 0\\.

- 6:

  \\\kappa\_{0}\\ parameter. Covariate effect on initial profile
  membership; higher \\X\\ increases odds of profile 0.

- 7:

  \\\alpha\_{0}\\ parameter. Baseline log-odds of being in profile 0
  across days.

- 8:

  \\\beta\_{00}\\ parameter. Increased odds of staying in profile 0 if
  previously in that profile; reflects persistence.

- 9:

  \\\gamma\_{00}\\ parameter. Covariate effect on staying in profile 0;
  higher \\X\\ increases persistence.

- 10:

  \\\gamma\_{10}\\ parameter. Covariate effect on switching from state
  to profile 0; higher \\X\\ increases transition odds.

- 11:

  \\\mu\_{10}\\ parameter. Profile specific mean for profile 0 and item
  1.

- 12:

  \\\mu\_{20}\\ parameter. Profile specific mean for profile 0 and item
  2.

- 13:

  \\\mu\_{30}\\ parameter. Profile specific mean for profile 0 and item
  3.

- 14:

  \\\mu\_{40}\\ parameter. Profile specific mean for profile 0 and item
  4.

- 15:

  \\\mu\_{11}\\ parameter. Profile specific mean for profile 1 and item
  1.

- 16:

  \\\mu\_{21}\\ parameter. Profile specific mean for profile 1 and item
  2.

- 17:

  \\\mu\_{31}\\ parameter. Profile specific mean for profile 1 and item
  3.

- 18:

  \\\mu\_{41}\\ parameter. Profile specific mean for profile 1 and item
  4.

## See also

Other Figure Functions:
[`FigBiasCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigBiasCULTAEst.md),
[`FigBiasLTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigBiasLTAEst.md),
[`FigCoverageCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigCoverageCULTAEst.md),
[`FigEntropy()`](https://github.com/jeksterslab/manCULTA/reference/FigEntropy.md),
[`FigIC()`](https://github.com/jeksterslab/manCULTA/reference/FigIC.md),
[`FigPowerCULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigPowerCULTAEst.md),
[`FigPowerLTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigPowerLTAEst.md),
[`FigRMSECULTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigRMSECULTAEst.md),
[`FigRMSELTAEst()`](https://github.com/jeksterslab/manCULTA/reference/FigRMSELTAEst.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
if (FALSE) { # \dontrun{
data(results_lta_est, package = "manCULTA")
FigCoverageLTAEst(results_lta_est)
} # }
```
