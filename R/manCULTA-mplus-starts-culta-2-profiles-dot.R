.MplusStartsCULTA2Profiles <- function(p,
                                       m,
                                       fn_data,
                                       fn_estimates,
                                       fn_results,
                                       fn_tech3,
                                       fn_tech4,
                                       fn_cprobs,
                                       ncores,
                                       starts,
                                       stscale,
                                       stiterations,
                                       nu_0,
                                       kappa_0,
                                       alpha_0,
                                       beta_00,
                                       gamma_00,
                                       gamma_10,
                                       psi_t,
                                       psi_p,
                                       common_trait_loading,
                                       common_state_loading,
                                       phi_0,
                                       phi_1,
                                       psi_s0,
                                       psi_s,
                                       theta,
                                       mu_profile) {
  stopifnot(
    length(starts) == 2
  )

  common_trait_loading <- c(common_trait_loading)
  common_state_loading <- c(common_state_loading)
  theta <- diag(theta)
  psi_p <- diag(psi_p)
  psi_t <- c(psi_t)

  ## Mplus Analysis
  starts <- paste0(
    as.integer(starts),
    collapse = " "
  )
  starts <- paste0(
    "  STARTS = ",
    starts,
    ";"
  )
  stscale <- paste0(
    "  STSCALE = ",
    as.integer(stscale[1]),
    ";"
  )
  stiterations <- paste0(
    "  STITERATIONS = ",
    as.integer(stiterations[1]),
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
            "    !!! t = %d",
            t
          ),
          sprintf(
            ifelse(
              test = seq_p == 1,
              yes = "    t BY y%dt%d@1;",
              no = paste0(
                "    t BY y%dt%d*",
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
            "    !!! k = %d",
            k
          ),
          sprintf(
            "    u%d BY y%dt%d@1;",
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
            "    !!! t = %d",
            t
          ),
          sprintf(
            ifelse(
              test = seq_p == 1,
              yes = "    s%d BY y%dt%d@1;",
              no = paste0(
                "    s%d BY y%dt%d*",
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
            "    !!! t = %d",
            t
          ),
          sprintf(
            "    y%dt%d*%g (theta%d%d);",
            seq_p, t, theta, seq_p, seq_p
          )
        )
      }
    )
  )

  ## Helper: Constrained Intercepts
  constrained_intercepts <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        c(
          sprintf(
            "    !! t = %d",
            t
          ),
          sprintf(
            "    [ y%dt%d@0 ];",
            seq_p,
            t
          )
        )
      }
    )
  )

  ## Helper: Profile Transitions
  profile_transitions <- c(
    sprintf(
      paste0(
        "    [ c%d#1*",
        alpha_0,
        " ] (alpha0);"
      ),
      seq_1_m_minus_1
    ),
    sprintf(
      paste0(
        "    c%d#1 ON c%d#1*",
        beta_00,
        " (beta00);"
      ),
      seq_1_m_minus_1,
      0:(m - 2)
    )
  )

  ## Helper: MODEL Blocks for c0 to c(m-1)
  model_blocks <- unlist(
    lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        # Begin block for MODEL c[t]
        block <- sprintf("MODEL c%d:", t)

        for (k in 1:2) {
          block <- c(
            block,
            sprintf(
              "  %%c%d#%d%%",
              t,
              k
            ),
            "    ! profile specific means",
            sprintf(
              "    [ y%dt%d*%g ] (mu%d%d);",
              seq_p,
              t,
              mu_profile[, k],
              seq_p,
              k - 1
            )
          )

          if (t == 0) {
            block <- c(
              block,
              "",
              "    ! covariate",
              sprintf(
                "    c1 ON x*%g (gamma%d0);",
                ifelse(
                  test = k == 1,
                  yes = gamma_00,
                  no = gamma_10
                ),
                k - 1
              ),
              ""
            )
          } else {
            if (t == m - 1) {
              block <- c(
                block,
                "",
                "    ! inertia",
                sprintf(
                  "    s%d ON s%d*%g (phi%d);",
                  t, t - 1,
                  ifelse(
                    test = k == 1,
                    yes = phi_0,
                    no = phi_1
                  ),
                  k - 1
                ),
                ""
              )
            } else {
              block <- c(
                block,
                "",
                "    ! covariate",
                sprintf(
                  "    c%d ON x*%g (gamma%d0);",
                  t + 1,
                  ifelse(
                    test = k == 1,
                    yes = gamma_00,
                    no = gamma_10
                  ),
                  k - 1
                ),
                "",
                "    ! inertia",
                sprintf(
                  "    s%d ON s%d*%g (phi%d);",
                  t, t - 1,
                  ifelse(
                    test = k == 1,
                    yes = phi_0,
                    no = phi_1
                  ),
                  k - 1
                ),
                ""
              )
            }
          }
        }

        block
      }
    )
  )

  ## Assemble All Sections
  out <- c(
    "TITLE:",
    "  2-Profile CULTA with Covariate;",
    "",
    "DATA:",
    sprintf(
      "  FILE = %s;",
      fn_data
    ),
    "",
    "VARIABLE:",
    "  NAMES =",
    "    id",
    "    x",
    paste0(
      "    ",
      y_names
    ),
    "  ;",
    "  USEVARIABLES =",
    "    x",
    paste0(
      "    ",
      y_names
    ),
    "  ;",
    "  IDVARIABLE = id;",
    "  CLASSES =",
    paste0(
      "    c",
      seq_0_m_minus_1,
      "(2)"
    ),
    "  ;",
    "",
    "ANALYSIS:",
    "  TYPE = MIXTURE;",
    starts,
    stscale,
    stiterations,
    sprintf(
      "  PROCESS = %d;",
      ncores
    ),
    "  MODEL = NOCOV;",
    "",
    "MODEL:",
    "  %OVERALL%",
    "    ! common trait ------------------------------------------------------",
    "",
    "    !! factor loadings",
    common_trait,
    "",
    "    !! latent mean",
    "    [ t@0 ];",
    "",
    "    !! latent variance",
    paste0("    t*", psi_t, " (psit);"),
    "",
    "    ! unique traits -----------------------------------------------------",
    "",
    "    !! factor loadings",
    unique_traits,
    "",
    "    !! latent means",
    sprintf(
      "    [ u%d@0 ];",
      seq_p
    ),
    "",
    "    !! latent variances",
    sprintf(
      "    u%d*%g (psip%d);",
      seq_p,
      psi_p,
      seq_p
    ),
    "",
    "    ! common states -----------------------------------------------------",
    "",
    "    !! factor loadings",
    common_states,
    "",
    "    !! latent means",
    sprintf(
      "    [ s%d@0 ];",
      seq_0_m_minus_1
    ),
    "",
    "    !! latent variance of s0",
    paste0("    s0*", psi_s0, " (psis0);"),
    "",
    "    !! variance of the process noise",
    sprintf(
      paste0("    s%d*", psi_s, " (psis);"),
      seq_1_m_minus_1
    ),
    "",
    "    ! unique states -----------------------------------------------------",
    "",
    "    !! variances",
    unique_states,
    "",
    "    ! constrained intercepts --------------------------------------------",
    "",
    constrained_intercepts,
    "",
    "    ! lta ---------------------------------------------------------------",
    "",
    "    !! initial profile membership",
    paste0("    [ c0#1*", nu_0, " ] (nu0);"),
    paste0("    c0#1 ON x*", kappa_0, " (kappa0);"),
    "",
    "    !! profile transitions",
    profile_transitions,
    "",
    model_blocks,
    "",
    "MODEL CONSTRAINT:",
    "  ! means for the first profile are higher than the second",
    sprintf(
      "  mu%d0 > mu%d1;",
      seq_p,
      seq_p
    ),
    "",
    "  ! make sure variances are greater than zero",
    "  psit > 0;",
    sprintf(
      "  psip%d > 0;",
      seq_p
    ),
    "  psis0 > 0;",
    "  psis > 0;",
    sprintf(
      "  theta%d%d > 0;",
      seq_p,
      seq_p
    ),
    "",
    "OUTPUT:",
    "  TECH1",
    "  TECH3",
    "  TECH4",
    "  TECH7",
    "  TECH8",
    "  TECH12",
    "  TECH13",
    "  TECH15",
    "  ENTROPY;",
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
    ),
    sprintf(
      "  FILE = %s;",
      fn_cprobs
    ),
    "  SAVE = CPROBABILITIES;"
  )
  paste(
    out,
    collapse = "\n"
  )
}
