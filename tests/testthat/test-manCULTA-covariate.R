## ---- test-manCULTA-covariate
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    x <- CovariateSample()
    mu_x <- 0.5
    sigma_x <- 0.5
    x <- Covariate(
      n = n,
      mu_x = mu_x,
      sigma_x = sigma_x
    )
    testthat::test_that(
      paste(text, "mu_x"),
      {
        testthat::expect_true(
          all(
            abs(
              round(
                x = mu_x,
                digits = 2
              ) - round(
                x = mean(x),
                digits = 2
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "sigma_x"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                round(
                  x = sigma_x,
                  digits = 2
                ) - round(
                  x = var(x),
                  digits = 2
                )
              )
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manCULTA-covariate",
  n = 1000000,
  tol = 0.01
)
