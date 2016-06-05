## plot2.R

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


plot(rawdata$Global_active_power ~ rawdata$DateTime, type = "l", ylab="Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png") 
dev.off() 