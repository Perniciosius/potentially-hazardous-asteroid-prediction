pacman::p_load(caret)
pacman::p_load(e1071)
pacman::p_load(caTools)
pacman::p_load(dplyr)

source("utils/helpers.R")

#load the dataset
data <- read.csv("dataset/dataset.csv",nrows = 400000)

#dataset cleaning
data <- dataCleaning(data)

#selecting relevent features from the dataset
data <- featureSelection(data)
data$pha
data$pha <- as.integer(data$pha)
data <- mutate(data, pha=pha-1)
data$pha
# Split dataset
sample = sample.split(data$pha, SplitRatio = 0.75)
train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)

#create model
model <- glm(formula=pha ~ ., data = train)
model
summary(model)

# Predict test set
pred <- predict(model, test)
pred <- ifelse(pred >0.5, 1, 0)
confusionMatrix(table(test$pha, pred))