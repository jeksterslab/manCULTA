# Simulation Replication - FitCULTA2Profiles

Simulation Replication - FitCULTA2Profiles

## Usage

``` r
SimFitCULTA2Profiles(
  taskid,
  repid,
  output_folder,
  seed,
  suffix,
  overwrite,
  integrity,
  mplus_bin,
  starts,
  stiterations,
  stscale,
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

  Vector of positive integer of length two. Number of initial stage
  starts and number of final stage optimizations.

- stiterations:

  Positive integer. Number of initial stage iterations.

- stscale:

  Positive integer. Random start scale.

- max_iter:

  Positive integer. Maximum number of reruns.

## Value

The output is saved as an external file in `output_folder`.

## Details

This function is executed via the `Sim` function.

## Author

Ivan Jacob Agaloos Pesigan
