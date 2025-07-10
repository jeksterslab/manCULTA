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
