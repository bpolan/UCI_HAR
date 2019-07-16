#UCI HAR data stuff
#Benjamin Polan
#07/16/2019

library(dplyr)

#1 load in and merge data

#load in data
X.train <- read.table("./train/X_train.txt")
X.test <- read.table("./test/X_test.txt")
y.train <- read.table("./train/y_train.txt")
y.test <- read.table("./test/y_test.txt")
subject.train <- read.table("./train/subject_train.txt")
subject.test <- read.table("./test/subject_test.txt")
activity.labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

#merging data
x <- rbind(X.train, X.test)
y <- rbind(y.train, y.test)
subject <- rbind(subject.train, subject.test)
xy <- cbind(y,x)

#making full data set
full.data <- cbind(subject, xy)

#setting the full datas column names using the features data
colnames(full.data) <- c("SubjectID", "ActivityName", as.character(features$V2))

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
#using regular expression to find features with mean and std
sd.mean.cols <- features$V2[grep("-mean\\(\\)|-std\\(\\)", features[, 2])]

#this will be used to pull the correct columns from the full data
subsetColumns <- c("SubjectID", "ActivityName", as.character(sd.mean.cols))

#selecting only columns with mean/std
subsetted <- subset(full.data, select = subsetColumns)

# 3.Uses descriptive activity names to name the activities in the data set
#converting to char
activity.labels$V2 <- as.character(activity.labels$V2)
#setting name based on label
subsetted$ActivityName = activity.labels[subsetted$ActivityName, 2]


# 4.Appropriately labels the data set with descriptive variable names.
names(subsetted) <- gsub("^t", "Time ", names(subsetted)) # Replacing t with Time
names(subsetted) <- gsub("^f", "Frequency ", names(subsetted)) # Replacing f with Frequency
names(subsetted) <- gsub("Body", "Body ", names(subsetted)) #inserting space after body
names(subsetted) <- gsub("Acc", "Accelerometer ", names(subsetted)) #replacing acc with accelerometer
names(subsetted) <- gsub("Gravity", "Gravity ", names(subsetted)) #space after gravity
names(subsetted) <- gsub("Gyro", "Gyroscope ", names(subsetted)) #gyroscope instead of gyro
names(subsetted) <- gsub("Mag", "Magnitude ", names(subsetted)) #spelling out magnitude
names(subsetted) <- gsub("Body", "Body ", names(subsetted)) #inserting space
names(subsetted) <- gsub("Jerk", "Jerk ", names(subsetted)) #inserting space
names(subsetted) <- gsub('mean\\(\\)', ' mean value ', names(subsetted)) #writing out full word
names(subsetted) <- gsub('std\\(\\)', ' standard deviation ', names(subsetted)) #full word
names(subsetted) <- gsub('-X', 'in X direction' , names(subsetted)) #making more explicit
names(subsetted) <- gsub('-Y', 'in Y direction' , names(subsetted)) #making more explicit 
names(subsetted) <- gsub('-Z', 'in Z direction', names(subsetted)) #making more explicit


# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#   for each activity and each subject.

# Organizing table
data.group <- group_by(subsetted, SubjectID, ActivityName)

#computing each subjects Mean for each activity
tidy <- data.group %>% 
  summarise_each(funs(mean))

# Output tidy data set
write.table(tidy, "tidy_UCI_HAR.txt", row.names = FALSE)





















