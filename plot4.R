# Store the data using data.table. To read it quickly use fread
library(data.table)
# na.strings = "?" changes the ? to NA
# take the data names using header = T
# colClasses = 'character' makes all the variables into character vectors
raw.data <- fread("household_power_consumption.txt", sep = ";"
                  , header = T, na.strings = "?" 
                  , colClasses = 'character', data.table = F)
# take the data from date 1/2/2007 to 2/2/2007 
filter.data <- subset(raw.data, raw.data$Date =="1/2/2007"
                      | raw.data$Date == "2/2/2007")
# combine the date & time into one variable datetime
# change it to POSIXlt using as.POSIXlt
datetime  <- as.POSIXlt(paste(as.Date(filter.data$Date,format="%d/%m/%Y")
                              , filter.data$Time, sep=" "))
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))
# plot data and add the legend using points inside plot
with(filter.data, { 
      plot(datetime, Global_active_power, type = "l"
       , ylab = "Global Active Power (kilowatts) ", xlab = "")
      plot(datetime, Voltage, type = "l"
           , ylab = "Voltage") 
      with(filter.data, {
            plot(datetime, Sub_metering_1, type = "l"
                       , ylab = "Energy sub metering", xlab = "")
            points(datetime, Sub_metering_2, type = "l", col = "red")
            points(datetime, Sub_metering_3, type = "l", col = "blue")
            legend("topright", pch = "-", col = c("black", "blue", "red")
            , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
            , cex = 0.4)})
      plot(datetime, Global_reactive_power, type = "l"
      , ylab = "Global_reactive_power")}) 
# store the plot to device png, then close with dev.off()
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
