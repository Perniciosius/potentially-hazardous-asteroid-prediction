pacman::p_load(caret)
pacman::p_load(e1071)
pacman::p_load(caTools)
pacman::p_load(dplyr)

source("utils/helpers.R")

#load the dataset
data <- read.csv(file = "dataset/dataset.csv")

#dataset cleaning
df <- dataCleaning(data)

#selecting relevent features from the dataset
df <- featureSelection(df)
df$pha <- ifelse(df$pha=='N',0,1)
df$pha <- factor(df$pha)

# Split dataset
sample = sample.split(df$pha, SplitRatio = 0.75)
train = subset(df, sample == TRUE)
test = subset(df, sample == FALSE)

#create model
model <- glm(formula=pha ~ ., data = train, family = "binomial")
model

# Predict test set
pred <- predict(model, test, type="response")
pred <- ifelse(pred >0.5, 1, 0)
confusionMatrix(table(test$pha, pred))