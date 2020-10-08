library(tidyverse) #R-For Data  Science, Hadley Wickham and Garrett Grolemund
library(lubridate)

#Se cargan los datos que estan en directorio de trabajo
hhpc <- read.table("./household_power_consumption.txt",sep = ";",header = TRUE)

#Se convierte a tibble para que trabaje mas rapido
hhpc_tibble <- as_tibble(hhpc)


hhpc_tibble$Date <- dmy(hhpc_tibble$Date) #Convetir a fecha

hhpc_tibble$Time <- hms(hhpc_tibble$Time ) #Convertir a tiempo

#Filtro de las fechas del 2007-02-01 al 2007-02-03
data_eval <- filter(hhpc_tibble,Date >= as.Date("2007-02-01"), 
                    Date <= as.Date("2007-02-02"))

rm(hhpc,hhpc_tibble) #Eliminamos las variables que ya no se utilzan

#Convertimos a formato numerico las columnas
data_eval$Global_active_power <- as.numeric(as.character(
    data_eval$Global_active_power))
data_eval$Global_reactive_power <- as.numeric(as.character(
    data_eval$Global_reactive_power))
data_eval$Global_intensity <- as.numeric(as.character(
    data_eval$Global_intensity))
data_eval$Sub_metering_1 <- as.numeric(as.character(
    data_eval$Sub_metering_1))
data_eval$Voltage <- as.numeric(as.character(
    data_eval$Voltage))
data_eval$Sub_metering_2 <- as.numeric(as.character(
    data_eval$Sub_metering_2))

#Agragar campos Date_time
data_eval <- mutate(data_eval,Date_time=Date+Time)


#Generar plot1
par(mfrow=c(2,2))

plot(data_eval$Date_time,data_eval$Global_active_power,type="n",
     ylab="Global Active Power Kilowatts",xlab="")
lines( data_eval$Date_time,data_eval$Global_active_power,
       lwd = 0.7,
       lty = 1,
       pch = 1 )
#Generar plot2
plot(data_eval$Date_time,data_eval$Voltage,type="n",
     ylab="Voltaje",xlab="datatime")
lines( data_eval$Date_time,data_eval$Voltage,
       lwd = 0.7,
       lty = 1,
       pch = 1 )
#Generar plot3

plot(data_eval$Date_time,data_eval$Sub_metering_1,type="n",xlab="",
     ylab="Energy Submetering")

lines(data_eval$Date_time,data_eval$Sub_metering_1,col="black")
lines(data_eval$Date_time,data_eval$Sub_metering_2,col="red")
lines(data_eval$Date_time,data_eval$Sub_metering_3,col="blue")
legend("topright", col = c("black", "red","blue"), 
       legend = c("Sub_metering1", "Sub_metering2","Sub_metering3"),
       lwd = 2.5)

#Generar plot4
plot(data_eval$Date_time,data_eval$Global_reactive_power,type="n",
     ylab="Global Reactive Power Kilowatts",xlab="datatime")
lines( data_eval$Date_time,data_eval$Global_reactive_power,
       lwd = 0.7,
       lty = 1,
       pch = 1 )


dev.copy(png,file="plot4.png")
dev.off()
