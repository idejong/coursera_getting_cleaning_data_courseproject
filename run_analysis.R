
library(data.table)
library(dplyr)
library(rstudioapi) 

# 0. Set working directory to the location holding this script run_analysis.R:
setwd(dirname(getActiveDocumentContext()$path))

# 0. Set working directory:
setwd("../Documents/Coursera Data Science Track/3. Getting and Cleaning Data/Course Project")


# 1. Download the zipped dataset only if it does not exist yet in the current working directory, and save in the working directory:
if(!file.exists("UCI_HAR_Data.zip")){download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile='UCI_HAR_Data.zip')}


# 2. Unzip in the same folder if not already unzipped:
if(!dir.exists("UCI HAR Dataset")){unzip('UCI_HAR_Data.zip')}


#  3. Merge the training and the test sets to create one data set (Question 1) &
#     Appropriately label the data set with descriptive variable names (Question 4):

# Load the variable data (x_train and x_test):
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")   
# Bind the rows of xtest and xtrain together:
x_total <- rbind(x_train, x_test)

# Load the features.text which contains the variable names:
colnames_raw <- read.table("UCI HAR Dataset/features.txt")
# Rename the columns from V1, V2.. to descriptive variable names:
colnames(x_total) <- colnames_raw$V2

# Load the activity names (the y-label), specify col.names to name the column using a descriptive variable name:
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = 'activity') 
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = 'activity')  
# Bind the rows of ytest and ytrain together:
y_total <- rbind(y_train, y_test)

# Load the subject data, specify col.names to name the column using a descriptive variable name:
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = 'subject')
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = 'subject')
# Bind the rows of subject_train and subject_test together:
subject_total <- rbind(subject_train, subject_test)

# Bind the columns of xtotal, ytotal and subjecttotal to create one data set. 
# Start with subject_total, following by y_total, so that the first two columns are respectiveley the subject and activty,
# following by the variable measurements.
db1 <- cbind(subject_total, y_total, x_total)


# 4. Extract only the measurements on the mean and standard deviation for each measurement (Question 2):
# Determine the index numbers of colnames containing 'mean()' or 'std':
indices <- grep('(mean(\\(\\))|std)', colnames(db1))

# Subset the database db1: Add the first two columns 'subject' and 'activity', and add the columns
# as specified in the indices vector created in the previous step:
db1 <- db1[,c(1,2, indices)]


# 5. Uses descriptive activity names to name the activities in the data set (Question 3):
# Rename the values in the activity column from integers 1-6 to descriptive activity names:
db1$activity[db1$activity==1] <- "walking"
db1$activity[db1$activity==2] <- "walking_upstairs"
db1$activity[db1$activity==3] <- "walking_downstairs"
db1$activity[db1$activity==4] <- "sitting"
db1$activity[db1$activity==5] <- "standing"
db1$activity[db1$activity==6] <- "laying"


# 6. creates a second, independent tidy data set with the average of each variable for each activity and each subject (Question 5):
#    This is done by grouping by subject and activity.
db2 <- db1 %>%
group_by(subject, activity) %>%
summarize_all(mean)


# 7. Write the tidy dataset to a textfile:
write.table(db2, 'tidy dataset.txt', row.name=FALSE)

