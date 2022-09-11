install.packages("chron")
library(chron)

data<-read.table("~/R files/household_power_consumption.txt",header=TRUE,sep = ";")
head(data)
str(data)

data$Date<-as.Date(data$Date, "%d/%m/%Y")
str(data)

finaldata<-data[which(data$Date=="2007-02-01" |data$Date=="2007-02-02"),]

finaldata2<-finaldata[complete.cases(finaldata),]

finaldata2$Global_active_power=as.numeric(finaldata2$Global_active_power)

finaldata2$datetime<-as.POSIXct(paste(finaldata2$Date, finaldata2$Time), format="%Y-%m-%d %H:%M:%S")
head(finaldata2)
class(finaldata2$datetime)

with(finaldata2, plot(datetime ,Global_active_power,"l"))
