# cross_validation.R
perform_cross_validation <- function(beta, fixed, probabilities_func, inputs, n_rep=10, validation_size=0.5){
  settings = list(nRep=n_rep, validationSize=validation_size)
  results <- apollo_outOfSample(beta, fixed, probabilities_func, inputs, settings)
  return(results)
}
