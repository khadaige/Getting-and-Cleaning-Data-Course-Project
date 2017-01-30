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

#unzipped files are in the folderUCI HAR Dataset. Get the list of the files

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
#files

#Reading files
# Reading activity labels:
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#str(subject_train)
#str(subject_test)
# Reading trainings tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

# Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")


# Reading feature :
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

# Merging the data tables by rows

dataSubject <- rbind(subject_train, subject_test)
dataActivity<- rbind(y_train, y_test)
dataFeatures<- rbind(x_train, x_test)

#set names to variables
setnames(dataSubject, "V1", "subject")

setnames(dataActivity, "V1","activity")

# name variables Features
dataFeaturesNames <- tbl_df(read.table(file.path(filesPath, "features.txt")))
setnames(dataFeaturesNames, names(dataFeaturesNames), c("featureNum", "featureName"))
colnames(dataFeatures) <- dataFeaturesNames$featureName

#Merge columns to get the data frame Data for all data
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
#str(Data)

#Subset Name of Features by measurements on the mean and standard deviation
#i.e taken Names of Features with “mean()” or “std()”

mean_and_std <- (grepl("activity" , dataFeaturesNames$featureName) | 
                         grepl("subject" , dataFeaturesNames$featureName) | 
                         grepl("mean.." , dataFeaturesNames$featureName) | 
                         grepl("std.." , dataFeaturesNames$featureName) 
)

#Check the structures of the data frame Data

allData <- merge(activityLabels, Data)
str(allData)

#Appropriately labels the data set with descriptive variable names
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

str(allData)

#write to text file on disk
write.table(allData, "TidyData.txt", row.name=FALSE)

