install.packages("ggplot2")
library(ggplot2)
library(grid)
library(graphics)


data<-read.table("~/R files/household_power_consumption.txt",header=TRUE,sep = ";")
head(data)
str(data)

data$Date<-as.Date(data$Date, "%d/%m/%Y")
str(data)

finaldata<-data[which(data$Date=="2007-02-01" |data$Date=="2007-02-02"),]

finaldata2<-finaldata[complete.cases(finaldata),]
finaldata2$datetime<-as.POSIXct(paste(finaldata2$Date, finaldata2$Time), format="%Y-%m-%d %H:%M:%S")
finaldata2$Global_active_power=as.numeric(finaldata2$Global_active_power)
finaldata2$Sub_metering_1=as.numeric(finaldata2$Sub_metering_1)
finaldata2$Sub_metering_2=as.numeric(finaldata2$Sub_metering_2)
finaldata2$Voltage=as.numeric(finaldata2$Voltage)
finaldata2$Global_reactive_power=as.numeric(finaldata2$Global_reactive_power)

data_ggp <- data.frame(x = finaldata2$datetime,                            # Reshape data frame
                       y = c(finaldata2$Sub_metering_1, finaldata2$Sub_metering_2, finaldata2$Sub_metering_3),
                       group = c(rep("Sub_metering_1", nrow(finaldata2)),
                                 rep("Sub_metering_2", nrow(finaldata2)),
                                 rep("Sub_metering_3", nrow(finaldata2))))

#head(data_ggp) 
ggp <- ggplot(data_ggp, aes(x, y, col = group)) +             
  geom_line()
gfinal<-ggp + ggtitle("Plot 3") +
  xlab("Datetime") + ylab("Energy Sub Metering")


par(mfrow=c(2,2))

with(finaldata2, plot(datetime ,Global_active_power,"l",main="Global_active_power vs. Datetime"))
with(finaldata2, plot(datetime ,Voltage,"l",main="Voltage vs. Datetime"))
with(finaldata2, plot(datetime ,Global_reactive_power,"l",main="Global_reactive_power vs. Datetime"))
