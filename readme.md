This repo contains the files for the Peer Assessment Activity for the Data Science Specialization - Getting and Cleaning Data course on Coursera.

The data are from a study of motion during different human activities using a smartphone as a motion detector.  A description of the study and how the data were obtained is located here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The dataset can be obtained from this repo or from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


Files /directories included:

	Dataset.zip - original data downloaded from above link on 25-Apr-2014.
	UCI HAR Dataset - unzipped data
	run_analysis.R - R script that creates a tidy, aggregated dataset from the original data (described below)
	readme.md - this file, a markdown readme describing the files in the the repo and the data analysis performed in run_analysis.R
	tidydata.csv - csv formatted aggregated, tidy dataset outputted from run_analysis.R (same information as tidydata.txt)
	tidydata.txt - txt formatted aggregated, tidy dataset outputted from run_analysis.R (same information as tidydata.csv)
	codebook.txt - codebook describing variables in tidydata.csv / tidydata.txt

Description of data analysis performed by run_analysis.R:

run_analysis.R is an analysis script for the data that performs the following steps:

	1. Sets working directory
	2. Downloads, unzips, and loads data into R data frames
	3. Ascribes the following to each observation in the testing and training data subsets: 
		- subject ID of the participant in the study
		- descriptive activity labels of the human activity being performed
		- associated activity code of the human activity
	4. Merges the testing and training data
	5. Selects variables that are only means and standard deviations
	6. Aggregates the variables selected in the above step by averaging data for each subject and activity
	7. Outputs a tidy dataset of the above steps as both tidydata.txt and tidydata.csv