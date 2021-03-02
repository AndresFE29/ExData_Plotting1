datos<-read.table("~/hpc.txt",sep=";",header=TRUE)
datos$Date<-as.Date(datos$Date,"%d/%m/%Y")
febrero<-subset(datos,Date>=as.Date("2007-2-1") & Date<=as.Date("2007-2-2"))
datoslimpios<-febrero[complete.cases(febrero), ]
dateTime <- paste(datoslimpios$Date, datoslimpios$Time)
dateTime <- setNames(dateTime, "DateTime")

d1 <- datoslimpios[ ,!(names(datoslimpios) %in% c("Date","Time"))]
d1 <- cbind(dateTime, d1)

d1$dateTime <- as.POSIXct(dateTime)
d1$dataTime<-weekdays.POSIXt(d1$dateTime)
plot(d1$dateTime,d1$Global_active_power,ylab = "Global Active Power (killowat)",type = "l")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()