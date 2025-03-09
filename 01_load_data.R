# scripts/01_load_data.R
load_data <- function(filepath, sep = ";") {
  if (!file.exists(filepath)) {
    stop("Data file not found at path: ", filepath)
  }
  data <- read.csv(filepath, header = TRUE, sep = sep)
  return(data)
}
