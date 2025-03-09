# main.R
source("scripts/01_load_data.R")
source("scripts/02_apollo_setup.R")
source("scripts/03_define_parameters.R")
source("scripts/04_model_specifications.R")
source("scripts/05_evaluation_metrics.R")
source("scripts/06_cross_validation.R")
source("scripts/07_bootstrap.R")

# Load data
database <- load_data("data/ModeChoiceDataset.csv")

# Initialize Apollo
apollo_control <- initialize_apollo(
  model_name = "Apollo_Mode_Choice",
  model_description = "Apollo mode choice modeling",
  indiv_id = "ID"
)

apollo_inputs <- validate_apollo_inputs()

# Run Model 01 as an example
model_result <- model_01(database, apollo_inputs)

# Generate predictions
predictions <- apollo_prediction(model_result, apollo_probabilities, apollo_inputs, prediction_settings="model")

# Calculate evaluation metrics
actual_choices <- model.matrix(~ choice - 1, data=database)
rmse <- calculate_rmse(predictions[,3:6], actual_choices)
print(paste("RMSE:", rmse))

# Generate and print confusion matrix and accuracy
actual <- database$choice
predicted <- apply(predictions[,3:6], 1, which.max)
confusion <- generate_confusion_matrix(actual, predicted)
print(confusion$confusion_matrix)
print(paste("Accuracy:", confusion$accuracy))

# ROC plots
plot_roc_curves(actual_choices, predictions[,3:6],
                labels=c("Car", "Bus", "Air", "Rail"),
                colors=c("#377eb8", "#4daf4a", "#afac4a", "#7a4aaf"))

# Cross-validation example
cv_results <- perform_cross_validation(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)

# Bootstrap example
bootstrap_results <- run_bootstrap(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)

cat("Modeling completed successfully. Results stored and available.\n")
