#Download Data from the internet into data directory
data_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("./data")) {dir.create("./data")}
download.file(data_URL, destfile = "./data/power_consumption_data.zip")
unzip("./data/power_consumption_data.zip", exdir = "./data/power_consumption_data")

#Define variables, read data, convert factor types to numeric
full_power_data<- read.csv2("./data/power_consumption_data/household_power_consumption.txt")
relevant_power_data <- subset(full_power_data, Date == "1/2/2007" | Date == "2/2/2007")
global_active_power <- as.numeric(as.character(relevant_power_data$Global_active_power))
global_reactive_power <- as.numeric(as.character(relevant_power_data$Global_reactive_power))
global_intensity <- as.numeric(as.character(relevant_power_data$Global_intensity))
voltage <- as.numeric(as.character(relevant_power_data$Voltage))
sub_meter1 <- as.numeric(as.character(relevant_power_data$Sub_metering_1))
sub_meter2 <- as.numeric(as.character(relevant_power_data$Sub_metering_2))
sub_meter3 <- as.numeric(as.character(relevant_power_data$Sub_metering_3))

#Convert to date time
date_time <- strptime(paste(relevant_power_data$Date, relevant_power_data$Time, sep= " "), 
                      "%d/%m/%Y %H:%M:%S") 
#Create plot
if(!file.exists("./data/plot3.png"))
{
  png("./data/plot3.png", width = 480, height = 480)
  plot(date_time, sub_meter1, type = "l", col = "black", xlab = "", 
       ylab = "Energy Sub Metering")
  lines(date_time, sub_meter2, type = "l", col = "red")
  lines(date_time, sub_meter3, type = "l", col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1, lwd = 1)
  dev.off()
}