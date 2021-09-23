# Analysis

data <- read.csv("dataset/dataset.csv", nrows = 5000)

# Dimesion of dataset
dim(data)

# Structure of dataset
str(data)

# Removing prefix column as it has only NA values
data$prefix = NULL

data <- transform(
  data,
  neo = as.factor(neo),
  pha = as.factor(pha),
  orbit_id = as.factor(orbit_id),
  equinox = as.factor(equinox),
  class = as.factor(class)
)

# NA rows
data[which(is.na(data)), 1:10]

# Removing rows with NAs
data <- na.omit(data)


# Summary of data
summary(data)

# Correlation Matrix
correlationMatrix <- cor(Filter(is.numeric, data))
correlationMatrix


# Plot asteroids diameter distribution
ggplot(data, aes(x = diameter)) + geom_histogram()

# Plot near earth objects distribution
ggplot(data, aes(x = neo, fill = neo)) + geom_bar()

# Plot potentially hazardous asteroids distribution
ggplot(data, aes(x = pha, fill = pha)) + geom_bar()
