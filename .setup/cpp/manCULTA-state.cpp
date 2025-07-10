// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-state.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.State)]]
arma::mat State(const arma::mat& common_state,
                const arma::mat& common_state_loading, const arma::mat& theta) {
  int t = common_state.n_rows;
  int n = common_state.n_cols;
  int p = common_state_loading.n_rows;
  arma::mat out(t * p, n);
  for (int i = 0; i < t; ++i) {
    arma::rowvec eta_i = common_state.row(i);
    arma::mat load_eta = common_state_loading * eta_i;
    arma::mat noise = RandMultiNorm(n, theta);
    arma::mat signal_plus_noise = load_eta + noise;
    out.rows(i * p, (i + 1) * p - 1) = signal_plus_noise;
  }
  return out;
}
