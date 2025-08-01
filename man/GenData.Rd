% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCULTA-gen-data.R
\name{GenData}
\alias{GenData}
\title{Simulate Data}
\usage{
GenData(taskid)
}
\arguments{
\item{taskid}{Positive integer.
Task ID.}
}
\description{
The function simulates data using
the \code{\link[=GenCULTA2Profiles]{GenCULTA2Profiles()}} function.
}
\examples{
\dontrun{
set.seed(42)
sim <- GenData(taskid = 1)
as.matrix(sim)
}
}
\seealso{
Other Data Generation Functions: 
\code{\link{GenCULTA2Profiles}()}
}
\concept{Data Generation Functions}
\keyword{gendata}
\keyword{manCULTA}
