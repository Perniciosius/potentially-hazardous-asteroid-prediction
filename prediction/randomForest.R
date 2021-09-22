library(randomForest)
library(e1071)
source("utils/helpers.R")


# Load dataset
data <- read.csv(file = "dataset/dataset.csv", nrows = 10000)

data <- dataCleaning(data)

data <- featureSelection(data)


# Split dataset
sample = sample.split(data$pha, SplitRatio = 0.75)
train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)


# Create model
model <- randomForest(pha ~ ., data = train)
model

# Predict test set
pred = predict(model, test)
confusionMatrix(table(test$pha, pred))
