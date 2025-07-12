// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-common-state.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>

// [[Rcpp::export(.CommonState2Profiles)]]
arma::mat CommonState2Profiles(const arma::imat& categorical, double phi_0,
                               double phi_1, double psi_s0, double psi_s) {
  int m = categorical.n_rows;
  int n = categorical.n_cols;
  arma::mat out(m, n, arma::fill::zeros);
  out.row(0) = arma::randn(1, n) * std::sqrt(psi_s0);
  arma::mat noise = arma::randn(m - 1, n) * std::sqrt(psi_s);
  for (int t = 1; t < m; ++t) {
    for (int i = 0; i < n; ++i) {
      double phi = phi_0 + (phi_1 - phi_0) * categorical(t, i);
      out(t, i) = phi * out(t - 1, i) + noise(t - 1, i);
    }
  }
  return out;
}
