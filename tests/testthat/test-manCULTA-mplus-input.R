## ---- test-manCULTA-mplus-input
lapply(
  X = c(0, 1),
  FUN = function(i,
                 text) {
    message(text)
    p <- 4
    m <- 6
    fn_data <- "data"
    fn_estimates <- "estimates"
    fn_results <- "results"
    fn_tech3 <- "tech3"
    fn_tech4 <- "tech4"
    fn_cprobs <- "cprobs"
    manCULTA:::.MplusCULTA1Profile(
      p = p,
      m = m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      starts = 10
    )
    manCULTA:::.MPlusCULTA1ProfileParams(p = p)
    manCULTA:::.MplusCULTA2Profiles(
      p = p,
      m = m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      fn_cprobs = fn_cprobs,
      ncores = 1,
      starts = c(20, 4),
      stiterations = 10,
      stscale = 5
    )
    manCULTA:::.MPlusCULTA2ProfileParams(p = p)
    manCULTA:::.MplusLTA2Profiles(
      p = p,
      m = m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      fn_cprobs = fn_cprobs,
      ncores = 1,
      starts = c(20, 4),
      stiterations = 10,
      stscale = 5
    )
    manCULTA:::.MplusRILTA2Profiles(
      p = p,
      m = m,
      fn_data = fn_data,
      fn_estimates = fn_estimates,
      fn_results = fn_results,
      fn_tech3 = fn_tech3,
      fn_tech4 = fn_tech4,
      fn_cprobs = fn_cprobs,
      ncores = 1,
      starts = c(20, 4),
      stiterations = 10,
      stscale = 5
    )
  },
  text = "test-manCULTA-mplus-input"
)
