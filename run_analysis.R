###Loading required packages
library(dplyr)

filename <- "Coursera_DS3_Final.zip"

### Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20UCI HAR Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

### Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

### Assigning all data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Step 1: Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
tdData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#Step 3: Uses descriptive activity names to name the activities in the data set.
tdData$code <- activities[tdData$code, 2]

#Step 4: Appropriately labels the data set with descriptive variable names.
names(tdData)[2] = "activity"
names(tdData)<-gsub("Acc", "Accelerometer", names(tdData))
names(tdData)<-gsub("Gyro", "Gyroscope", names(tdData))
names(tdData)<-gsub("BodyBody", "Body", names(tdData))
names(tdData)<-gsub("Mag", "Magnitude", names(tdData))
names(tdData)<-gsub("^t", "Time", names(tdData))
names(tdData)<-gsub("^f", "Frequency", names(tdData))
names(tdData)<-gsub("tBody", "TimeBody", names(tdData))
names(tdData)<-gsub("-mean()", "Mean", names(tdData), ignore.case = TRUE)
names(tdData)<-gsub("-std()", "STD", names(tdData), ignore.case = TRUE)
names(tdData)<-gsub("-freq()", "Frequency", names(tdData), ignore.case = TRUE)
names(tdData)<-gsub("angle", "Angle", names(tdData))
names(tdData)<-gsub("gravity", "Gravity", names(tdData))

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ResultData <- tdData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(ResultData, file = "ResultData.txt", row.name=FALSE)
