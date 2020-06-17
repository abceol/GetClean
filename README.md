
*"The goal of reshaping data is to obtain tidy data, i.e. where each variable forms a column, each observation forms a row, and each table/file stores data about one kind of observation."*

----

## Project Brief

Here is the introduction to the project, together with a link to the original dataset used:

> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
> 
> [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
> 
> Here are the data for the project:
> 
> [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

----

## Task Specifications

> You should create one R script called run_analysis.R that does the following.
> 
>  * Merges the training and the test sets to create one data set.
>  * Extracts only the measurements on the mean and standard deviation for each measurement.
>  * Uses descriptive activity names to name the activities in the data set
>  * Appropriately labels the data set with descriptive variable names.
>  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

----

## From the original `README.txt`

> Human Activity Recognition Using Smartphones Dataset
> Version 1.0
> 
> Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
> Smartlab - Non Linear Complex Systems Laboratory
> DITEN - Università degli Studi di Genova.
> Via Opera Pia 11A, I-16145, Genoa, Italy.
> [activityrecognition@smartlab.ws](activityrecognition@smartlab.ws)
> [www.smartlab.ws](www.smartlab.ws)

### How the data were acquired

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

----

## Description of `run_analysis.R`

### Reading `X`

 * first the script reads in the list of feature names (from `features.txt`)
 * then the train and test input data is read in (`X_train`, `X_test`)
 * these are joined into one big input data.frame (called `X`), and the column names are set to the feature names (and then `X_train` & `X_test` are removed, to save memory)

### Finding mean() and std()

Next we want to extract the mean and standard deviation variables from among all the 561 features. There are 33 of each, so we will extract 66 features in total.

 * the indices of the occurances of the string "mean()" and "std()" are obtained using `grep()`
 * next `X` is subset, so that it now only includes these 66 columns

### Reading Labels

We now want to read in the output labels `y`. Each label consists of an integer indicating which activity the subject was performing for a given record in `X`.

We also want to read in the subject identifiers. There were 30 subjects, so each subject identifier is an integer between 1 and 30 (inclusive).

 * the labels are read from `y_train.txt` and `y_test.txt`, and then the train and test data are joined, using `rbind` (same as was done with `X_train` & `X_test`)
 * the labels are added into our `X` data.frame under the column name *"activity"*
 * the same is done with the subject identifiers (located in `subject_train.txt` and `subject_test.txt`), using the column name *"subject"*
 * the unneeded data.frames are removed, to free up memory

### Taking Averages

 * the `sapply` loop function is used to call the `tapply` loop function on each of the first 66 columns of `X` (i.e. the ones with the features)
 * `tapply` calls the `mean` function and gives us average values of each of the 66 variables, for each subject performing each activity
 * because there are 30 subjects and 6 activities, this results in a 180*66 matrix of values

### Making and Saving the Tidy Dataset

 * I read in the 6 different activity labels (from `activities.txt`)
 * I made a new integer vector called `subject`, which contains the integers from 1 to 30, each repeated 6 times (i.e. 1,1,1,1,1,1,2,2,2,2,2,2,...)
 * I made a character vector containing all the names of the activities, with the sequence of 6 activity labels repeated 30 times
 * I stuck the subject identifier integer vector, and the activity label character vector, and the matrix together to form a new *tidy* data.frame
 * I fixed up the column names by removing excess dots
 * I saved the new tidy data.frame in the file "tidy.txt"

----

## License for the dataset

> Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
> 
> [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
> 
> This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
> 
> Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
