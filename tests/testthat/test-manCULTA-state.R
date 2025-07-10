## ---- test-manCULTA-state
lapply(
  X = c(0, 1),
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    set.seed(42)
    m <- 6
    p <- 4
    q <- 1
    beta_0 <- 0
    beta_1 <- 0.311
    psi_s0 <- 0.151
    psi_s <- 0.290
    if (i == 0) {
      beta <- beta_0
    } else {
      beta <- beta_1
    }
    categorical <- matrix(
      data = i,
      nrow = m,
      ncol = n
    )
    common_state <- CommonState2Profiles(
      categorical = categorical,
      beta_0 = beta_0,
      beta_1 = beta_1,
      psi_s0 = psi_s0,
      psi_s = psi_s
    )
    common_state_loading <- matrix(
      data = c(1, 2, 3, 4), # The first value should always be 1.
      nrow = p,
      ncol = q
    )
    theta <- diag(p)
    state <- State(
      common_state = common_state,
      common_state_loading = common_state_loading,
      theta = theta
    )
    class(state) <- class(state)[-1]
    data <- as.data.frame(
      t(state)
    )
    varnames <- paste0("y", seq_len(p))
    varnames <- do.call(
      what = "cbind",
      args = lapply(
        X = 0:(m - 1),
        FUN = function(x) {
          paste0(varnames, "t", x)
        }
      )
    )
    dim(varnames) <- NULL
    colnames(data) <- varnames
    model <- "
      st0 =~ y1t0 + y2t0 + y3t0 + y4t0
      st1 =~ y1t1 + y2t1 + y3t1 + y4t1
      st2 =~ y1t2 + y2t2 + y3t2 + y4t2
      st3 =~ y1t3 + y2t3 + y3t3 + y4t3
      st4 =~ y1t4 + y2t4 + y3t4 + y4t4
      st5 =~ y1t5 + y2t5 + y3t5 + y4t5
      st5 ~ st4
      st4 ~ st3
      st3 ~ st2
      st2 ~ st1
      st1 ~ st0
    "
    fit <- lavaan::sem(
      model = model,
      data = data,
      meanstructure = TRUE
    )
    parameters <- c(
      rep(
        x = common_state_loading[-1],
        times = m
      ),
      rep(
        x = beta,
        times = m - 1
      ),
      rep(
        x = diag(theta),
        times = m
      ),
      psi_s0,
      rep(
        x = psi_s,
        times = m - 1
      ),
      rep(
        x = 0,
        times = p * m
      )
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
  text = "test-manCULTA-state",
  n = 1000000,
  tol = 0.05
)
