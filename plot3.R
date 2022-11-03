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
png("./figure/plot3.png",height = 480,width = 480)
plot(data$Sub_metering_1,col="black",type = "l",
     xaxt="n",xlab="",
     ylab="Energy sub metering")
lines(data$Sub_metering_2,col="red")
lines(data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))
dev.copy(png,file="figure/plot3.png",width=480,height=480)
dev.off()
