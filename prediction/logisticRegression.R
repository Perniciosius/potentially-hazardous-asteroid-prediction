pacman::p_load(caret)
pacman::p_load(e1071)
pacman::p_load(caTools)
pacman::p_load(dplyr)

source("utils/helpers.R")

#load the dataset
data <- read.csv(file = "dataset/dataset.csv")

#dataset cleaning
data <- dataCleaning(data)

#selecting relevent features from the dataset
data <- featureSelection(data)
data$pha <- ifelse(data$pha=='N',0,1)
#data$pha <- factor(data$pha)

# Split dataset
sample = sample.split(data$pha, SplitRatio = 0.75)
train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)

#create model
model <- glm(formula=pha ~ ., data = train)
model

# Predict test set
pred <- predict(model, test, type="response")
pred <- ifelse(pred >0.5, 1, 0)
confusionMatrix(table(test$pha, pred))