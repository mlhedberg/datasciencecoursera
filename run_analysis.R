#Download raw data
if (!file.exists(“getdata-projectfiles-UCI HAR Dataset”)) {
    dir.create(“getdata-projectfiles-UCI HAR Dataset”)
}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "UCI HAR Dataset.zip")
dateDownloaded <- date()
unzip("UCI HAR Dataset.zip")

#Read training data
dirtrain <- paste(getwd(), "UCI HAR Dataset/train", sep = "/")
files <- list.files(dirtrain)
paths <- paste(dirtrain, files[2:4], sep = "/")
subjectsTrain <- data.table(read.table(paths[1]))
activityTrain <- data.table(read.table(paths[3]))
dataTrain <- data.table(read.table(paths[2]))

#Rename columns in training dataset
setnames(subjectsTrain, "V1", "Subject ID")
setnames(activityTrain, "V1", "Activity")
file <- paste(getwd(), "UCI HAR Dataset/features.txt", sep = "/")
features <- read.table(file)
newNames <- as.character(features[ ,2])
oldNames <- names(dataTrain)
setnames(dataTrain, oldNames, newNames)

#Merge list into 1 data frame for training dataset
trainRawData <- c(subjectsTrain, activityTrain, dataTrain)
trainRawDT <- data.table(do.call(cbind, trainRawData))

#Read test data
dirtest <- paste(getwd(), "UCI HAR Dataset/test", sep = "/")
files <- list.files(dirtest)
paths2 <- paste(dirtest, files[2:4], sep = "/")
subjectsTest <- data.table(read.table(paths2[1]))
activityTest <- data.table(read.table(paths2[3]))
dataTest <- data.table(read.table(paths2[2]))

#Rename columns in training dataset
setnames(subjectsTest, "V1", "Subject ID")
setnames(activityTest, "V1", "Activity")
oldNames <- names(dataTest)
setnames(dataTest, oldNames, newNames)

#Merge list into 1 data frame for training dataset
testRawData <- c(subjectsTrain, activityTrain, dataTrain)
testRawDT <- data.table(do.call(cbind, trainRawData))

#Select columns from each dataset for mean() and sd()
trainDT <- select(trainRawDT, c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545))
testDT <- select(testRawDT, c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545))

#Merge training and test datasets
mergedDT <- rbindlist(list(trainDT, testDT), use.names = TRUE)