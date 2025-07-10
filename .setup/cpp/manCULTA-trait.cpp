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
