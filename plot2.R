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
plot(datetime, filter.data$Global_active_power, type = "l"
                  , ylab = "Global Active Power (kilowatts)", xlab = "") 
# store the plot to device png, then close with dev.off()
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()