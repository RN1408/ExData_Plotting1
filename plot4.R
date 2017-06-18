## set column classes before reading large dataset
fClasses <- c("character", "character", rep("numeric",7))

## read the power consumption file
fRows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 2075259, sep =";", colClasses = fClasses, na.strings = "?")

## modify first column to Date format
fRows$Date <- as.Date(fRows$Date,"%d/%m/%Y")

## select only the rows for the specified dates
sRows <- subset(fRows, Date=="2007-02-01"|Date=="2007-02-02")

## open png device to write out the plot
png(file="plot4.png", width = 480, height = 480, units = "px")

## set number of plots per row, column
par(mfrow=c(2,2))

##plot 1
plot(as.POSIXlt(paste(sRows$Date,sRows$Time) ), sRows$Global_active_power,type="n", ylab = "Global Active Power", xlab = "")
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Global_active_power )

##plot 2
plot(as.POSIXlt(paste(sRows$Date,sRows$Time) ), sRows$Voltage,type="n", ylab = "Voltage", xlab = "datetime")
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Voltage)

##plot 3
plot(as.POSIXlt(paste(sRows$Date,sRows$Time) ), sRows$Sub_metering_1,type="n", ylab = "Energy sub metering", xlab = "")
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Sub_metering_1 )
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Sub_metering_2, col="red" )
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Sub_metering_3, col="blue" )
legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1,lwd = 1,bty="n")

##plot 4
plot(as.POSIXlt(paste(sRows$Date,sRows$Time) ), sRows$Global_reactive_power,type="n", ylab = "Global_reactive_power", xlab = "datetime")
lines( as.POSIXlt(paste(sRows$Date,sRows$Time)), sRows$Global_reactive_power)

## close device
dev.off()