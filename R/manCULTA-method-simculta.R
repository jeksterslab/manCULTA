.VarNames <- function(p,
                      m) {
  out <- sapply(
    X = seq_len(m),
    FUN = function(m,
                   y_names) {
      paste0(y_names, "t", m - 1)
    },
    y_names = paste0(
      "y",
      seq_len(p)
    )
  )
  dim(out) <- NULL
  out
}

.MatSimCulta <- function(y,
                         x,
                         m,
                         p,
                         id = NULL) {
  if (is.null(id)) {
    id <- seq_len(dim(y)[2])
  }
  rownames(y) <- .VarNames(
    p = p,
    m = m
  )
  colnames(y) <- id
  cbind(
    id = id,
    covariate = x,
    t(y)
  )
}

#' Coerce an Object of Class `simculta` to a Matrix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `simculta`.
#' @param ... Additional arguments.
#'
#' @examples
#' x <- GenCULTA2Profiles(
#'   n = 10,
#'   m = 6,
#'   common_trait_loading = matrix(
#'     data = c(1, 1.25, 1.50, 1.75),
#'     ncol = 1
#'   ),
#'   common_state_loading = matrix(
#'     data = c(1, 1.5, 1.75, 2.00),
#'     ncol = 1
#'   ),
#'   mu_t = NULL,
#'   psi_t = NULL,
#'   mu_p = NULL,
#'   psi_p = NULL,
#'   theta = diag(4),
#'   mu_profile = cbind(
#'     c(-3, -3, -3, -3),
#'     c(3, 3, 3, 3)
#'   ),
#'   mu_x = 0,
#'   sigma_x = 1,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   phi_0 = 0.311,
#'   phi_1 = 0,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#' as.matrix(x)
#'
#' @keywords methods
#' @export
as.matrix.simculta <- function(x,
                               ...) {
  .MatSimCulta(
    y = x$data,
    x = x$covariate,
    m = x$args$m,
    p = x$args$p,
    id = x$id
  )
}

#' Coerce an Object of Class `simculta` to a Data Frame
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `simculta`.
#' @param ... Additional arguments.
#'
#' @examples
#' x <- GenCULTA2Profiles(
#'   n = 10,
#'   m = 6,
#'   common_trait_loading = matrix(
#'     data = c(1, 1.25, 1.50, 1.75),
#'     ncol = 1
#'   ),
#'   common_state_loading = matrix(
#'     data = c(1, 1.5, 1.75, 2.00),
#'     ncol = 1
#'   ),
#'   mu_t = NULL,
#'   psi_t = NULL,
#'   mu_p = NULL,
#'   psi_p = NULL,
#'   theta = diag(4),
#'   mu_profile = cbind(
#'     c(-3, -3, -3, -3),
#'     c(3, 3, 3, 3)
#'   ),
#'   mu_x = 0,
#'   sigma_x = 1,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   phi_0 = 0.311,
#'   phi_1 = 0,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#' as.data.frame(x)
#'
#' @keywords methods
#' @export
as.data.frame.simculta <- function(x,
                                   ...) {
  as.data.frame(
    as.matrix.simculta(x)
  )
}


#' Write Data to File
#'
#' Generic function to write data to file.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `simculta`.
#' @param file Character string.
#'   File name.
#' @param ... Additional arguments.
#'
#' @return Invisibly returns `NULL`. Writes data to file as a side effect.
#'
#' @keywords methods
#' @export
WriteData <- function(x,
                      file,
                      ...) {
  UseMethod("WriteData")
}

#' @describeIn WriteData Method for objects of class `simculta`.
#' @export
WriteData.simculta <- function(x,
                               file,
                               ...) {
  utils::write.table(
    x = as.matrix.simculta(x),
    file = file,
    row.names = FALSE,
    col.names = FALSE,
    ...
  )
  invisible(NULL)
}

#' Print Method for an Object of Class `simculta`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Object of class `simculta`.
#' @param ... Additional arguments.
#'
#' @examples
#' x <- GenCULTA2Profiles(
#'   n = 10,
#'   m = 6,
#'   common_trait_loading = matrix(
#'     data = c(1, 1.25, 1.50, 1.75),
#'     ncol = 1
#'   ),
#'   common_state_loading = matrix(
#'     data = c(1, 1.5, 1.75, 2.00),
#'     ncol = 1
#'   ),
#'   mu_t = NULL,
#'   psi_t = NULL,
#'   mu_p = NULL,
#'   psi_p = NULL,
#'   theta = diag(4),
#'   mu_profile = cbind(
#'     c(-3, -3, -3, -3),
#'     c(3, 3, 3, 3)
#'   ),
#'   mu_x = 0,
#'   sigma_x = 1,
#'   nu_0 = -3.563,
#'   kappa_0 = 0.122,
#'   alpha_0 = -3.586,
#'   beta_00 = 2.250,
#'   gamma_00 = 0.063,
#'   gamma_10 = 0.094,
#'   phi_0 = 0.311,
#'   phi_1 = 0,
#'   psi_s0 = 0.151,
#'   psi_s = 0.290
#' )
#' print(x)
#'
#' @keywords methods
#' @export
print.simculta <- function(x,
                           ...) {
  cat("Call:\n")
  base::print(x$call)
  cat(
    paste0(
      "Use `as.data.frame` or `as.matrix` on the output of",
      " `",
      x$fun,
      "`",
      "\nto convert it to a data frame or a matrix.\n",
      "\n"
    )
  )
}
