---
title: "CodeBook"
author: "Daniel Felbah"
date: "10/21/2019"
output: html_document
---


This a code book that describes the variables, the data, and any transformations performed to clean up the data.

1. Data was downloaded from `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip` and then saved as `Data.zip` which was later unzip as `UCI HAR Dataset` folder.

2. Train and test datasets merged together to create `merged` dataframe which contains 10299 observations and 563 variables.

3. Since data had some duplicate columns those were removed and only measurements on mean and standard deviatin was extracted to create the `data` dataframe. The has 10299 observations and 88 variables.

4. The numeric labels on activities were replaced with a more decriptive names.

5. Variable names were also renamed to be more descriptive.

6. Finally, a final dataset was created to show the average for each aactivity and each subject. The resulting `final` has 180 observations and 88 variables. This was exported as `final.txt`.