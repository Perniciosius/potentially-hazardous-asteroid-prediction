featureSelection <- function(data) {
  # Highly correlated features
  correlationMatrix <- cor(data[, names(data) != "pha"])
  
  # Index of highly correlation features
  hightlyCorrelated <- findCorrelation(correlationMatrix,
                                       cutoff = 0.95, names = TRUE)
  
  # Remove highly correlated features
  data <- data[, !names(data) %in% hightlyCorrelated]
  return(data)
}


dataCleaning <- function(data) {
  # Remove unnecessary field
  data <- data[, !names(data)
               %in% c("prefix", "id", "spkid", "full_name", "pdes",
                      "name", "orbit_id", "equinox", "neo", "class")]
  
  # Remove NA data
  data <- na.omit(data)
  
  # Categorical data
  data <- transform(
    data,
    pha = as.factor(pha)
  )
  
  return(data)
}