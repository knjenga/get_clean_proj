##
## The R script (run_analyis.R) was designed to create a tidy data set that could be used for
## the analysis that helps understand the various ways and conditions people use their cell phones.
## The data was collected from various subjects under various conditions using the accelerometers from the Samsung Galaxy S smartphone.
##
## The Script performs the various functions
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. Creates a second, independent tidy data set with the average of each variable for each activity
##     and each subject.  
##

library("reshape2")

check.files.getwd = function() {
  # The data used for analysis should be your working directory
  # Program expects to find the data directory "UCI HAR Dataset" in the working directory
  # Check for the directory
  working_dir <- getwd()
  data_dir <- paste0(working_dir,"/UCI HAR Dataset")
  if (!file.exists(data_dir)) { #files dont Exists
    error_msg <- paste0("Script ABORTING!! Directory : ",data_dir," NOT FOUND!!!") 
    # Stop the script and load the data
    stop(error_msg)
  }
  #return the location of the files
  data_dir <- paste0(data_dir,"/")
  data_dir
}

get.features = function(dir_name) {
 # Function reads the files that contains the original feature names
 features_file <- paste0(dir_name,"features.txt")  
 features_names <- read.csv(features_file,sep="",header=FALSE)
 # return the names of the features
 features_names  
}

load.subjects = function(data_type,dir_name) {
  # function to load the data for either training or testing
  subjects_file <- paste0(dir_name,data_type,"/subject_",data_type,".txt")
  subjects_data <- read.table(subjects_file,header=F)
  # return the subjects data
  subjects_data
}

load.y_data = function(data_type,dir_name) {
  # function to load the y data for either training or testing
  y_file <- paste0(dir_name,data_type,"/y_",data_type,".txt")
  # read the y data based on the either its a training or testing data set
  y_data <- read.table(y_file,header=F)
  # return the loaded y data set
  y_data
}

load.x_data = function(data_type,dir_name) {
  # function to load the x data for either the training or testing data sets
  x_file <- paste0(dir_name,data_type,"/X_",data_type,".txt")  
  # Load the x data set
  x_data <- read.table(x_file,header=F)
  # retrun the loaded feature data 
  x_data
}

assign.activity.labels = function(activity_matrix,dir_name) {
  # Assigns the an activity data set has numeric activity values descriptive activity names
  #Load the file with list of numeric activity values and their corresponding descriptive names
  activity_file <- paste0(dir_name,"activity_labels.txt")
  activity_names <- read.table(activity_file)[,2]
  # Assign the matrix descriptive activity names
  activity_matrix[,2] = activity_names[activity_matrix[,1]]
  # Assign the matrix columns names
  names(activity_matrix) = c("Activity_Id","Activity_Name")
  # return the matrix with the descriptive activity names now added
  activity_matrix  
}

filter.data = function(dir_name,data_set,filter_values){
  # Accepts a string that filters the data to return the desired fields of the data set 
  # Get the names of the features for the X data set
  col_names <- get.features(dir_name)
  # Assign the the x data the column names
  names(data_set) <- col_names$V2
  # Create string of what values to extract from the data set 
  filter_columns <- grep(filter_values,col_names[,2])
  # Filter the data to leave the desired columns
  data_set = data_set[,filter_columns]
  # retrun the filtered data set
  data_set  
}

format.columns = function (data_frame) {
  # format the the file name columns to make them more readable
  # Remove the () in the column names
  names(data_frame) <-gsub("mean()", "mean", names(data_frame))
  # change std to StdDev to remove mabiguity 
  names(data_frame) <-gsub("std()", "StdDev", names(data_frame))
  #formate mean columns
  data_frame
}

# check if the files excists in the working directory
  data_files <- check.files.getwd()

# Load both the test and train data study subjects data
  subject_test_data <- load.subjects("test",data_files)
  subject_train_data <- load.subjects("train",data_files)
  # Bind the test and train subject data sets
  subject_all <- rbind(subject_test_data,subject_train_data)
  # Assign Subject column headers
  names(subject_all)<- c("Subject_ID")

# Load the activity data
  y_test_data <- load.y_data("test",data_files)
  y_train_data <- load.y_data("train",data_files)
  # Bind the test and train y data sets
  y_all <- rbind(y_test_data,y_train_data)
  # Assign Activity columns headers
  y_all <- assign.activity.labels(y_all,data_files)

# Load the test and train data for the x data sets
  x_test_data <- load.x_data("test",data_files)
  x_train_data <- load.x_data("train",data_files)
  # Bind the test and train x data sets
  x_all <- rbind(x_test_data,x_train_data)
  # filter out all the data that is not mean and standard deviation data
  x_all <- filter.data(data_files,x_all,"mean|std")

# Bind all the data to create one data set
  all_data <- cbind(subject_all,y_all,x_all)

#Calculate the means for all the data
 #select the columns to group by
 agg_cols  <- c("Subject_ID","Activity_Id" ,"Activity_Name")
 #select the columns with the measures
 agg_measures <- setdiff(colnames(all_data),agg_cols)
 #convert the data set from a wide one into a long one
 long_all_data <- melt(all_data,id=agg_cols,measure.vars=agg_measures)
 #calcuate the means of the in the long data set grouped by  Activity_Name and Subject_ID
 tidy_data <- dcast(long_all_data, Subject_ID + Activity_Id + Activity_Name  ~ variable,mean)
 # format the column headers before printing to file
 tidy_data <- format.columns(tidy_data)
 #write the tidy data to a file
 out_put_dir <- paste0(data_files,"tidy.txt")
 write.table(tidy_data,out_put_dir,row.name=FALSE)
