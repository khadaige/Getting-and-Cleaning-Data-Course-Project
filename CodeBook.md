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

Description of the variables in the tiny_data.txt file
X_test, y_test, x_train, y_trainm,  subject_train and subject_test, features,  activity_labels contain the data from the downloaded files.

We will use Activity, Subject and Features as part of descriptive variable names for data in data frame.


Also,  
1.	prefix t is replaced by time
2.	Acc is replaced by Accelerometer
3.	Gyro is replaced by Gyroscope
4.	prefix f is replaced by frequency
5.	Mag is replaced by Magnitude
6.	BodyBody is replaced by Body

