##Opens a connection to the data location.
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##Opens a connection to the data location.

##This will allow any user to process this file without changing their working directory.
workingdirectory <- getwd()
dest <- paste0(workingdirectory,"household_power_consumption.zip")
##Creates a combined file for the working directory and the file name. 

##Downloads the data file and places them in the working directory. Also, assigns a date for file download to aid version control.
#### - This section requires one setting change. 
	#### 1. method = ? "curl" applies to mac computers only. If this computer is not a mac, please change to method = "auto" and the same results will be generated.
download.file(fileUrl, destfile = dest, method = "curl")
dateDownloaded <- date()
##Downloads the data file and places them in a destination of the end users choosing. Also, assigns a date for file download to aid version control.

#### - This section requires one setting change. 
	#### 1. method = ? "curl" applies to mac computers only. If this computer is not a mac, please change to method = "auto" and the same results will be generated.

##Unzips the files.
unzip(dest, exdir = workingdirectory, unzip = "internal")
##Unzips the files.

##Read zipped files into R memory.
household <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
strip.white=TRUE, na.strings =c("?", "")) 
##Read zipped files into R memory.

##The package "dplyr" is necessary to complete this code. Please choose any CRAN mirror.
install.packages("dplyr")
library(dplyr)
##The package "dplyr" is necessary to complete this code. Please choose any CRAN mirror.

##Extract columns containing "01/02/2007" or "02/02/2007" and combines/converts the date and time from character to date/time format.
household_subset<- rbind(filter(household, (Date=="1/2/2007" | Date=="2/2/2007")))
household_date <- household_subset$Date
household_time <- household_subset$Time
date_time_paste <- paste(household_subset$Date, household_subset$Time, sep = " ")
date_time <- strptime(date_time_paste, format="%d/%m/%Y %H:%M:%S")
hhdata <- cbind(date_time, household_subset)
##Extract columns containing "01/02/2007" or "02/02/2007" and combines/converts the date and time from character to date/time format.
	
##Plot 4##
png(filename = "plot4.png",
    width = 480, height = 480)
	par(mfrow = c(2, 2))
	with(hhdata, plot(date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))	
	with(hhdata, plot(date_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))	
	with(hhdata, plot(date_time, Sub_metering_1, type = "l", xlab= "", ylab = "Energy sub metering"))
		with(hhdata, lines(date_time, Sub_metering_2, col = "red"))
		with(hhdata, lines(date_time, Sub_metering_3, col = "blue"))
		legend("topright", lty=1 , bty = "n",  col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	with(hhdata, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime"))		
	dev.off()
##Plot 4##

