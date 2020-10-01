**"Getting and Cleaning Data"** Course Project Code Book
==========================================

## You should create one R script called run_analysis.R that does the following.


- Data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20UCI HAR Dataset.zip
 - Download in local.
- Set to variables. (features, activities, subject_test, x_test, y_test, subject_train, x_train, y_train)
- The `ResultData.txt` contains the correct variable name, which corresponds to each column of `x_train.txt` and `x_test.txt`. 
- The `README.txt` is the overall desciption about the overall process of how publishers of this dataset did the experiment and got the data result.
- The script `run_analysis.R` uses the `data.table` package for renaming column and reading in files. It performs 5 major steps including:


##1. Merges the training and the test sets to create one data set.
Use rbind function and set to variables data of train and test.
X, Y


##2. Extracts only the measurements on the mean and standard deviation for each measurement.
selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

##3. Uses descriptive activity names to name the activities in the data set.
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable


##4. Appropriately labels the data set with descriptive variable names.
Renames:
Acc - Accelerometer
Gyro - Gyroscope
BodyBody - Body
Mag - Magnitude
^t - Time
^f - Frequency
tBody - TimeBody
-mean() - Mean
-std() - STD
-freq() - Frequency
angle - Angle
gravity - Gravity


##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Passed information to ResultData variable.
