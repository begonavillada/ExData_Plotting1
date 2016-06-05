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

build frame of plots
par(mfrow = c(2,2))
with(rawdata,{
        plot(Global_active_power ~ DateTime, type = "l", ylab="Global Active Power (kilowatts)", xlab = "")
        plot(Voltage ~ DateTime, type = "l", ylab="Voltage", xlab = "datetime")
        {plot(DateTime, Sub_metering_1, col="black", type = "l", xlab = "", ylab = "Energy sub metering" )
        lines(DateTime, Sub_metering_2, col="red", type = "l" )
        lines(DateTime, Sub_metering_3, col="blue", type = "l")
        legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
         }
        plot(Global_reactive_power ~ DateTime, type = "l", ylab="Global_reactive_power", xlab = "datetime")
        }
        )
dev.copy(png, file = "plot4.png") 
dev.off() 