datos<-read.table("~/hpc.txt",sep=";",header=TRUE)
datos$Date<-as.Date(datos$Date,"%d/%m/%Y")
febrero<-subset(datos,Date>=as.Date("2007-2-1") & Date<=as.Date("2007-2-2"))
datoslimpios<-febrero[complete.cases(febrero), ]
dateTime <- paste(datoslimpios$Date, datoslimpios$Time)
dateTime <- setNames(dateTime, "DateTime")

d1 <- datoslimpios[ ,!(names(datoslimpios) %in% c("Date","Time"))]
d1 <- cbind(dateTime, d1)

d1$dateTime <- as.POSIXct(dateTime)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(d1, {
  plot(d1$dateTime,d1$Global_active_power,ylab = "Global Active Power (killowat)",type = "l")
  plot(d1$dateTime,d1$Voltage,ylab = "Voltage (volt)",type = "l")
  plot(d1$dateTime,d1$Sub_metering_1, ylab = "Energy Sub metering", type = "l",xlab = "")
    lines(d1$Sub_metering_2~d1$dateTime,col="red")
    lines(d1$Sub_metering_3~d1$dateTime,col="blue")
    legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(d1$dateTime,d1$Global_reactive_power,ylab = "Global Reactive Power (killowatts",type = "l")
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()