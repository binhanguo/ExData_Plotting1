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

hist(data$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png,file="figure/plot1.png",width=480,height=480)
dev.off()
