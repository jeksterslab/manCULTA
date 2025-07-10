## ---- test-manCULTA-unique-state
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    data <- t(
      UniqueState(
        n = n,
        theta = diag(2)
      )
    )
    mu <- colMeans(data)
    theta <- var(data)
    output <- t(
      UniqueState(
        n = n,
        theta = theta
      )
    )
    testthat::test_that(
      paste(text, "mu"),
      {
        testthat::expect_true(
          all(
            abs(
              round(
                x = mu,
                digits = 2
              ) - round(
                x = colMeans(output),
                digits = 2
              ) <= tol
            )
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "theta"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                round(
                  x = theta,
                  digits = 2
                ) - round(
                  x = var(output),
                  digits = 2
                )
              )
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manCULTA-unique-state",
  n = 1000000,
  tol = 0.01
)
