if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",temp)
  unzip(temp)
  unlink(temp)
}

activity<-read.csv("activity.csv")

mean_raw<-mean(totalStepsByDay$steps)
mean_raw

##[1] 10766.19

median_raw<-median(totalStepsByDay$steps)
median_raw

##[1] 10765