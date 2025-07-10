// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-common-state.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>

// [[Rcpp::export(.CommonState2Profiles)]]
arma::mat CommonState2Profiles(const arma::imat& categorical, double beta_0,
                               double beta_1, double psi_s0, double psi_s) {
  int m = categorical.n_rows;
  int n = categorical.n_cols;
  arma::mat out(m, n, arma::fill::zeros);
  out.row(0) = arma::randn(1, n) * std::sqrt(psi_s0);
  arma::mat noise = arma::randn(m - 1, n) * std::sqrt(psi_s);
  for (int t = 1; t < m; ++t) {
    for (int i = 0; i < n; ++i) {
      double phi = beta_0 + (beta_1 - beta_0) * categorical(t, i);
      out(t, i) = phi * out(t - 1, i) + noise(t - 1, i);
    }
  }
  return out;
}
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
// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-trait-mean.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.TraitMean)]]
arma::mat TraitMean(const arma::mat& common_trait,
                    const arma::mat& unique_trait,
                    const arma::mat& common_trait_loading,
                    const arma::vec& grand_mean) {
  arma::mat out = common_trait_loading * common_trait + unique_trait;
  if (grand_mean.n_elem == 1) {
    out += grand_mean(0);
  } else if (grand_mean.n_elem == out.n_rows) {
    out.each_col() += grand_mean;
  } else {
    Rcpp::stop(
        "'grand_mean' must be scalar or vector of length equal to number of "
        "rows in output.");
  }
  return out;
}
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
// -----------------------------------------------------------------------------
// edit .setup/cpp/manCULTA-trait.cpp
// Ivan Jacob Agaloos Pesigan
// -----------------------------------------------------------------------------

#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export(.Trait)]]
arma::mat Trait(const arma::mat& common_trait, const arma::mat& unique_trait,
                const arma::mat& common_trait_loading) {
  arma::mat out = common_trait_loading * common_trait + unique_trait;
  return out;
}
