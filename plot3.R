unzip_kwh <- unzip("exdata-data-household_power_consumption.zip")

# load required packages 
library(dplyr)
library(tidyr)
library(data.table)

# read unzipped file 
kwh <- fread("household_power_consumption.txt", stringsAsFactors = TRUE, header = TRUE, sep = ";", na.strings = c("?",""))

# change Date column from "chr" to "date"
kwh$Date <- as.Date(kwh$Date,"%d/%m/%Y")

kwh <- subset(kwh, Date>="2007/02/01" & Date<="2007/02/02")
# total 2880 observations for 2 days
kwh$timetemp <- paste(kwh$Date, kwh$Time)
datacopy <- as.data.frame(kwh)
datacopy$Time <- strptime(datacopy$timetemp, format = "%Y-%m-%d %H:%M:%S")

# create .png file
png("plot3.png")
# move the plot into png file
plot(datacopy$Time, datacopy$Sub_metering_1, type = "s", xlab = "",ylab = "Energy Sub Metering")
lines(datacopy$Time, datacopy$Sub_metering_2, type = "s", xlab = "",ylab = "Energy Sub Metering", col = "red")
lines(datacopy$Time, datacopy$Sub_metering_3, type = "s", xlab = "",ylab = "Energy Sub Metering", col = "blue")
legend("topright", lty = 1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
