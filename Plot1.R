install.packages("chron")
library(chron)

data<-read.table("~/R files/household_power_consumption.txt",header=TRUE,sep = ";")
head(data)
str(data)

data$Date<-as.Date(data$Date, "%d/%m/%Y")
str(data)

finaldata<-data[which(data$Date=="2007-02-01" |data$Date=="2007-02-02"),]
str(finaldata)
head(finaldata)

finaldata2<-finaldata[complete.cases(finaldata),]
str(finaldata2)
finaldata2$Global_active_power=as.numeric(finaldata2$Global_active_power)
hist(finaldata2$Global_active_power,col = "red")
