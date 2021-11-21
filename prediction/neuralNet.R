pacman::p_load(caret)
pacman::p_load(e1071)
pacman::p_load(caTools)
pacman::p_load(neuralnet)
pacman::p_load(Metrics)

source("utils/helpers.R")

#load the dataset
data <- read.csv(file = "dataset/dataset.csv")

#dataset cleaning
df <- dataCleaning(data)

#selecting relevent features from the dataset
df <- featureSelection(df)
df$pha <- ifelse(df$pha=='N',0,1)
#data$pha <- factor(data$pha)

# Split dataset
sample = sample.split(df$pha, SplitRatio = 0.75)
train = subset(df, sample == TRUE)
test = subset(df, sample == FALSE)

#create model
model <- neuralnet::neuralnet(formula=pha ~ ., data = train, hidden=5)
model

# Predict test set
pred <- neuralnet::compute(model,subset(test,select=-c(pha)))
pred$net.result
pred$net.result <- ifelse(pred$net.result>0.5, 1, 0)
u <- union(pred$net.result, test$pha)
t <- table(factor(test$pha, u),factor(pred$net.result, u))
confusionMatrix(t)