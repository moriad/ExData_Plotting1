setwd("./Coursera/Power_Consump")

#Retrieve first 70k rows of data
Data = read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows=70000, colClasses = "character")

# clean up data, set NAs, format Date as dd/mm/yyyy, format time as H:M:s
Data[Data=="?"]=NA
Data$Date = as.Date(Data$Date, format = "%d/%m/%Y")
Data$Time = strptime(Data$Time, format = "%H:%M:%S")

# take subset of data with correct dates
Graph_Data = subset(Data, Data$Date =="2007-02-01"|Data$Date =="2007-02-02", select =Date:Sub_metering_3)


#Change graph data to numeric
with(Graph_Data,{
  Global_active_power = as.numeric(Global_active_power)
  Global_reactive_power = as.numeric(Global_reactive_power)
  Voltage = as.numeric(Voltage)
  Sub_metering_1 = as.numeric(Sub_metering_1)
  Sub_metering_2 = as.numeric(Sub_metering_2)
  Sub_metering_3 = as.numeric(Sub_metering_3)
})


#create png
png(filename ="plot4.png")

#4 plots with a little bit of everything

par(mfrow=c(2,2))
with(Graph_Data,{
  plot(Global_active_power, type = "l" , ylab = "Global Active Power", xlab="", xaxt = "n")
    axis(1, at=c(1,1440,2880), labels = c("Thu","Fri","Sat"))
  plot(Voltage, type = "l" , ylab = "Voltage", xlab = "datetime", xaxt = "n")
    axis(1, at=c(1,1440,2880), labels = c("Thu","Fri","Sat"))
  plot(Sub_metering_1, type ="l", ylab = "Energy sub metering",xlab="", xaxt = "n")
    lines(Sub_metering_2, type = "l", col="red")
    lines(Sub_metering_3, type = "l", col="blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          bty = "n", cex = 0.9, lty=c(1,1,1),col=c("black","red","blue"))
    axis(1, at=c(1,1440,2880), labels = c("Thu","Fri","Sat"))
  plot(Global_reactive_power, type ="l",xaxt = "n", xlab="datetime")
    axis(1, at=c(1,1440,2880), labels = c("Thu","Fri","Sat"))
})

#close device
dev.off()