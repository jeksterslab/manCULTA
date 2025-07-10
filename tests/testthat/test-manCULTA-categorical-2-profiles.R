## ---- test-manCULTA-categorical-state
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    patterns <- apply(
      X = do.call(
        expand.grid,
        replicate(6, 0:1, simplify = FALSE)
      ),
      MARGIN = 1,
      FUN = paste0,
      collapse = ""
    )
    foo <- function(i,
                    patterns,
                    covariate) {
      x <- summary(
        object = Categorical2Profiles(
          covariate = covariate,
          nu_0 = -3.563,
          kappa_0 = 0.122,
          alpha_0 = -3.586,
          beta_00 = 2.250,
          gamma_00 = 0.063,
          gamma_10 = 0.094,
          m = 6
        )
      )
      out <- as.vector(x)
      names(out) <- names(x)
      results <- sapply(
        X = patterns,
        FUN = function(pat) {
          if (pat %in% names(out)) {
            out[pat]
          } else {
            0
          }
        }
      )
      names(results) <- patterns
      results
    }
    out <- do.call(
      what = "rbind",
      args = lapply(
        X = seq_len(n),
        FUN = foo,
        patterns = patterns,
        covariate = CovariateSample()
      )
    )
    y <- c(
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00459,
      0.00917,
      0.00917,
      0.00917,
      0.00917,
      0.00917,
      0.00917,
      0.00917,
      0.01376,
      0.01376,
      0.01835,
      0.01835,
      0.02294,
      0.02294,
      0.02752,
      0.03670,
      0.03670,
      0.05046,
      0.62844
    )
    y_names <- c(
      111122,
      111222,
      121122,
      121222,
      122112,
      122211,
      211112,
      211122,
      212121,
      221212,
      111112,
      121112,
      212112,
      221122,
      222111,
      222212,
      222221,
      212122,
      221112,
      112222,
      222211,
      211222,
      222112,
      222122,
      212222,
      221222,
      122222,
      222222
    )
    names(y) <- y_names - 111111
    y <- sapply(
      X = patterns,
      FUN = function(pat) {
        if (pat %in% names(y)) {
          y[pat]
        } else {
          0
        }
      }
    )
    names(y) <- patterns
    testthat::test_that(
      text,
      {
        testthat::expect_true(
          all(
            abs(
              round(
                x = y,
                digits = 2
              ) - round(
                x = colMeans(out),
                digits = 2
              )
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manCULTA-categorical-state",
  n = 10000,
  tol = 0.05
)
