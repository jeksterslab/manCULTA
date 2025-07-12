.MplusRILTA2Profiles <- function(p,
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
                                 stiterations) {
  stopifnot(
    length(starts) == 2
  )

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
  ri <- unlist(
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
              yes = "    f BY y%dt%d* (lambdat%d);",
              no = "    f BY y%dt%d (lambdat%d);"
            ),
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
            "    y%dt%d (theta%d%d);",
            seq_p,
            t,
            seq_p,
            seq_p
          )
        )
      }
    )
  )

  ## Helper: Profile Transitions
  profile_transitions <- c(
    sprintf(
      "    [ c%d#1 ] (alpha0);",
      seq_1_m_minus_1
    ),
    sprintf(
      "    c%d#1 ON c%d#1 (beta00);",
      seq_1_m_minus_1,
      0:(m - 2)
    )
  )

  ## Helper: MODEL Blocks for c0 to c(m-1)
  model_blocks <- unlist(
    x = lapply(
      X = seq_0_m_minus_1,
      FUN = function(t) {
        block <- c(
          sprintf(
            "MODEL c%d:",
            t
          ),
          sprintf(
            "  %%c%d#1%%",
            t
          ),
          "    ! profile specific means",
          sprintf(
            "    [ y%dt%d ] (mu%d0);",
            seq_p,
            t,
            seq_p
          )
        )
        if (t == 0) {
          block <- c(
            block,
            "",
            "    ! covariate",
            "    c1 ON x (gamma00);",
            ""
          )
        } else {
          if (t == m - 1) {
            block <- c(
              block,
              ""
            )
          } else {
            block <- c(
              block,
              "",
              "    ! covariate",
              sprintf(
                "    c%d ON x (gamma00);",
                t + 1
              ),
              ""
            )
          }
        }

        block <- c(
          block,
          sprintf(
            "  %%c%d#2%%",
            t
          ),
          "    ! profile specific means",
          sprintf(
            "    [ y%dt%d ] (mu%d1);",
            seq_p,
            t,
            seq_p
          )
        )

        if (t == 0) {
          block <- c(
            block,
            "",
            "    ! covariate",
            "    c1 ON x (gamma10);",
            ""
          )
        } else {
          if (t == m - 1) {
            block <- c(
              block,
              ""
            )
          } else {
            block <- c(
              block,
              "",
              "    ! covariate",
              sprintf(
                "    c%d ON x (gamma10);",
                t + 1
              ),
              ""
            )
          }
        }

        block
      }
    )
  )

  ## Assemble All Sections
  out <- c(
    "TITLE:",
    "  2-Profile RI-LTA with Covariate;",
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
    "    ! random intercept --------------------------------------------------",
    "",
    "    !! loadings",
    ri,
    "",
    "    !! latent mean",
    "    [ f@0 ];",
    "",
    "    !! latent variance",
    "    f@1;",
    "",
    "    ! unique states -----------------------------------------------------",
    "",
    "    !! variances",
    unique_states,
    "",
    "    ! lta ---------------------------------------------------------------",
    "",
    "    !! initial profile membership",
    "    [ c0#1 ] (nu0);",
    "    c0#1 ON x (kappa0);",
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
