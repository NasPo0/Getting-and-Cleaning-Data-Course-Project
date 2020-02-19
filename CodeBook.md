Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ

- tGravityAcc-XYZ

- tBodyAccJerk-XYZ

- tBodyGyro-XYZ

- tBodyGyroJerk-XYZ
- tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

From data sets a tidy data set was created. Data sets used are as follows:

features: List of all features.
activity_labels: Links the class labels with their activity name.
X_train: Training set.
y_train: Training labels.
subject_train: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
X_test: Test set.
y_test: Test labels.
subject_test: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

The data sets are read into R. The data frames are named as follows:

features: data set 'features'
train.data: data set 'X_train'
train.labels: data set 'y_train'
train.subject: data set 'subject_train'
test.data: data set 'X_test'
test.labels: data set 'y_test'
test.subject: data set 'subject_test'

For creating a tidy data set various transformations were necessary. It follows a list of all variables used in the R code:

cols: using R function grep() relevant features 'mean()' and std()' are fixed.
filter.cols: using R function grep() columns for variable 'meanFreq()' are fixed.
filter.train: filter train.data by selected columns (using cols), data on 'meanFreq()' is removed (using filter.cols).
filter.test: filter test.data by selected columns (using cols), data on 'meanFreq()' is removed (using filter.cols).
train: merging train.subject, train.labels, filter.train by column binding to create one data set for the training data.
test: merging test.subject, test.labels, filter.test by column binding to create one data set for the test data.
merged.data: merging train and test by row binding to create one data set.
grp: grouping by columns subject and act.label leads to this tidy data set with 180 observations of 68 variables.
