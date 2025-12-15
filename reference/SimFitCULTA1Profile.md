# Simulation Replication - FitCULTA1Profile

Simulation Replication - FitCULTA1Profile

## Usage

``` r
SimFitCULTA1Profile(
  taskid,
  repid,
  output_folder,
  seed,
  suffix,
  overwrite,
  integrity,
  mplus_bin,
  starts,
  max_iter
)
```

## Arguments

- taskid:

  Positive integer. Task ID.

- repid:

  Positive integer. Replication ID.

- output_folder:

  Character string. Output folder.

- seed:

  Integer. Random seed.

- suffix:

  Character string. Output of `manCULTA:::.SimSuffix()`.

- overwrite:

  Logical. Overwrite existing output in `output_folder`.

- integrity:

  Logical. If `integrity = TRUE`, check for the output file integrity
  when `overwrite = FALSE`.

- mplus_bin:

  Character string. Path to Mplus binary. If `mplus_bin = NULL`, the
  function will try to find the appropriate binary.

- starts:

  Positive integer. Number of initial stage starting values.

- max_iter:

  Positive integer. Maximum number of reruns.

## Value

The output is saved as an external file in `output_folder`.

## Details

This function is executed via the `Sim` function.

## Author

Ivan Jacob Agaloos Pesigan
