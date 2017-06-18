## set column classes before reading large dataset
fClasses <- c("character", "character", rep("numeric",7))

## read the power consumption file
fRows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 2075259, sep =";", colClasses = fClasses, na.strings = "?")

## modify first column to Date format
fRows$Date <- as.Date(fRows$Date,"%d/%m/%Y")

## select only the rows for the specified dates
sRows <- subset(fRows, Date=="2007-02-01"|Date=="2007-02-02")

## open png device to write out the plot
png(file="plot1.png", width = 480, height = 480, units = "px")

##plot 1
hist(sRows$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## close device
dev.off()