pacman::p_load(randomForest)
pacman::p_load(e1071)
pacman::p_load(caret)
pacman::p_load(caTools)
source("utils/helpers.R")


# Load dataset
data <- read.csv(file = "dataset/dataset.csv")

data <- dataCleaning(data)

data <- featureSelection(data)


# Split dataset
data$pha=droplevels(data$pha)
sample = sample.split(data$pha, SplitRatio = 0.75)
train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)


# Create model
model <- randomForest(pha ~ ., data = train)
model

# Predict test set
pred = predict(model, test)
confusionMatrix(table(test$pha, pred))
