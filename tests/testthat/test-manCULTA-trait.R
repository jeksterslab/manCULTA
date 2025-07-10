## ---- test-manCULTA-trait
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    p <- 4
    q <- 1
    psi_t <- diag(q)
    common_trait <- CommonTrait(
      n = n,
      psi_t = psi_t
    )
    psi_p <- diag(p)
    unique_trait <- UniqueTrait(
      n = n,
      psi_p = psi_p
    )
    common_trait_loading <- matrix(
      data = 1,
      nrow = p,
      ncol = q
    )
    grand_mean <- rep(x = 2, times = p)
    trait <- Trait(
      common_trait = common_trait,
      unique_trait = unique_trait,
      common_trait_loading = common_trait_loading,
      grand_mean = grand_mean
    )
    class(trait) <- class(trait)[-1]
    data <- as.data.frame(
      t(trait)
    )
    fit <- lavaan::sem(
      model = "eta =~ V1 + V2 + V3 + V4",
      data = data,
      meanstructure = TRUE
    )
    parameters <- c(
      c(
        common_trait_loading[2:p, 1]
      ), # loadings
      diag(psi_p), # residual variance (variance of unique)
      psi_t, # variance of common trait
      grand_mean # intercepts
    )
    testthat::test_that(
      text,
      {
        testthat::expect_true(
          all(
            abs(
              c(
                round(
                  x = parameters,
                  digits = 2
                ) - round(
                  x = lavaan::coef(fit),
                  digits = 2
                )
              )
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manCULTA-trait",
  n = 1000000,
  tol = 0.01
)
