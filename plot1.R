library(data.table)
raw.data <- fread("household_power_consumption.txt", sep = ";"
                  , header = T, na.strings = "?" 
                  , colClasses = 'character', data.table = F)
filter.data <- subset(raw.data, raw.data$Date =="1/2/2007"
                      | raw.data$Date == "2/2/2007")
hist(as.numeric(filter.data$Global_active_power), main = "Global Active Power"
              , xlab = "Global Active Power (kilowatts) ", col = "red")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()