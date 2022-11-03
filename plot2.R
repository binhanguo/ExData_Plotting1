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
par(mfcol=c(1,1))

plot(data$Global_active_power, type="l",xaxt="n",xlab="", 
     ylab="Global Active Power (kilowatts)")
axis(1,at = c(1,nrow(data)/2,nrow(data)),labels = c("Thu","Fri","Sat"))
dev.copy(png,file="figure/plot2.png",width=480,height=480)
dev.off()

