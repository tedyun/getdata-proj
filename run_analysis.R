library(reshape2)

## This is a helper function that returns TRUE if the given str contains a substring
## ".mean." or ".std.". This function supports vectorized operations
isMeanOrStd <- function (str) {
    ## need to escape the dot character
    grepl("mean__", str) | grepl("std__", str)
}

## This function take a directory name, a feature vector, and an activity labels vector
## and returns a data frame that contains combined data in the directory.
readDataDirectory <- function (dir, features, act_labels) {
    ## read test data sets
    
    # path for each file
    subjpath <- paste("UCI HAR Dataset/", dir, "/subject_", dir, ".txt", sep = "")
    datapath <- paste("UCI HAR Dataset/", dir, "/X_", dir, ".txt", sep = "")
    actpath <- paste("UCI HAR Dataset/", dir, "/y_", dir, ".txt", sep = "")
    
    # subject_test contains only one column so get the first column
    subj <- read.table(subjpath, header=FALSE)[[1]]
    
    ### STEP 4 here ###
    # Appropriately labels the data set with descriptive variable names.
    # the columns in X_test are the features
    data <- read.table(datapath, header=FALSE, col.names=features)
    
    # y_test contains only one column so get the first column
    act <- read.table(actpath, header=FALSE)[[1]]
    
    ### STEP 2 here ###
    # Extracts only the mean and standard deviation
    data <- data[, which(isMeanOrStd(names(data)))]
    
    ### STEP 3 here ###
    # Uses descriptive activity names to name the activities in the data set
    act_desc <- sapply(act, function(k) {toString(act_labels[[k]])})
    
    # save the column names for later use
    oldcols <- names(data)
    
    # add columns "subject" and "activity"
    data$subject <- subj
    data$activity <- act_desc
    
    # rearrange columns so that "subject" and "activity" will come first
    data <- data[c("subject", "activity", oldcols)]
    
    # return data frame
    data
}

## Main Function
runAnalysis <- function () {
    
    # read feature & label tables
    # (for these data files the first columns are indices so we only need the second column)
    features <- read.table("UCI HAR Dataset/features.txt", header=FALSE, col.names=c("index", "val"))[[2]]
    act_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("index", "label"))[[2]]
    
    # convert all "-", "(", ")", "," characters in feature vector to "_"
    features <- gsub("[-\\(\\)\\,]", "_", features)
    
    # Get test dataset and train dataset
    data_test <- readDataDirectory("test", features, act_labels)
    data_train <- readDataDirectory("train", features, act_labels)
    
    ### STEP 1 here ###
    # merge two datasets
    data_total <- rbind(data_test, data_train)
    
    # Divide the columns into two groups:
    # "ids" contains "subject" and "activiry" columns
    # "vars" contains the rest of the columns
    cols <- names(data_total)
    ids <- cols[1:2]
    vars <- cols[3:length(cols)]
    
    # melt the data set
    data_melt <- melt(data_total, id=ids, measure.vars=vars)
    
    # summarize data using two ids -- "subject" and "activity" -- and "mean" function
    data_summarized <- dcast(data_melt, subject + activity ~ variable, fun.aggregate = mean)
    
    # convert column names "mean__" to "mean", "std__" to "std"
    names(data_summarized) <- gsub("mean__", "mean", names(data_summarized))
    names(data_summarized) <- gsub("std__", "std", names(data_summarized))
    
    # write "result_final.txt" file
    write.table(data_summarized, "result_final.txt", row.names = FALSE)
    
    # return summarized data
    data_summarized
}