datos<-read.table("~/hpc.txt",sep=";",header=TRUE)
datos$Date<-as.Date(datos$Date,"%d/%m/%Y")
febrero<-subset(datos,Date>=as.Date("2007-2-1") & Date<=as.Date("2007-2-2"))
datoslimpios<-febrero[complete.cases(febrero), ]
dateTime <- paste(datoslimpios$Date, datoslimpios$Time)
dateTime <- setNames(dateTime, "DateTime")

d1 <- datoslimpios[ ,!(names(datoslimpios) %in% c("Date","Time"))]
d1 <- cbind(dateTime, d1)

d1$dateTime <- as.POSIXct(dateTime)

d1$Sub_metering_1<-as.numeric(d1$Sub_metering_1)
d1$Sub_metering_2<-as.numeric(d1$Sub_metering_2)
d1$Sub_metering_3<-as.numeric(d1$Sub_metering_3)
plot(d1$dateTime,d1$Sub_metering_1, ylab = "Energy Sub metering", type = "l",xlab = "")
lines(d1$Sub_metering_2~d1$dateTime,col="red")
lines(d1$Sub_metering_3~d1$dateTime,col="blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()