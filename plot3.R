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
png(filename ="plot3.png")

#3 line graphs of sub metering
with(Graph_Data,{
  plot(Sub_metering_1, type ="l", ylab = "Energy sub metering", xaxt = "n", xlab ="")
  axis(1, at=c(1,1440,2880), labels=c("Thu","Fri","Sat"))
  lines(Sub_metering_2, type = "l", col="red")
  lines(Sub_metering_3, type = "l", col="blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         cex = .9, lty=c(1,1,1),col=c("black","red","blue"))
})

#close device
dev.off()