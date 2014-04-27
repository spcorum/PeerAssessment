# Set working directory
setwd("~/Education/MOOCs/Data Science Specialization/Getting and Cleaning Data/peer_assessment")

# Download and unzip dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(url, 'Dataset.zip', method = 'curl')
unzip('Dataset.zip')
dateDownloaded <- date()

# Read data into dataframes
subjectTest <- read.table('UCI HAR Dataset/test/subject_test.txt')
XTest <- read.table('UCI HAR Dataset/test/X_test.txt')
yTest <- read.table('UCI HAR Dataset/test/y_test.txt')
subjectTrain <- read.table('UCI HAR Dataset/train/subject_train.txt')
XTrain <- read.table('UCI HAR Dataset/train/X_train.txt')
yTrain <- read.table('UCI HAR Dataset/train/y_train.txt')
features <- read.table('UCI HAR Dataset/features.txt')
activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')

# To begin building a tidy training dataset, join activityLabels and yTest,
# which will construct a dataframe that associates the descriptions of the 
# activities with the activity codes of each observation.
yTest <- join(x = yTest, y = activityLabels, by = "V1", type = "inner")

# To get things in a nicer order order, rearrange the column order
# of yTest.
yTest <- yTest[c(2,1)]

# Column bind subjectTest and yTest, and then column bind the result to Xtest
# the result will be a dataset with the subject, activity, and activity code
# in the first three columns followed by the 561 variables of Xtest
yTest <- cbind(subjectTest, yTest)
test <- cbind(yTest, XTest)

# Repeat the previous steps for the training data
yTrain <- join(x = yTrain, y = activityLabels, by = "V1", type = "inner")
yTrain <- yTrain[c(2,1)]
yTrain <- cbind(subjectTrain, yTrain)
train <- cbind(yTrain, XTrain)

# Row bind the train and test datasets to make a combined dataset

combined <- rbind(train, test)

# Rename the variable names of the combined dataframe to be more descriptive
colnames(combined) <- c('SubjectID', 'Activity', 'ActivityCode', 
                        as.character(features$V2))

# Change the SubjectID, Activity, and Activity Code to factors. This will help in
# later data reduction
combined[,1] <- as.factor(combined[,1])
combined[,2] <- as.factor(combined[,2])

# Of all the variables in the combined dataset, retain only variables that are means
# and standard deviations (and the first three columns describing the SubjectID's,
# Activity's, and ActivityID's), and discard the rest. From examination of the 
# column names, these can be extracted by matching the column names to '-mean'
# or '-std'.
reduced <- combined[,c(1:3, grep('-mean|-std', colnames(combined)))]

# Create a tidy set that aggregates the mean and std variables to be the mean
# for each subject performing each activity
tidy <- aggregate(x = reduced, by = list(SubjectID = reduced$SubjectID, 
                  Activity = reduced$Activity, ActivityCode = reduced$ActivityCode
                  ), FUN = mean)

# Clean and order the aggregation output
tidy <- tidy[, -c(4:6)]
tidy <- tidy[order(tidy$SubjectID,tidy$ActivityCode),]

# Write the dataset to file
write.csv(tidy, file = 'tidydata.csv')
write.table(tidy, file = 'tidydata.txt', sep = '\t')



