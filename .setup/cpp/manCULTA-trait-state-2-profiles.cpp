// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-trait-state-mean.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.TraitState2Profiles)]]
arma::mat TraitState2Profiles(const arma::mat& mu_profile,
                              const arma::mat& trait, const arma::mat& state,
                              const arma::imat& categorical) {
  int p = trait.n_rows;
  int n = trait.n_cols;
  int t = categorical.n_rows;
  arma::mat out(p * t, n);
  arma::mat occasion(p, n);
  for (int i = 0; i < t; ++i) {
    for (int j = 0; j < p; ++j) {
      for (int k = 0; k < n; ++k) {
        occasion(j, k) =
            (categorical(i, k) == 0) ? mu_profile(j, 0) : mu_profile(j, 1);
      }
    }
    out.rows(i * p, (i + 1) * p - 1) = occasion + trait;
  }
  return out + state;
}
