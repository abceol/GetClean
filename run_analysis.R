
features <- read.table("UCI HAR Dataset/features.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt",
    colClasses=rep('numeric', 561))
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",
    colClasses=rep('numeric', 561))
X <- rbind(X_train, X_test)
names(X) <- features[,2]
rm(X_train, X_test)

mean_indices <- grep('(mean){1}[()]{2}', features[,2])
sd_indices <- grep('(std){1}[()]{2}', features[,2])
X <- X[, c(mean_indices, sd_indices)]

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X$activity <- rbind(y_train, y_test)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X$subject <- rbind(subject_train, subject_test)
rm(y_train, y_test, subject_train, subject_test)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

subject <- rep(1:30, each=6)
activity <- rep(activities[,2], 30)
means <- sapply(X[1:(ncol(X)-2)], tapply, c(X$activity, X$subject), mean)
tidy_data <- data.frame(subject, activity, means)
names(tidy_data) <- sub("..", "", names(tidy_data), fixed=TRUE)

write.table(tidy_data, file="tidy.txt")
