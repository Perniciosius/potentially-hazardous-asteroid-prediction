pacman::p_load(naivebayes)
pacman::p_load(e1071)
pacman::p_load(caret)
pacman::p_load(caTools)
source("utils/helpers.R")

# Load dataset
data <- read.csv(file = "dataset/dataset.csv")

df <- dataCleaning(data)

df <- featureSelection(df)

# Split dataset
sample = sample.split(df$pha, SplitRatio = 0.75)
train = subset(df, sample == TRUE)
test = subset(df, sample == FALSE)

# Create model
model <- naive_bayes(pha ~ ., data = train)
model

# Predict test set
pred <- predict(model, test)
confusionMatrix(table(test$pha, pred))