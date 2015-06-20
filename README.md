coursework
==========
The script opens and pieces together a number of data files containing:
test and train data, test and train activity types, test and train subject numbers and the column headings.
The columns headings are changes to lower case 
The columns containing mean() and std() are extracted along with the activity type and subject number. 
A new data set is created with the means of the mean and the mean of the standard deviations avergaed for each subject and each activty type. 

IN DETAIL

The column names are read from features.txt
The row labels - the activity types are read from test and train folders and combined
The data from test and train are combined. 
The data is then labelled with column names as a header 
The activity types (from test and train combined) become the first column (rowlabels)

Tidy data requires each column have a sensible name so I alter V1 to bcome "activitytype"

The subject numbers from test and train are combined and added to become the first column. Hadley wickham recommends subject identifiers are at the start and I have observed this. 

Tidy data requires each column have a sensible name so I alter V1 to bcome "subjectnumber"

Coursera videos recomends column names in lower case - so I change all teh columns to lower case

I extract the numbers of the  columns containing the phrase "mean()" and then those containing  "std()" in order to include the relevant columns. I make a list of all these numbers and order them . 
I use this list of column numbers to subset the data

##Uses descriptive activity names to name the activities in the data set
The labels of the activity type are replaced to be human readable with reference to the file activity_labels.txt in the files we were provided with

##Appropriately labels the data set with descriptive variable names. 
I did this at the start - it was easier for me to keep track of - see lines 6 and 7

##From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
In order to create an average for each variable and each activity and each subject I make a column which is subject and activity combined: thus we will have six rows for each subject, one for each of the activities. 
As a couple of columns are no longer relevant and are non numeric so means cannot be calcuated (activity type and subjactivity) I delete these. 
I then order the data by subject number to make it easier to read.
I then write the tidydata to file

