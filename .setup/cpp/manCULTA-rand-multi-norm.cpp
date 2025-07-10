// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-rand-multi-norm.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.RandMultiNorm)]]
arma::mat RandMultiNorm(const int n, const arma::mat& sigma) {
  int p = sigma.n_cols;
  arma::mat y = arma::randn(n, p);
  arma::mat l = arma::chol(sigma, "lower");
  arma::mat out = (y * l.t()).t();
  return out;
}
