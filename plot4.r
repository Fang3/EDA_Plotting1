hpc <- read.table('household_power_consumption.txt',sep = ';',header = TRUE)
head(hpc)
#table(hpc$Date)
hpc_subset <- subset(hpc,Date %in% c('1/2/2007','2/2/2007'))
sapply(hpc_subset,class)
hpc_subset$Global_active_power <- as.numeric(as.character(hpc_subset$Global_active_power))
hpc_subset$dt <- strptime(paste(hpc_subset$Date, hpc_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
hpc_subset$Sub_metering_1 <- as.numeric(as.character(hpc_subset$Sub_metering_1))
hpc_subset$Sub_metering_2 <- as.numeric(as.character(hpc_subset$Sub_metering_2))
hpc_subset$Voltage <- as.numeric(as.character(hpc_subset$Voltage))
hpc_subset$Global_reactive_power <- as.numeric(as.character(hpc_subset$Global_reactive_power))

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(hpc_subset,plot(dt,Global_active_power,type='l',xlab='',ylab='Global Active Power (kilowatts)'))
with(hpc_subset,plot(dt,Voltage,type='l',xlab='datetime',ylab='Voltage'))
with(hpc_subset,plot(dt,Sub_metering_1,type='l',xlab='',ylab='Energy sub metering'))
lines(hpc_subset$dt,hpc_subset$Sub_metering_2,col='red')
lines(hpc_subset$dt,hpc_subset$Sub_metering_3,col='blue')
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1,bty='n',col=c("black", "red", "blue"))
with(hpc_subset,plot(dt,Global_reactive_power,type='l',xlab='datetime',ylab='Global_reactive_power'))
dev.off()
