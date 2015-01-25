# Getting and Cleaning Data Project

by Taedong Yun

## How to Run Analysis

* __This project requires *reshape2* R package__. Run the following command to install the package.
```R
install.packages("reshape2")
```
* Download a data file from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it in the project's root directory. A directory named "*UCI HAR Dataset*" will be created (on the same level as *run_analysis.R* file.)
* Open R console and set the project root directory as the working directory (or open *getdata-proj.Rproj* in R Studio.)
* Run the following command
```R
source("run_analysis.R"); runAnalysis()
```
* A new file *result_final.txt* will be created in the root directory as a result. This file contains the tidy dataset we seek.

## Explanation

There are three functions in *run_analysis.R*.

- __isMeanOrStd__: internal function that checks if a string contains characters "mean__" or "std__". Returns TRUE if it does, FALSE otherwise.
- __readDataDirectory__: internal function that reads "test" or "train" sub-directory and returns a data frame which has the following property:
-- the data frame only includes columns about the mean or the standard deviation for each measurement
-- the name of the columns are all descriptive
-- the first column of the data frame is "subject" which denotes the subjects of the expriment (numbers from 1 to 30)
-- the second column of the data frame is "activity" which denotes the *descriptive* activity name
- __runAnalysis__: the main function. This utilizes the other two internal functions and returns the final tidy dataset and writes it in "result_final.txt" file.

Recall the five steps in the project description:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The __readDataDirectory__ function takes care of the steps 2-4. The main function __runAnalysis__ merges (step 1) the two datasets returned from *readDataDirectory* and reshapes it into the final tidy data set (step 5).

## Other Information

Note that the features in the original data set includes some special characters that are not suitable to be used as column names so we convert them into '_' or delete them. In particular, we delete the characters '(' and ')', and convert '-' and ',' to '_'. For example,

> fBodyAccJerk-mean()-X

becomes

> fBodyAccJerk_mean_X