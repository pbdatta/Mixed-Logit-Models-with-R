# bootstrap.R
run_bootstrap <- function(beta, fixed, probabilities_func, inputs){
  results <- apollo_bootstrap(beta, fixed, probabilities_func, inputs)
  return(results)
}
