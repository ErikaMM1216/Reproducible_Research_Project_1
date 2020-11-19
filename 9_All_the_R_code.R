if(!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip",temp)
  unzip(temp)
  unlink(temp)
}

activity<-read.csv("activity.csv")
head(activity)

totalStepsByDay<-aggregate(steps~date, activity, sum)
hist(totalStepsByDay$steps, xlab="Class of Total Number of Steps per day", ylab="Number of Days", main="Total Number of Steps taken each day")

mean_raw<-mean(totalStepsByDay$steps)
mean_raw

median_raw<-median(totalStepsByDay$steps)
median_raw

averageStepsbyInterval<-aggregate(steps~interval, activity, mean)
with(averageStepsbyInterval, plot(interval, steps, type = "l"))

averageStepsbyInterval[which.max(averageStepsbyInterval[,2]),1]

missingIndex<-is.na(activity[,1])
m<-mean(averageStepsbyInterval$steps)
activity1<-activity
activity1[missingIndex,1]<-m
head(activity1)

totalStepsByDay1<-aggregate(steps~date, activity1, sum)
hist(totalStepsByDay1$steps, xlab="Class of Total Number of Steps per day", ylab="Number of Days", main="Number of Steps taken each day after missing values are imputed")


activity1$date<-as.Date(activity1$date)
library(dplyr)

activity2<-activity1%>%
  mutate(dayType= ifelse(weekdays(activity1$date)=="Saturday" | weekdays(activity1$date)=="Sunday", "Weekend", "Weekday"))
head(activity2)

averageStepByDayTypeAndInterval<-activity2 %>%
  group_by(dayType, interval) %>%
  summarize(averageStepByDay=sum(steps))

head(averageStepByDayTypeAndInterval)

library(lattice)
with(averageStepByDayTypeAndInterval, 
     xyplot(averageStepByDay ~ interval | dayType, 
            type = "l",      
            main = "Total Number of Steps within Intervals by dayType",
            xlab = "Daily Intervals",
            ylab = "Average Number of Steps"))
