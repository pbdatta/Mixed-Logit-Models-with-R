# define_parameters.R
define_parameters <- function(beta_list, fixed_params = NULL){
  return(list(beta = beta_list, fixed = fixed_params))
}
