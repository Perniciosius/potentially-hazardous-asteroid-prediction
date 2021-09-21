library(randomForest)

# Load dataset
data <- read.csv(file = "dataset/dataset.csv", nrows = 10000)

# Remove unnecessary field
data$prefix = NULL
data$id = NULL
data$spkid = NULL
data$full_name = NULL
data$pdes = NULL
data$name = NULL
data$orbit_id = NULL
data$equinox = NULL

# Remove NA data
data <- na.omit(data)

# Structure
str(data)

# Categorical data
data <- transform(
  data,
  neo = as.factor(neo),
  pha = as.factor(pha),
  class = as.factor(class)
)


# Split dataset
sample = sample.split(data$pha, SplitRatio = 0.75)
train = subset(data, sample == TRUE)
test = subset(data, sample == FALSE)

dim(train)
dim(test)

# Create model
model <- randomForest(pha ~ ., data = train)

model

# predict test set
pred = predict(model, test)

table(test$pha, pred)
