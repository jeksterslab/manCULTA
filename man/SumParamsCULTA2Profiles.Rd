% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCULTA-sum-params-culta-2-profiles.R
\name{SumParamsCULTA2Profiles}
\alias{SumParamsCULTA2Profiles}
\title{Summary (ParamsCULTA2Profiles)}
\usage{
SumParamsCULTA2Profiles(
  taskid,
  reps,
  output_folder,
  overwrite,
  integrity,
  ncores = 1L
)
}
\arguments{
\item{taskid}{Positive integer.
Task ID.}

\item{reps}{Positive integer.
Number of replications.}

\item{output_folder}{Character string.
Output folder.}

\item{overwrite}{Logical.
Overwrite existing output in \code{output_folder}.}

\item{integrity}{Logical.
If \code{integrity = TRUE},
check for the output file integrity when \code{overwrite = FALSE}.}

\item{ncores}{Positive integer.
Number of cores to use.}
}
\value{
The output is saved as an external file in \code{output_folder}.
}
\description{
Summary (ParamsCULTA2Profiles)
}
\details{
This function is executed via the \code{Sum} function.
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{manCULTA}
\keyword{simulation}
\keyword{summary}
