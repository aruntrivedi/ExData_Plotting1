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
png("plot2.png")
# move the plot into png file
plot(datacopy$Time, datacopy$Global_active_power, type = "s", xlab = "",ylab = "Global Active Power (kilowatts)")
dev.off()
