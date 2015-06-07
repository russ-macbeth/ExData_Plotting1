## Plot 2 - script to replicate the first plot of the Exploratory Data Analysis Course
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

## Create Plot
png(file = "plot2.png")
plot(df$datetime, df$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab= "")
dev.off()