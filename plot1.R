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
# change the required variables to numeric using as.numeric
hist(as.numeric(filter.data$Global_active_power), main = "Global Active Power"
              , xlab = "Global Active Power (kilowatts) ", col = "red")
# store the plot to device png, then close with dev.off()
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
