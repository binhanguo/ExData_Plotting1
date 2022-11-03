rm(list=ls())
options(stringsAsFactors = F)

library(dplyr)
library(tidyverse)
data <- list.files(pattern = ".txt") %>%
  map_dfr(~read.table(.x,sep = ";",header = T,
                      na.strings = "?",
                      colClasses = c("character", "character", 
                      "numeric", "numeric", 
                      "numeric", "numeric", 
                      "numeric", "numeric", 
                      "numeric"))) 

data$Date <- as.Date(data$Date,"%d/%m/%Y")
data <- data[(data$Date >= "2007-02-01" & data$Date <="2007-02-02"),]
#plot
png("./figure/plot4.png",width = 480,height = 480)
par(mfrow=c(2,2))
#1
plot(data$Global_active_power, type="l",xaxt="n",xlab="", 
     ylab="Global Active Power (kilowatts)")
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))
#2
plot(data$Voltage, type="l",xaxt="n",xlab="", 
     ylab="Voltage")
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))
#3
plot(data$Sub_metering_1,col="black",type = "l",
     xaxt="n",xlab="",
     ylab="Energy sub metering")
lines(data$Sub_metering_2,col="red")
lines(data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))
#4
plot(data$Global_reactive_power, type="l",xaxt="n",xlab="", 
     ylab="Global_reactive_Power")
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))

dev.off()
