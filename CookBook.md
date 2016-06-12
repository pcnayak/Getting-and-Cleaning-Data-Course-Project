The following variables are used in the code.
X_train : Training X data
y_train : Training y data
subject_train  : Training subject data

X_test : Test X data
y_test : Test y data
subject_test : Test subject data

features: To read all the features variables from the features.txt files
activity_labels : To read all the features variables from the activity_labels.txt files

X_data : Merge X_train and X_test
y_data : Merge y_train and y_test
subject_data : Merge subject_train and subject_test

merged_data : To merge the data from X_data, y_data, subject_data
averages_data : To calculate the final averages tables


The following logic is applied to the code.

1. Download the zip file if not available in the local directory and unzip it
2. Read all the data files
3. Merge the training and test data files
4. Subset the X_data and keep only the columns which are mean() or std() types by using regular expression.
5. Rename the columns of Y_data and subject_data
6. Merge the X, Y and subject data into one
7. Calculate the averages using the ddply function
8. Write the output to a file
