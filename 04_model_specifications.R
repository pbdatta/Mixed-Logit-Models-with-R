# Example: Model 01 specification
model_01 <- function(database, apollo_inputs){

  apollo_beta = c(asc_bus = 0, asc_air = 0, asc_rail = 0, b_tt = 0, b_cost = 0)
  apollo_fixed = NULL

  apollo_probabilities <- function(apollo_beta, apollo_inputs, functionality="estimate"){
    apollo_attach(apollo_beta, apollo_inputs)
    on.exit(apollo_detach(apollo_beta, apollo_inputs))

    V <- list(
      car  = b_tt*time_car + b_cost*cost_car,
      bus  = asc_bus + b_tt*time_bus + b_cost*cost_bus,
      air  = asc_air + b_tt*time_air + b_cost*cost_air,
      rail = asc_rail + b_tt*time_rail + b_cost*cost_rail
    )

    mnl_settings <- list(
      alternatives = c(car=1, bus=2, air=3, rail=4),
      avail = list(car=av_car, bus=av_bus, air=av_air, rail=av_rail),
      choiceVar = choice,
      V = V
    )

    P <- list()
    P[['model']] <- apollo_mnl(mnl_settings, functionality)
    P <- apollo_panelProd(P, apollo_inputs, functionality)
    P <- apollo_prepareProb(P, apollo_inputs, functionality)
    return(P)
  }

  model <- apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)
  apollo_modelOutput(model)

  return(model)
}
