library(plyr)
library(dplyr)

# unzip the downloaded data
unzip(zipfile = "getdata_projectfiles_UCI HAR Dataset.zip")

# read features into R
# the data frame gives an overview about all features
# which are the variables for which data was measured
features <- read.table("UCI HAR Dataset/features.txt")

# data was randomly splitted up in training and test data sets (70/30)

# read training data set into R
train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
names(train.data) <- features[,2]

# read the train labels into R
# the data links the class labels with their activity name
# where the activities are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
train.labels <- read.table("UCI HAR Dataset/train/y_train.txt")
names(train.labels) <- "act.label"

# a group of 30 volunteers performed the activities
# train.subject shows which subject in the training set performed the activity
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train.subject) <- "subject"

# read test data set into R
test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
names(test.data) <- features[,2]

# read activity labels into R
test.labels <- read.table("UCI HAR Dataset/test/y_test.txt")
names(test.labels) <- "act.label"

# read subject list of the test data set into R
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test.subject) <- "subject"

# only the measurements on the mean and standard deviation for each measurement
# will be considered
# in the next steps all other features are removed from the data sets
cols <- grep("mean|std", features[,2])

# data frame features is no more needed
rm(features)

# filter training and test data sets by selected columns
filter.train <- train.data[,cols]
filter.test <- test.data[,cols]

# vector cols is no more needed
rm(cols)

# further filter data to remove columns for meanFreq which is not the mean value
# but a weighted average of the frequency components to obtain a mean frequency
# now there are remaining only columns for mean and standard deviation
filter.cols <- grep("meanFreq", names(filter.train))
filter.train <- filter.train[,-c(filter.cols)]

filter.cols <- grep("meanFreq", names(filter.test))
filter.test <- filter.test[,-c(filter.cols)]

# vector features is no more needed
rm(filter.cols)

# merging subject with activity and train data to create one data set for the training data
train <- cbind(train.subject, train.labels, filter.train)

# merging subject with activity and test data to create one date set for the test data
test <- cbind(test.subject, test.labels, filter.test)

# data frames filter.test, filte.train, test.data, test.labels, test.subject
# train.data, train.labels and train.subject are no more needed
rm(filter.test, filter.train, test.data, test.labels, test.subject,
   train.data, train.labels, train.subject)

# merge train and test data to create one data set
merged.data <- rbind(train, test)

# data frames train and test are no more needed since train and test data now is
# completely merged
rm(train, test)

# grouping by subject and act.label leads to a tidy data set
# the data set is tidy since
# 1) each variable that was measured is in one column
# 2) each different observation of that variable is in a different row
grp <- merged.data %>% group_by(subject, act.label) %>% summarise_all(.funs = mean)
rm(merged.data)