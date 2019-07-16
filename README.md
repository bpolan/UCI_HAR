Author: Benjamin Polan
Date: 07-16-2019

# UCI_HAR
Contains UCI_HAR assignment stuff.

## Purpose
The purpose of UCI_HAR_data_stuff.R is to take data from https://www.dropbox.com/s/lfsbhwy8elgjo15/UCI_HAR_Dataset.zip?dl=0 and clean it and transform it. Will produce a tidy data set called tidy_UCI_HAR.txt.

## Data info
The UCI_HAR data contains accelerometer data from 30 different subjects.

A detailed description of the data set and its features can be found in the  UCI_HAR_README.txt and features_info.txt files.

## Description
UCI_HAR_data_stuff.R does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How to use
- Download the data from the link above.
- Download the UCI_HAR_assignment_stuff.R file and save it in the same folder as the test and train folders (should also include features.txt and activity_labels.txt).
- Run the script (Make sure dplyr is installed)
- tidy_UCI_HAR.txt should be created in the working directory.


