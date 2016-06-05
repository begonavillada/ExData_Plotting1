## plot3.R

library(data.table)
library(lubridate)

setwd("/home/bvillada/eda/week1/data/")
file <- "household_power_consumption.txt"


# separator ";"
colclasses <- c("Date", "character",rep('numeric',7))
allData <- fread(file, sep=";", na.strings="?", header = TRUE, colClasses = colclasses)
# subset to rows with specific dates 
rawdata <- subset(allData, Date == "1/2/2007" | Date ==  "2/2/2007")
# delete entire dataset
rm(allData)

# format Date and Time vectors into a mixed variable
Sys.setlocale('LC_ALL' , 'C')
rawdata$DateTime <- dmy_hms(paste(rawdata$Date, rawdata$Time))

# build plot with one Sub_metering variable
# add lines with 2nd and 3rd variable
par(mfrow=c(1,1))
with(rawdata,
     {plot(DateTime, Sub_metering_1, col="black", type = "l", xlab = "", ylab = "Energy sub metering" )
      lines(DateTime, Sub_metering_2, col="red", type = "l" )
      lines(DateTime, Sub_metering_3, col="blue", type = "l")
     }
     )
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.copy(png, file = "plot3.png") 
dev.off() 

