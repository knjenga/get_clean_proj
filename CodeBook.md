DATA DICTIONARY : Summary Data from Human Activity Recongntion Using Smartphones.

Subject_ID 
	Unique Number assinged to each of the 30 particpants in the study
 	Values : 1 to 30
	Data Type : Integer
 Activity_Id
                Unique Number assigend to each of the six actvities that were measured as part of the study
 	Values : 1 to 6
	Data Type : Integer
 Activity_Name
                Name of the actvities that were measured as part of the study
	Values :  WALKING
		WALKING_UPSTAIRS
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING
	Data Type : Text

For each Subject and Activity several feature variables were collected and summarized, bellow is a list of the measurments.  For each feature three values were recordred by the study along the X, Y and Z axis. The data set has the mean and standard devation of each featrure measruemnts along the X,Y and Z axis. 
Feature Columns Name Key:
	 A columns with "mean()" - Is a mean value for the feature along the the axis
	A columns with "StdDev()- Are Standard Deviation value
	A columns with "Acc" - A column which is an Acceleration measurment
	A columns with "GyroJerk" - Is an AngularAcceleration measurment
	A columns with "Gyro" - An gularSpeed measurment
	A columns with "Mag" - A Magnitude measurment
	A columns start with "t- Is a Time measurment
	A columns with "f" - Is a Frequency measurment
==================================================================================
Summary Columns
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-StdDev()-X
fBodyAcc-StdDev()-Y
fBodyAcc-StdDev()-Z
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-StdDev()-X
fBodyAccJerk-StdDev()-Y
fBodyAccJerk-StdDev()-Z
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-StdDev()-X
fBodyGyro-StdDev()-Y
fBodyGyro-StdDev()-Z
fBodyGyro-meanFreq()-X
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()
fBodyAccMag-StdDev()
fBodyAccMag-meanFreq()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-StdDev()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-StdDev()
fBodyBodyGyroMag-meanFreq()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-StdDev()
fBodyBodyGyroJerkMag-meanFreq()
