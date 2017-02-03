Title: Code Book for Getting-and-Cleaning-Data-Course-Project
Author: Khadija Ba
Date: 01/29/2017

Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
We should submit a  tidy data set  and  The Github repo containing the required scripts. 
You should also create a R script called run_analysis.R that does the following.
Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set and  appropriately labels the data set with descriptive variable names. 
Notes on the original data

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description of the variables 
x_test, y_test,  subject_train,  subject_test, features,  activity_labels contain the data from the downloaded files.
Here is the activity number and type of activity we have in the data
 V1                 V2
 1            WALKING
 2   WALKING_UPSTAIRS
 3 WALKING_DOWNSTAIRS
 4             SITTING
 5            STANDING
 6             LAYING
dataTrain, dataTest, data_test_train for  Merging the data t tables test and training

mean_and_std  for defining  mean and standard deviation:


dataCombineActivity  for merging the data by activity name

1. prefix t is replaced by time 2. Acc is replaced by Accelerometer 3. prefix f is replaced by frequency 4. BodyBody replaced by Body
