## ---- test-manCULTA-unique-trait
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    data <- t(
      UniqueTrait(
        n = n,
        psi_p = diag(2)
      )
    )
    mu_p <- colMeans(data)
    psi_p <- var(data)
    output <- t(
      UniqueTrait(
        n = n,
        psi_p = psi_p,
        mu_p = mu_p
      )
    )
    testthat::test_that(
      paste(text, "mu_p"),
      {
        testthat::expect_true(
          all(
            abs(
              round(
                x = mu_p,
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
      paste(text, "psi_p"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                round(
                  x = psi_p,
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
  text = "test-manCULTA-unique-trait",
  n = 1000000,
  tol = 0.01
)
