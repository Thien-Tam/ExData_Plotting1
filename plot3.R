#--------------------------------------------------------------------\
# Thien-Tam TRAN                                                     |
# Coursera "Data Science" Specialization - Exploratory Data Analysis |
# May 2014 Session                                                   |
# Course Project 1 - plot3.R                                         |
#--------------------------------------------------------------------/



# The "read_data" function reads household power consumption data
# from the course project file and returns a data frame containing the data
# from February 1, 2007 and February 2, 2007.
# It is replicated in each "plotX.R" file in order to meet the self-contained
# read data code in order to fully reproduce the plot.
# The unzipped file containing the data set is assumed to be in the
# current working directory.

read_data <- function(filename = "household_power_consumption.txt") {
	data <- read.table("household_power_consumption.txt", sep = ";", header = T, colClasses = "character")
	data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]

	data$date.time <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

	data$Global_active_power <- as.numeric(data$Global_active_power)
	data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
	data$Voltage <- as.numeric(data$Voltage)
	data$Global_intensity <- as.numeric(data$Global_intensity)
	data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
	data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
	data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

	return(data) 
}



# The function draw_plot3 creates "plot3.png" for this project.
# The image file will be created in the current working directory.
# NB: the dates are shown with French locale ie. "jeu.", "ven." & "sam."
#     instead of "Thu", "Fri" & "Sat"

draw_plot3 <- function() {
	data <- read_data()

	plot3.dev <- png(filename = "plot3.png", width = 480, height = 480)
	with(data, {
		plot(date.time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
		lines(date.time, Sub_metering_1, col = "black")
		lines(date.time, Sub_metering_2, col = "red")
		lines(date.time, Sub_metering_3, col = "blue")
		legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	})
	dev.off()
}