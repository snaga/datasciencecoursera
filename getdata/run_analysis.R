library(plyr)

concat <- function(df1, df2)
{
  df <- df1
  append(df, df2)
  return(df)
}

write_concat_csv <- function(train, test, all)
{
  train_csv <- read.csv(train)
  test_csv  <- read.csv(test)
  all_csv <- concat(train_csv, test_csv)
  write.table(all_csv, file = all, quote = FALSE, row.names = FALSE, col.names = FALSE)
}

concat_all_csv <- function()
{
  write_concat_csv("UCI HAR Dataset/train/subject_train.txt",
                   "UCI HAR Dataset/test/subject_test.txt",
                   "subject.txt")
  write_concat_csv("UCI HAR Dataset/train/X_train.txt",
                   "UCI HAR Dataset/test/X_test.txt",
                   "X.txt")
  write_concat_csv("UCI HAR Dataset/train/y_train.txt",
                   "UCI HAR Dataset/test/y_test.txt",
                   "y.txt")

  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",
                   "body_acc_x.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",
                   "body_acc_y.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",
                   "body_acc_z.txt")

  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",
                   "body_gyro_x.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt",
                   "body_gyro_y.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt",
                   "body_gyro_z.txt")

  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",
                   "total_acc_x.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",
                   "total_acc_y.txt")
  write_concat_csv("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",
                   "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",
                   "total_acc_z.txt")
}

get_mean_index <- function(file)
{
  feature <- read.csv(file, sep = " ", header = FALSE)
  idx <- grep("-mean\\(\\)", feature[,2])
  
  return (feature[idx,])
}

get_std_index <- function(file)
{
  feature <- read.csv(file, sep = " ", header = FALSE)
  idx <- grep("-std\\(\\)", feature[,2])
  
  return (feature[idx,])
}

get_feature_mean_and_std <- function()
{
  idx1 <- get_mean_index("UCI HAR Dataset/features.txt")
  idx2 <- get_std_index("UCI HAR Dataset/features.txt")

  head(idx1)
  head(idx2)
  
  index <- c(as.vector(idx1[,1]), as.vector(idx2[,1]))
  label <- c(as.vector(idx1[,2]), as.vector(idx2[,2]))

  df <- data.frame(index = index, label = label)

  df <- df[order(df$index),]
  
  return(df)
}

# concat_all_csv()

get_label <- function()
{
  label <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = " ")
  y <- read.csv("y.txt", header = FALSE, sep = " ")
  
#  head(label)
#  head(y)
  
  y_label <- arrange(join(label,y), V1)
#  head(y_label)
#  nrow(y)
#  nrow(label)
#  nrow(y_label)  
  return(y_label[,2])
}

get_subject <- function()
{
  subject <- read.csv("subject.txt", header = FALSE, sep = " ")

  return(subject)
}

get_subject_and_label <- function()
{
  subject_and_label <- data.frame(subject = get_subject(), label = get_label())

  names(subject_and_label) <- c("Subject", "Activity_Label")

  return(subject_and_label)
}

extract_variables <- function()
{
  d <- read.csv("X.txt", header = FALSE, sep = "")
  #head(d[1,])
  
  features <- get_feature_mean_and_std()
  #head(features)
  idx <- features[,1]
  #idx
  #  for (i in 1:nrow(d))
  rs <- d[,idx]
#  head(rs)
  
  names(rs) <- features[,2]
  
#  head(rs)
  return(rs)
}

main <- function(outfile)
{
  df1 <- get_subject_and_label();
  head(df1)
  
  df2 <- extract_variables()
  head(df2)
  
  df <- data.frame(df1, df2)
  
  f <- get_feature_mean_and_std()
  colname <- c(as.vector(names(df1)), as.vector(f[,2]))
  names(df) <- colname

  write.table(df, outfile, quote = FALSE, row.names = FALSE, col.names = TRUE)
}

main("dataset.txt")
