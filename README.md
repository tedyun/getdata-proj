# Getting and Cleaning Data Project

by Taedong Yun

## How to Run Analysis

* This project requires "reshape2" R package. Run the following command if not installed
```R
install.packages("reshape2")
```
* Download a data file from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it in the project's root directory. A directory named "*UCI HAR Dataset*" will be created (in the same level as "*run_analysis.R*" file).
* Open R console and set the project root directory as the working directory (or open "*getdata-proj.Rproj*" in R Studio.)
* Run the following command
```R
source("run_analysis.R"); runAnalysis()
```
* A new file "*result_final.txt*" will be created in the root directory as a result.

##