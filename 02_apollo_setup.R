# scripts/02_apollo_setup.R
initialize_apollo <- function(model_name, model_description, indiv_id, mixing = TRUE, panel_data = TRUE, n_cores = parallel::detectCores()) {
  library(apollo)
  apollo_initialise()
  apollo_control <- list(
    modelName = model_name,
    modelDescr = model_description,
    indivID = indiv_id,
    mixing = mixing,
    panelData = panel_data,
    nCores = n_cores
  )
  return(apollo_control)
}

validate_apollo_inputs <- function(){
  apollo_inputs <- apollo_validateInputs()
  return(apollo_inputs)
}
