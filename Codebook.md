This codebook explains the input dataset (1), it lists the variables and measurements present in the output dataset tidy_dataset.txt (2), and it provides the cleaning and transformation steps undertaken to transform the original dataset to the tidy_dataset.txt (3).

(1) Input dataset:
The input dataset is retrieved using the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

(2) Output dataset: tidy dataset.txt
Variables: 
Subject: Unique ID for the person performing the activity.
Activity: Label indicating which activity was performed by the subject during the measurements.
Activity labels:Walking, Walking_upstairs, Walking_downstairs, sitting, standing, laying.

Measurements:
The average mean value and standard deviation for each activity and each subject are given for the following 17 measurements: 
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

(3) The data cleaning steps and transformations performed on the original dataset  are performed in the script run_analysis.R. The script run_analysis.R takes an input database from a weburl and returns a tidy dataset with the average of each variable for each activity and each subject.


Steps in the script:
- Download the input data using the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip if the input data is not yet stored in the user's current working directory.
- Unzip the input data if the input data is not yet available in its unzipped format in the user's current working directory.
- Load the variable data (x_train and x_test), the activity names (y_train and y_test), and the subject data (subject_train and subject_test). Rename the column names to represent descriptive variable names.
  Then, use rbind to merge the rows of x_train and x_test, y_train and y_test, and subject_train and subject_test. Subsequently, use colbind to merge columns of x, y, and subject.
- Extract only the measurements on the mean and standard deviation for each measurement, by using grep to identify columnname's and their associated indcies that contains 'mean()' or 'std',
  and subsequently subsetting the data set based on the column indices.
- Rename the values in the activity column from integers 1-6 to their descriptive activity names.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This is done by grouping by subject and activity.
- Write the tidy dataset to a textfile.