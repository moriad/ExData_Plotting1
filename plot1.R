setwd("./Coursera/Power_Consump")

#Retrieve first 70k rows of data
Data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows=70000, colClasses = "character")

# clean up data, set NAs, format Date as dd/mm/yyyy, format time as H:M:s
Data[Data=="?"]=NA
Data$Date = as.Date(Data$Date, format = "%d/%m/%Y")
Data$Time = strptime(Data$Time, format = "%H:%M:%S")

# take subset of data with correct dates
Graph_Data = subset(Data, Data$Date =="2007-02-01"|Data$Date =="2007-02-02", select =Date:Sub_metering_3)

#set graph values to numeric
Graph_Data$Global_active_power = as.numeric(Graph_Data$Global_active_power)

#create png
png(filename ="plot1.png")

#red histograph
with(Graph_Data, hist(Global_active_power,col = "red", main = "Global Active Power", 
                      xlab = "Global Active Power (kilowatts)"))
#close device
dev.off()