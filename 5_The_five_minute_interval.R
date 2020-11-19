if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",temp)
  unzip(temp)
  unlink(temp)
}

activity<-read.csv("activity.csv")

averageStepsbyInterval[which.max(averageStepsbyInterval[,2]),1]

##[1] 835