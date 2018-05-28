# Cameron Seibel, INFO 201
# NNET Proof of Concept
#
# This file serves as a proof of concept for using the nnet package to solve classification 
# problems by exploring one of R's given datasets, iris.

# Be sure that nnet is already installed on your machine!
library(nnet)
library(dplyr)

# This sets the size of the hidden layer of the neural net; ultimately determines the
# accuracy of classifications, but there is danger of "overfitting" training data.
HIDDEN_LAYER_SIZE = 10

iris_df <- iris
# Train on a sample of the iris data
iris_subset <- sample_n(iris_df, 50)
# Test on data not in the training set
iris_test <- iris_df %>% 
  anti_join(iris_subset)


# Instantiation of the neural net; where Species is a function of the other features,
# the network should be trained on the subset of training data, and the number of perceptrons
# in the hidden layer is set to some value, where larger values will merit greater accuracy,
# but slower performance.
iris_classifier <- nnet(Species ~ ., data = iris_subset, size = HIDDEN_LAYER_SIZE)

# Output the predictions for the test set to this table.
predictions <- data.frame(iris_test$Species, predict(iris_classifier, iris_test, type = "class"))
colnames(predictions) <- c("Species", "Prediction")
n_wrong <- predictions %>% 
  filter(Species != Prediction) %>% 
  count()
print(paste("The network was able to classify the data with", n_wrong, "percent innaccuracy."))




