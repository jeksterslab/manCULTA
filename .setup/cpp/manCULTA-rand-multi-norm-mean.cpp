// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-rand-multi-norm-mean.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.RandMultiNormMean)]]
arma::mat RandMultiNormMean(const int n, const arma::vec& mu,
                            const arma::mat& sigma) {
  int p = mu.n_elem;
  arma::mat y = arma::randn(n, p);
  arma::mat l = arma::chol(sigma, "lower");
  arma::mat out = (y * l.t()).t();
  out.each_col() += mu;
  return out;
}
