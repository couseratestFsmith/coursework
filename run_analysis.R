run_analysis.R<-function(){


# Two hashes (##) indicate these were the orginal istructions from coursera
##Merges the training and the test sets to create one data set.

#get the column names
columnnames<-read.table("UCI HAR Dataset/features.txt")
columnnames<-columnnames$V2
#get the row labels
ytrainrowlabels<-read.table("UCI HAR Dataset/train/y_train.txt")
ytestrowlabels<-read.table("UCI HAR Dataset/test/y_test.txt")
#get the data
xtraindata<-read.table("UCI HAR Dataset/train/X_train.txt")
xtestdata<-read.table("UCI HAR Dataset/test/x_test.txt")
#Combine two data sets (test and train)
data<-rbind(xtraindata, xtestdata)
#label the columns
colnames(data)<-columnnames
#Combine two rowlabels and add to data (rowlabels come before data in line with tidy data principles)
rowlabels<-rbind(ytrainrowlabels,ytestrowlabels)
allmerged<-cbind(rowlabels,data)
#rename the extra column
names(allmerged)[names(allmerged)=="V1"] <- "activitytype"

#need to get the subject numbers in the dataframe(for later)  - subjects numbers are 1st column in line with tidy data principles
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subjectnumbers<-rbind(subject_train, subject_test)
allmerged<-cbind(subjectnumbers,allmerged)
#rename the subject column
names(allmerged)[names(allmerged)=="V1"] <- "subjectnumber"
#cousera recomends ncolumn names in lower case
names(allmerged)<-tolower(names(allmerged))

##Extracts only the measurements on the mean and standard deviation for each measurement. 
#find the column numbers which contain "mean"
col_nums_means<-as.data.frame(grep("mean()", names(allmerged)))
col_nums_std<-as.data.frame(grep("std()", names(allmerged)))
#annoyingly needed to rename columns for rbind, suspect ineffecient
col_nums_means<-setNames(col_nums_means, "number")
col_nums_std<-setNames(col_nums_std, "number")
relevantcolumns<-rbind(col_nums_means, col_nums_std)
relevantcolumns<-as.data.frame(relevantcolumns[order(relevantcolumns$number),])
#need to add subj no and activitytype to relevant columns which contain mean or std
relevantcolumns<-rbind(1,2, relevantcolumns)

allmerged_meanstd<-allmerged[,relevantcolumns[,1]]


##Uses descriptive activity names to name the activities in the data set
activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 1] <- "WALKING"
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 2] <- "WALKING_UPSTAIRS"
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 3] <- "WALKING_DOWNSTAIRS"
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 4] <- "SITTING"
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 5] <- "STANDING"
allmerged_meanstd$activitytype[allmerged_meanstd$activitytype == 6] <- "LAYING"

##Appropriately labels the data set with descriptive variable names. 
#Did this at the start - it was easier for me to keep track of - see lines 6 and 7

##From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
# first make a new columns which is subject number and activity type together
allmerged_meanstd$subjactivity <- paste(allmerged_meanstd$subjectnumber, allmerged_meanstd$activitytype, sep = "")

tidydata<-aggregate(allmerged_meanstd, by=list(allmerged_meanstd$subjactivity), FUN=mean)
#tidy up the non numeric columns
tidydata$activitytype <- NULL
tidydata$subjactivity <- NULL
#relabel some columns
names(tidydata)[names(tidydata)=="Group.1"] <- "subjactivity"

#reorder the data to make for a nice read
tidydata <- tidydata[order(tidydata$subjectnumber),] 
tidydata$row.names <- NULL
#save tidydata to file
write.table(tidydata, "tidydata.txt", sep="\t", row.name=FALSE) 
}

