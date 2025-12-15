# Simulate Data

The function simulates data using the
[`GenCULTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/GenCULTA2Profiles.md)
function.

## Usage

``` r
GenData(taskid)
```

## Arguments

- taskid:

  Positive integer. Task ID.

## See also

Other Data Generation Functions:
[`GenCULTA2Profiles()`](https://github.com/jeksterslab/manCULTA/reference/GenCULTA2Profiles.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
sim <- GenData(taskid = 1)
as.matrix(sim)
} # }
```
