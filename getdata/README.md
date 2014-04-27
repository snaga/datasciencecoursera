
run_analysis.R
==============

This program consists of one script, run_analysis.R.


Usage
-----

Before running the run_analysis.R script, make sure you have a data set
in your current working directory as following.

    ./UCI HAR Dataset/test/subject_test.txt
    ./UCI HAR Dataset/test/X_test.txt
    ./UCI HAR Dataset/test/y_test.txt
    ./UCI HAR Dataset/train/subject_train.txt
    ./UCI HAR Dataset/train/X_train.txt
    ./UCI HAR Dataset/train/y_train.txt
    ./UCI HAR Dataset/activity_labels.txt
    ./UCI HAR Dataset/features.txt

Then, run run_analysis.R script in that directory.


How It Works
------------

Once run_analysis.R is run, it merges test files and training files first.
run_analysis.R generates 3 merged files in the current working directory:

    subject.txt
    X.txt
    y.txt

Then, run_analysis.R generates a tidy data set (dataset.txt) with reading
3 merged files, activity_labels.txt and features.txt.

    dataset.txt


