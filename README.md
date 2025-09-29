manCULTA
================
Ivan Jacob Agaloos Pesigan
2025-09-29

<!-- README.md is generated from .setup/readme/README.Rmd. Please edit that file -->

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/DOI/10.0000/0000000000.svg)](https://doi.org/10.0000/0000000000)
<!-- badges: end -->

## Description

Research compendium for the manuscript Pesigan, I. J. A., Russell, M.
A., Chow, S.-M. (2025). Common and Unique Latent Transition Analysis
(CULTA) as a Way to Examine the Trait-State Dynamics of Alcohol
Intoxication. *Psychology of Addictive Behaviors*
<https://doi.org/10.0000/0000000000>.

## Acknowledgments

This research was made possible by the Prevention and Methodology
Training Program (PAMT) funded by a T32 training grant (T32 DA017629,
MPIs: J. Maggs & S. Lanza) from the National Institute on Drug Abuse
(NIDA); the National Center for Advancing Translational Sciences grant
UL1TR002014-06; and pilot mentoring and professional development awards
through P50DA039838 awarded to Michael A. Russell (National Institute on
Drug Abuse, PI: L. Collins), as well as support from the Social Science
Research Institute at Penn State and departmental funds awarded to
Michael A. Russell.

Computations for this research were performed on the Pennsylvania State
University’s Institute for Computational and Data Sciences’ Roar
supercomputer using SLURM for job scheduling (Yoo et al., 2003), GNU
Parallel to run the simulations in parallel (Tange, 2021), and Apptainer
to ensure a reproducible software stack (Kurtzer et al., 2017, 2021).
See `.sim/README.md` and the scripts in the `.sim` folder in the
[GitHub](https://github.com/jeksterslab/manCULTA) repository for more
details on how the simulations were performed.

## Installation

You can install `manCULTA` from
[GitHub](https://github.com/jeksterslab/manCULTA) with:

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("jeksterslab/manCULTA")
```

See
[Containers](https://jeksterslab.github.io/manCULTA/articles/containers.html)
for containerized versions of the package.

## Author-Accepted Manuscript

See
<https://github.com/jeksterslab/manCULTA/blob/main/.setup/latex/manCULTA-manuscript.Rtex>
for the latex file of the manuscript. See
<https://github.com/jeksterslab/manCULTA/blob/latex/manCULTA-manuscript.pdf>
for the compiled PDF.

## More Information

See [GitHub Pages](https://jeksterslab.github.io/manCULTA/index.html)
for package documentation.
