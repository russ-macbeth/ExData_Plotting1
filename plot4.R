## Plot 4 - script to replicate the first plot of the Exploratory Data Analysis Course
## course project 1

## Download Libraries
library(data.table)

## Download and unzip the data file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "file.zip"
download.file(url, destination, method="curl") 
data <- read.table(unz(destination, "household_power_consumption.txt"), sep = ";", header=TRUE) 

## Convert date and time fields, create date time field
data <- cbind(datetime = paste(data$Date,data$Time),data)
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Subset data to only dates 1/2/2007 and 2/2/2007
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
df <- subset(data, data$Date == date1 | data$Date == date2)

## Converts last columns [ , 4:10] to numerics
for (i in 4:ncol(df)){
        df[,i] <- as.numeric(as.character(df[,i]))
}

## Create Plots

## Set parameters for 2x2 matrix
png(file = "plot4.png")
par(mfrow = c(2, 2))

## Plot 1, top left
plot(df$datetime, df$Global_active_power, type = "l", ylab = "Global Active Power", xlab= "")


## Plot 2, top right
with(df, plot(df$datetime, df$Voltage, type = "l", ylab = "Voltage", , xlab = "datetime"))

## Plot 3, bottom left
with(df, plot(df$datetime, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab= ""))
lines(df$datetime, df$Sub_metering_2, col = "red")
lines(df$datetime, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n", legend = colnames(df[,8:10]))

## Plot 4, bottom right
plot(df$datetime, df$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()