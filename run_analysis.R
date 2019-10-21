#Load packages
library(qdap)
library(dplyr)

#download zip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Data.zip", method = "curl")

#unzip
unzip("Data.zip")


##### 

### 1. Merges the training and the test sets to create one data set.

#test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt"); names(subject_test) <- "subject"
x_test <- read.table("UCI HAR Dataset/test/X_test.txt"); names(x_test) <- read.table("UCI HAR Dataset/features.txt")[,2]
y_test <- read.table("UCI HAR Dataset/test/y_test.txt"); names(y_test) <- "labels"

#train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt"); names(subject_train) <- "subject"
x_train <- read.table("UCI HAR Dataset/train/X_train.txt"); names(x_train) <- read.table("UCI HAR Dataset/features.txt")[,2]
y_train <- read.table("UCI HAR Dataset/train/y_train.txt"); names(y_train) <- "labels"

#merging
merged <- cbind(rbind(subject_train, subject_test), rbind(y_train, y_test), rbind(x_train, x_test))



#####

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

data <- merged %>% subset(select=which(!duplicated(names(.)))) #remove duplicate columns

data <- data %>% select(subject, labels, contains("mean"), contains("std"))



#####

### 3. Uses descriptive activity names to name the activities in the data set

activity <- read.table("UCI HAR Dataset/activity_labels.txt"); names(activity) = c("label", "activity")

data$labels <- activity[data$labels, 2] #renaming labels


#####

### 4. Appropriately labels the data set with descriptive variable names.

all_names <- names(data)

all_names <- mgsub(c("subject","labels", "Acc", "Gyro", "tBody", "BodyBody", "Mag", "^t", "^f", "-freq()", "-mean()", "-std()", "-meanFreq()","gravity", "angle"), 
      c("Subject", "Activity", "Accelerometer", "Gyroscope", "TimeBody", "Body", "Magnitude", "Time", "Frequency", "Frequency", "Mean", "StandardDeviation","MeanFrequency", "Gravity", "Angle"), all_names)

names(data) <- all_names

#####

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


final <- data %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean)) %>%
  write.table("final.txt")

