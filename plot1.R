unzip_kwh <- unzip("exdata-data-household_power_consumption.zip")

# load required packages 
library(dplyr)
library(tidyr)
library(data.table)

# read file 
kwh <- fread("household_power_consumption.txt", na.strings = c("?",""), 
colClasses = "character", data.table = TRUE)

# change Date column from "chr" to "date"
kwh$Date <- as.Date(kwh$Date,"%d/%m/%Y") 
kwh <- subset(kwh, Date>="2007/02/01" & Date<="2007/02/02")
# total 2880 observations for 2 days

# Take data for plot 1
x <- as.numeric(kwh$Global_active_power)

# create .png file
png("plot1.png")
# move the plot into png file
hist(x, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
