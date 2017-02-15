library(reshape2)
library(plyr)
library(data.table)
library(dplyr)
library(tidyr)

#Download the file and put the file in the data folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#Unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#unzipped files are in the folderUCI HAR Dataset. 
#Get the list of the files
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
#files

# Reading trainings tables:
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")


# Reading testing tables:
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

# Reading feature :
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Assigning column names:
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityNum"
colnames(subject_train) <- "subjectNum"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityNum"
colnames(subject_test) <- "subjectNum"

allsubject <- cbind(subject_test, subject_train)

colnames(activityLabels) <- c('activityNum','activityName')

# Merging the data tables by column
dataTrain <- cbind(y_train, subject_train, x_train)
dataTest<- cbind(y_test, subject_test, x_test)

# Merging the data tables test and training
data_train_test <- rbind(dataTrain, dataTest)

# creating vector to define the num, mean and std
mean_and_std <- (grepl("activityNum" , colNames) | 
                         grepl("subjectNum" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
)

#subsetting the data regarding the mean and the std
subData_train_test <- data_train_test[ , mean_and_std == TRUE]

#Merge  the data by activity name
dataCombineActivity <- merge(subData_train_test, activityLabels,
                              by='activityNum',
                              all.x=TRUE)
dataCombineActivity

#Appropriately labels the data set with descriptive variable names
names(dataCombineActivity)<-gsub("^t", "time", names(dataCombineActivity))
names(dataCombineActivity)<-gsub("^f", "frequency", names(dataCombineActivity))
names(dataCombineActivity)<-gsub("BodyBody", "Body", names(dataCombineActivity))
dataCombineActivity
#str(dataCombineActivity)

#Creating a tidy data set with the average of each variable for each activity and each subject:
tidySet <- aggregate(. ~allsubject$subjectNum + activityNum + activityName, dataCombineActivity, mean)
tidySet <- tidySet[order(tidySet$`allsubject$subjectNum`, tidySet$activityNum),]
#head(tidySet)

#write to text file on disk
write.table(dataCombineActivity, "TidyData.txt", row.name=FALSE)


