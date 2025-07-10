#' Symmetric matrix A from Row Major vech(A)
#'
#' Symmetric matrix from its half-vectorization.
#'
#' Generates an
#' \eqn{k \times k}
#' symmetric matrix
#' from a
#' \eqn{\frac{1}{2}k(k + 1)}
#' vector.
#'
#' @return Returns a `k` by `k` matrix.
#'
#' @param x Vector of length `0.5 * k(k + 1)`.
#'   Half-vectorization of a `k` by `k` matrix.
#'   Row major \eqn{\mathrm{vech} \left( \mathbf{A}_{k \times k} \right)}.
#' @param k Positive integer.
#'   Dimension of the `k` by `k` matrix.
#'
#' @family Symmetric Functions
#' @keywords linearAlgebra symmetric internal
#' @noRd
.SymofVech2 <- function(x,
                        k) {
  sym <- matrix(
    data = 0,
    nrow = k,
    ncol = k
  )
  sym[upper.tri(sym, diag = TRUE)] <- x
  sym[lower.tri(sym)] <- t(sym)[lower.tri(sym)]
  sym
}
