library(tidyverse) #R-For Data  Science, Hadley Wickham and Garrett Grolemund
library(lubridate)

#Se cargan los datos que estan en directorio de trabajo
hhpc <- read.table("./household_power_consumption.txt",sep = ";",header = TRUE)
#str(hhpc)

#Se convierte a tibble para que trabaje mas rapido
hhpc_tibble <- as_tibble(hhpc)
#str(hhpc_tibble)


hhpc_tibble$Date <- dmy(hhpc_tibble$Date) #Convetir a fecha
str(hhpc_tibble)
hhpc_tibble$Time <- hms(hhpc_tibble$Time ) #Convertir a tiempo

#Filtro de las fechas del 2007-02-01 al 2007-02-03
data_eval <- filter(hhpc_tibble,Date >= as.Date("2007-02-01"), 
                        Date <= as.Date("2007-02-02"))
#str(data_eval)
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

#Generar histograma
hist(data_eval$Global_active_power,col="red",
     xlab="Global Active Power (Kilowatt)",main = "GLOBAL ACTIVE POWER")
dev.copy(png,file="plot1.png")
dev.off()
