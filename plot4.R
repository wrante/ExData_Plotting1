## plot4.R
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

# Open png device and make 4 plots in 2 x 2 grid
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(data, {
    # plot 1, top left, Global Active Power vs Time
    plot(Time, Global_active_power, type = "l", xlab = "", 
         ylab = "Global Active Power")
    # plot 2, top right, Voltage vs Time
    plot(Time, Voltage, type = "l", xlab = "")
    # plot 3, bottom left, Energy Sub Meeting vs Time
    plot(Time, Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab="")
    lines(Time, Sub_metering_2, col = "red")
    lines(Time, Sub_metering_3, col = "blue")
    legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), cex=.75, bty = "n")
    # plot 4, bottom right, Global Reactive Power vs Time
    plot(Time, Global_reactive_power, type = "l", xlab = "", 
         ylab = "Global Reactive Power")
})
dev.off()