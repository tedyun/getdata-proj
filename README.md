# Getting and Cleaning Data Project

by Taedong Yun

## How to Run Analysis

* This project requires "reshape2" R package.
* Download a data file from here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it in the project's root directory. A directory named "*UCI HAR Dataset*" will be created (in the same level as "*run_analysis.R*" file).
* Open R console in the project directory and run the following commands
```R
source("run_analysis.R"); runAnalysis()
```
* A new file "*result_final.txt*" will be created in the root directory as a result.