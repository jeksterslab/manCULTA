## ---- test-manCULTA-gen-culta-2-profiles
lapply(
  X = 1,
  FUN = function(i,
                 text,
                 n,
                 tol) {
    message(text)
    # complete list of R function arguments

    # random seed for reproducibility
    set.seed(42)

    # dimensions
    n <- 5000 # number of individuals
    m <- 6 # measurement occasions
    p <- 4 # number of items
    q <- 1 # common trait dimension

    # covariate parameters
    mu_x <- 11.4009
    sigma_x <- 24.67566

    # profile membership and transition parameters
    nu_0 <- -3.563
    kappa_0 <- 0.122
    alpha_0 <- -3.586
    beta_00 <- 2.250
    gamma_00 <- 0.063
    gamma_10 <- 0.094

    # trait parameters
    psi_t <- diag(1)
    mu_t <- 0
    psi_p <- diag(p)
    mu_p <- rep(x = 0, times = p)
    common_trait_loading <- matrix(
      data = 1,
      nrow = p,
      ncol = q
    )

    # state parameters
    common_state_loading <- matrix(
      data = 1,
      nrow = p,
      ncol = 1
    )
    phi_0 <- 0.311
    phi_1 <- 0.311
    psi_s0 <- 0.151
    psi_s <- 0.290
    theta <- diag(p)

    # profile-specific means
    mu_profile <- cbind(
      c(0, 0, 0, 0),
      c(0, 0, 0, 0)
    )

    # data

    data <- GenCULTA2Profiles(
      n = n,
      m = m,
      mu_x = mu_x,
      sigma_x = sigma_x,
      nu_0 = nu_0,
      kappa_0 = kappa_0,
      alpha_0 = alpha_0,
      beta_00 = beta_00,
      gamma_00 = gamma_00,
      gamma_10 = gamma_10,
      mu_t = mu_t,
      psi_t = psi_t,
      mu_p = mu_p,
      psi_p = psi_p,
      common_trait_loading = common_trait_loading,
      common_state_loading = common_state_loading,
      phi_0 = phi_0,
      phi_1 = phi_1,
      psi_s0 = psi_s0,
      psi_s = psi_s,
      theta = theta,
      mu_profile = mu_profile
    )

    data <- as.data.frame(data)

    model <- "
      t =~ 1*y1t0 + lambda_t_2*y2t0 + lambda_t_3*y3t0 + lambda_t_4*y4t0
      t =~ 1*y1t1 + lambda_t_2*y2t1 + lambda_t_3*y3t1 + lambda_t_4*y4t1
      t =~ 1*y1t2 + lambda_t_2*y2t2 + lambda_t_3*y3t2 + lambda_t_4*y4t2
      t =~ 1*y1t3 + lambda_t_2*y2t3 + lambda_t_3*y3t3 + lambda_t_4*y4t3
      t =~ 1*y1t4 + lambda_t_2*y2t4 + lambda_t_3*y3t4 + lambda_t_4*y4t4
      t =~ 1*y1t5 + lambda_t_2*y2t5 + lambda_t_3*y3t5 + lambda_t_4*y4t5
      t ~ 0*1
      t ~~ psi_t*t
      u1 =~ 1*y1t0 + 1*y1t1 + 1*y1t2 + 1*y1t3 + 1*y1t4 + 1*y1t5
      u2 =~ 1*y2t0 + 1*y2t1 + 1*y2t2 + 1*y2t3 + 1*y2t4 + 1*y2t5
      u3 =~ 1*y3t0 + 1*y3t1 + 1*y3t2 + 1*y3t3 + 1*y3t4 + 1*y3t5
      u4 =~ 1*y4t0 + 1*y4t1 + 1*y4t2 + 1*y4t3 + 1*y4t4 + 1*y4t5
      u1 ~~ psi_p_1*u1
      u2 ~~ psi_p_2*u2
      u3 ~~ psi_p_3*u3
      u4 ~~ psi_p_4*u4
      s0 =~ 1*y1t0 + lambda_s_2*y2t0 + lambda_s_3*y3t0 + lambda_s_4*y4t0
      s1 =~ 1*y1t1 + lambda_s_2*y2t1 + lambda_s_3*y3t1 + lambda_s_4*y4t1
      s2 =~ 1*y1t2 + lambda_s_2*y2t2 + lambda_s_3*y3t2 + lambda_s_4*y4t2
      s3 =~ 1*y1t3 + lambda_s_2*y2t3 + lambda_s_3*y3t3 + lambda_s_4*y4t3
      s4 =~ 1*y1t4 + lambda_s_2*y2t4 + lambda_s_3*y3t4 + lambda_s_4*y4t4
      s5 =~ 1*y1t5 + lambda_s_2*y2t5 + lambda_s_3*y3t5 + lambda_s_4*y4t5
      s0 ~~ psi_s0*s0
      s1 ~~ psi_s*s1
      s2 ~~ psi_s*s2
      s3 ~~ psi_s*s3
      s4 ~~ psi_s*s4
      s5 ~~ psi_s*s5
      s0 ~ 0*1
      s1 ~ 0*1
      s2 ~ 0*1
      s3 ~ 0*1
      s4 ~ 0*1
      s5 ~ 0*1
      y1t0 ~~ theta_11*y1t0
      y2t0 ~~ theta_22*y2t0
      y3t0 ~~ theta_33*y3t0
      y4t0 ~~ theta_44*y4t0
      y1t1 ~~ theta_11*y1t1
      y2t1 ~~ theta_22*y2t1
      y3t1 ~~ theta_33*y3t1
      y4t1 ~~ theta_44*y4t1
      y1t2 ~~ theta_11*y1t2
      y2t2 ~~ theta_22*y2t2
      y3t2 ~~ theta_33*y3t2
      y4t2 ~~ theta_44*y4t2
      y1t3 ~~ theta_11*y1t3
      y2t3 ~~ theta_22*y2t3
      y3t3 ~~ theta_33*y3t3
      y4t3 ~~ theta_44*y4t3
      y1t4 ~~ theta_11*y1t4
      y2t4 ~~ theta_22*y2t4
      y3t4 ~~ theta_33*y3t4
      y4t4 ~~ theta_44*y4t4
      y1t5 ~~ theta_11*y1t5
      y2t5 ~~ theta_22*y2t5
      y3t5 ~~ theta_33*y3t5
      y4t5 ~~ theta_44*y4t5
      y1t0 ~ mu_1*1
      y2t0 ~ mu_2*1
      y3t0 ~ mu_3*1
      y4t0 ~ mu_4*1
      y1t1 ~ mu_1*1
      y2t1 ~ mu_2*1
      y3t1 ~ mu_3*1
      y4t1 ~ mu_4*1
      y1t2 ~ mu_1*1
      y2t2 ~ mu_2*1
      y3t2 ~ mu_3*1
      y4t2 ~ mu_4*1
      y1t3 ~ mu_1*1
      y2t3 ~ mu_2*1
      y3t3 ~ mu_3*1
      y4t3 ~ mu_4*1
      y1t4 ~ mu_1*1
      y2t4 ~ mu_2*1
      y3t4 ~ mu_3*1
      y4t4 ~ mu_4*1
      y1t5 ~ mu_1*1
      y2t5 ~ mu_2*1
      y3t5 ~ mu_3*1
      y4t5 ~ mu_4*1
      s1 ~ phi*s0
      s2 ~ phi*s1
      s3 ~ phi*s2
      s4 ~ phi*s3
      s5 ~ phi*s4
    "
    no_cov <- combn(
      x = c(
        "t",
        paste0("u", 1:4),
        paste0("s", 0:5)
      ),
      m = 2,
      FUN = function(x) {
        sprintf(
          "%s ~~ 0 * %s",
          x[1],
          x[2]
        )
      }
    )
    model <- paste0(
      model,
      paste(
        no_cov,
        collapse = "\n"
      )
    )
    fit <- lavaan::sem(
      model = model,
      data = data,
      meanstructure = TRUE
    )
    est <- coef(fit)
    testthat::test_that(
      paste(text, "psi_t"),
      {
        testthat::expect_true(
          all(
            abs(
              c(psi_t) - est["psi_t"]
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
              diag(psi_p) - c(
                est["psi_p_1"],
                est["psi_p_2"],
                est["psi_p_3"],
                est["psi_p_4"]
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "common_trait_loading"),
      {
        testthat::expect_true(
          all(
            abs(
              c(common_trait_loading) - c(
                1,
                est["lambda_t_2"],
                est["lambda_t_3"],
                est["lambda_t_4"]
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "common_state_loading"),
      {
        testthat::expect_true(
          all(
            abs(
              c(common_state_loading) - c(
                1,
                est["lambda_s_2"],
                est["lambda_s_3"],
                est["lambda_s_4"]
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "phi_0"),
      {
        testthat::expect_true(
          all(
            abs(
              phi_0 - est["phi"]
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "phi_1"),
      {
        testthat::expect_true(
          all(
            abs(
              phi_1 - est["phi"]
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "psi_s0"),
      {
        testthat::expect_true(
          all(
            abs(
              psi_s0 - est["psi_s0"]
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "psi_s"),
      {
        testthat::expect_true(
          all(
            abs(
              psi_s - est["psi_s"]
            ) <= tol
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
              diag(theta) - c(
                est["theta_11"],
                est["theta_22"],
                est["theta_33"],
                est["theta_44"]
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "mu_0"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                mu_profile[, 1]
              ) - c(
                est["mu_1"],
                est["mu_2"],
                est["mu_3"],
                est["mu_4"]
              )
            ) <= tol
          )
        )
      }
    )
    testthat::test_that(
      paste(text, "mu_1"),
      {
        testthat::expect_true(
          all(
            abs(
              c(
                mu_profile[, 2]
              ) - c(
                est["mu_1"],
                est["mu_2"],
                est["mu_3"],
                est["mu_4"]
              )
            ) <= tol
          )
        )
      }
    )
  },
  text = "test-manCULTA-gen-culta-2-profiles",
  n = 10000,
  tol = 0.05
)
