## ---- test-manCULTA-common-trait
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    data <- t(
      CommonTrait(
        n = n,
        psi_t = diag(2)
      )
    )
    mu_t <- colMeans(data)
    psi_t <- var(data)
    output <- t(
      CommonTrait(
        n = n,
        psi_t = psi_t,
        mu_t = mu_t
      )
    )
    testthat::test_that(
      paste(text, "mu_t"),
      {
        testthat::expect_true(
          all(
            abs(
              round(
                x = mu_t,
                digits = 2
              ) - round(
                x = colMeans(output),
                digits = 2
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "psi_t"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                round(
                  x = psi_t,
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
  text = "test-manCULTA-common-trait",
  n = 1000000,
  tol = 0.01
)
