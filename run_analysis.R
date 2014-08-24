####Merges the training and the test sets to create one data set
###Test Data

##Read feature names
features <- read.table(paste(getwd(),"features.txt",sep="/"))

##Read activity labels
activities <- read.table(paste(getwd(),"activity_labels.txt",sep="/"))
names(activities) <- c("activity_id","activity_label")

##Read test data
subject_test_data <- read.table(paste(getwd(),"/test/subject_test.txt",sep="/"))

X_test_data <- read.table(paste(getwd(),"/test/X_test.txt",sep="/"))

y_test_data <- read.table(paste(getwd(),"/test/y_test.txt",sep="/"))

##Column bind the 3 data frames
td <- cbind(subject_test_data,X_test_data)
testdata <- cbind(td,y_test_data)


##Train Data

##Read train data
subject_train_data <- read.table(paste(getwd(),"/train/subject_train.txt",sep="/"))
X_train_data <- read.table(paste(getwd(),"/train/X_train.txt",sep="/"))
y_train_data <- read.table(paste(getwd(),"/train/y_train.txt",sep="/"))

##Column bind the 3 data frames
trd <- cbind(subject_train_data,X_train_data)
traindata <- cbind(trd,y_train_data)

##Row bind the 2 data frames to get a single dataset
dataset <- rbind(testdata,traindata)

#Add names to the columns
names(dataset) <- c("subject",as.vector(features$V2),"activity")


####Extracts only the measurements on the mean and standard deviation for each measurement
dataset1 <- dataset[,grep("subject|mean|Mean|std|activity",colnames(dataset))]


####Uses descriptive activity names to name the activities in the data set
dataset2 <- dataset1


for(i in 1:length(dataset2$activity)){
    dataset2$activity[i] <- as.character(activities$activity_label[dataset1$activity[i]])
}



####Creates a second, independent tidy data set with the average of each variable for each activity and each subject
dataset3 <- dataset2

##Sort

secondDS <- aggregate(dataset3[,c(2:87)],list(dataset3$subject,dataset3$activity),mean)
tidydataset <- secondDS
names(tidydataset)[c(1:2)] <- c("subject","activity")