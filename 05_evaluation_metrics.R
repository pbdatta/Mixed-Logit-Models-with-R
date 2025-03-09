# evaluation_metrics.R
calculate_rmse <- function(predictions, actual_choices){
  diff_sq <- (predictions - actual_choices)^2
  mean_diff <- rowMeans(diff_sq)
  rmse <- sqrt(mean(mean_diff))
  return(rmse)
}

generate_confusion_matrix <- function(actual, predicted){
  cm <- table(actual, predicted)
  accuracy <- sum(diag(cm)) / sum(cm)
  return(list(confusion_matrix=cm, accuracy=accuracy))
}

plot_roc_curves <- function(actual_matrix, prediction_matrix, labels, colors){
  library(pROC)
  par(pty="s")
  for(i in seq_along(labels)){
    roc(actual_matrix[,i], prediction_matrix[,i], plot=TRUE, legacy.axes=TRUE, percent=TRUE,
        col=colors[i], lwd=2, add=(i>1), print.auc=TRUE, print.auc.y=90-10*i)
  }
  legend("bottomright", legend=labels, col=colors, lwd=2, cex=0.5)
  par(pty="m")
}
