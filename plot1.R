##
## plot1.R
library(data.table)

setwd("/home/bvillada/eda/week1/data/")
file <- "household_power_consumption.txt"

colclasses <- c("Date", "character", rep('numeric',7)

allData <- fread(file, sep=";", na.strings="?", header = TRUE, colClasses = colclasses)
# subset to rows with specific dates 
rawdata <- subset(allData, Date == "1/2/2007" | Date ==  "2/2/2007")

# delete complete dataset
rm(allData)

# format Date and Time vectors properly
rawdata$Date <- as.Date(rawdata$Date, "%d/%m/%Y")
rawdata$Time <- strptime(rawdata$Time, format="%H:%M:%S")

with(rawdata, 
     hist(as.numeric(Global_active_power), 
          col = "red", 
          main = "Global Active Power", 
          xlab = "Global Active Power (kilowatts)")
     + )
dev.copy(png, file = "plot1.png") 
dev.off()  