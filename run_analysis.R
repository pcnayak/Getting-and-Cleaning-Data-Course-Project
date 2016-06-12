## Check if the file exists. Download it from the specified URL if it is not available

UCI_HAR_DS="UCI_HAR_DS.zip" 
fileURL <-  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(UCI_HAR_DS)) {
  download.file(fileURL ,UCI_HAR_DS )  
}

## Unzip the file
unzip(UCI_HAR_DS)

library(plyr)
library(dplyr)
setwd("./UCI HAR Dataset")

## Read the training datasets
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")


## Read the test datasets
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

## Read the features and labels text files with column names
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")


## Assign the column names to X and Y
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]

## Merge the X, y and subject dataset
X_data <- rbind(X_train, X_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

## Extracts only the standard deviation and mean columns in the X_data
mean_stddev  <- grep("(mean\\(\\)|std\\(\\))" ,features[,2],  value=TRUE)
X_data <- X_data[,mean_stddev]
 
## update the activities labels in the y_data
y_data[,1] <- activity_labels[ y_data[,1],2]

## assign name of the subject_data column V1 and y_data column V1
names(y_data) <- "activity"
names(subject_data) <- "subject"

## Merge all the data sets
merged_data <- cbind(X_data, y_data , subject_data)

## Merge all the data sets

averages_data <- ddply(  merged_data, 
                         .(subject, activity), 
                         function(x){
                            colMeans(x[, 1:66])
                         }
                    )


write.table(averages_data, "averages_data.txt", row.name=FALSE)


