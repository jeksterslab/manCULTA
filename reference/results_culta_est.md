# Simulation Results (CULTA Estimates)

Simulation Results (CULTA Estimates)

## Usage

``` r
data(results_culta_est)
```

## Format

A dataframe with 165 rows and 22 columns:

- taskid:

  Task ID.

- replications:

  Number of replications.

- parnames:

  Parameter names

- parameter:

  Population parameter value.

- model:

  Fitted model.

- n:

  Sample size.

- est:

  Mean parameter estimate.

- se:

  Mean standard error.

- z:

  Mean \\z\\ statistic.

- p:

  Mean \\p\\-value.

- ll:

  Mean lower limit of the 95% confidence interval.

- ul:

  Mean upper limit of the 95% confidence interval.

- sig:

  Proportion of statistically significant results.

- theta_hit:

  Proportion of replications where the confidence intervals contained
  the population parameter.

- sq_error:

  Mean squared error.

- bias:

  Bias.

- rel_bias:

  Relative bias.

- se_bias:

  Bias in standard error estimate.

- rel_se_bias:

  Relative bias in standard error estimate.

- rmse:

  Root mean square error.

- coverage:

  Coverage probability.

- power:

  Statistical power.

## Author

Ivan Jacob Agaloos Pesigan
