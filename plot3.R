## plot3.R
# Read the data from household_power_consumption.txt
pwrData <- read.table("household_power_consumption.txt", header=TRUE, 
                      sep=";", na.strings=c("?", ""))
data <- tbl_df(pwrData)
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Filter for desired dates
data <- filter(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Create new Time column with POSIXlt class
data$timetemp <- paste(data$Date, data$Time)
data$Time <- strptime(data$timetemp, format = "%Y-%m-%d %H:%M:%S")

# Open png device and plot Energy Sub Metering vs Time
png(file = "plot3.png", width = 480, height = 480, units = "px")
with(data, plot(Time, Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab=""))
with(data, lines(Time, Sub_metering_2, col = "red"))
with(data, lines(Time, Sub_metering_3, col = "blue"))
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
dev.off()