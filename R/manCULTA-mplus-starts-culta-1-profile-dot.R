.MplusStartsCULTA1Profile <- function(p,
                                      m,
                                      fn_data,
                                      fn_estimates,
                                      fn_results,
                                      fn_tech3,
                                      fn_tech4,
                                      fn_cprobs,
                                      ncores,
                                      starts,
                                      psi_t,
                                      psi_p,
                                      common_trait_loading,
                                      common_state_loading,
                                      psi_s0,
                                      psi_s,
                                      theta) {
  common_trait_loading <- c(common_trait_loading)
  common_state_loading <- c(common_state_loading)
  theta <- diag(theta)
  psi_p <- diag(psi_p)
  psi_t <- c(psi_t)

  ## Mplus Analysis
  starts <- paste0(
    "  STARTS = ",
    as.integer(starts[1]),
    ";"
  )

  ## Sequences
  seq_p <- seq_len(length.out = p)
  seq_0_m_minus_1 <- seq_len(length.out = m) - 1
  seq_1_m_minus_1 <- seq_len(length.out = m - 1)

  ## Helper: Item-Time Labels
  y_names <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        sprintf(
          "y%dt%d",
          seq_p,
          t
        )
      }
    )
  )

  ## Helper: Common Trait Loadings
  common_trait <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        c(
          sprintf(
            "  !!! t = %d",
            t
          ),
          sprintf(
            ifelse(
              test = seq_p == 1,
              yes = "  t BY y%dt%d@1;",
              no = paste0(
                "  t BY y%dt%d*",
                common_trait_loading[seq_p],
                " (lambdat%d);"
              )
            ),
            seq_p,
            t,
            seq_p
          )
        )
      }
    )
  )

  ## Helper: Unique Traits Loadings
  unique_traits <- unlist(
    x = lapply(
      X = seq_p,
      FUN = function(k) {
        c(
          sprintf(
            "  !!! k = %d",
            k
          ),
          sprintf(
            "  u%d BY y%dt%d@1;",
            k,
            k,
            seq_0_m_minus_1
          )
        )
      }
    )
  )

  ## Helper: Common States Loadings
  common_states <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        c(
          sprintf(
            "  !!! t = %d",
            t
          ),
          sprintf(
            ifelse(
              test = seq_p == 1,
              yes = "  s%d BY y%dt%d@1;",
              no = paste0(
                "  s%d BY y%dt%d*",
                common_state_loading[seq_p],
                " (lambdas%d);"
              )
            ),
            t,
            seq_p,
            t,
            seq_p
          )
        )
      }
    )
  )

  ## Helper: Unique States Variances
  unique_states <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        c(
          sprintf(
            "  !!! t = %d",
            t
          ),
          sprintf(
            "  y%dt%d*%g (theta%d%d);",
            seq_p, t, theta, seq_p, seq_p
          )
        )
      }
    )
  )

  ## Helper: Grand Means
  grand_means <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        c(
          sprintf(
            "  !! t = %d",
            t
          ),
          sprintf(
            "  [ y%dt%d*0 ] (mu%d);",
            seq_p,
            t,
            seq_p
          )
        )
      }
    )
  )

  ## Output Text: Inertia
  inertia <- sprintf(
    "  s%d ON s%d*0 (phi);",
    seq_0_m_minus_1[-length(seq_0_m_minus_1)],
    seq_0_m_minus_1[-1]
  )

  out <- c(
    "TITLE:",
    "  CUTS with AR;",
    "",
    "DATA:",
    sprintf("  FILE = %s;", fn_data),
    "",
    "VARIABLE:",
    "  NAMES =",
    "    id",
    "    x",
    paste0("    ", y_names),
    "  ;",
    "  USEVARIABLES =",
    paste0("    ", y_names),
    "  ;",
    "",
    "ANALYSIS:",
    "  TYPE = GENERAL;",
    "  ESTIMATOR = MLR;",
    starts,
    "  MODEL = NOCOV;",
    "",
    "MODEL:",
    "  ! common trait ------------------------------------------------------",
    "",
    "  !! factor loadings",
    common_trait,
    "",
    "  !! latent mean",
    "  [ t@0 ];",
    "",
    "  !! latent variance",
    paste0("  t*", psi_t, " (psit);"),
    "",
    "  ! unique traits -----------------------------------------------------",
    "",
    "  !! factor loadings",
    unique_traits,
    "",
    "  !! latent means",
    sprintf("  [ u%d@0 ];", seq_p),
    "",
    "",
    "  !! latent variances",
    sprintf(
      "  u%d*%g (psip%d);",
      seq_p,
      psi_p,
      seq_p
    ),
    "",
    "  ! common states -----------------------------------------------------",
    "",
    "  !! factor loadings",
    common_states,
    "",
    "  !! latent means",
    sprintf("  [ s%d@0 ];", seq_0_m_minus_1),
    "",
    "  !! latent variance of s0",
    paste0("  s0*", psi_s0, " (psis0);"),
    "",
    "  !! variance of the process noise",
    sprintf(
      paste0("  s%d*", psi_s, " (psis);"),
      seq_1_m_minus_1
    ),
    "",
    "  ! unique states -----------------------------------------------------",
    "",
    "  !! variances",
    unique_states,
    "",
    "  ! grand means -------------------------------------------------------",
    "",
    grand_means,
    "",
    "  ! inertia -----------------------------------------------------------",
    "",
    inertia,
    "",
    "MODEL CONSTRAINT:",
    "  ! variance constraints",
    "  psit > 0;",
    sprintf("  psip%d > 0;", seq_p),
    "  psis0 > 0;",
    "  psis > 0;",
    sprintf("  theta%d%d > 0;", seq_p, seq_p),
    "",
    "OUTPUT:",
    "  TECH1",
    "  TECH3",
    "  TECH4;",
    "",
    "SAVEDATA:",
    sprintf(
      "  ESTIMATES = %s;",
      fn_estimates
    ),
    sprintf(
      "  RESULTS = %s;",
      fn_results
    ),
    sprintf(
      "  TECH3 = %s;",
      fn_tech3
    ),
    sprintf(
      "  TECH4 = %s;",
      fn_tech4
    )
  )
  paste(
    out,
    collapse = "\n"
  )
}
