# Read the data.
DF <- read.table('household_power_consumption.txt',header=T,sep=';',na.strings="?")

# Convert the Date column.
DF$Date <- as.Date(DF$Date,'%d/%m/%Y')

# Eliminate data before/after the specified range.
mask <- DF$Date >= as.Date('2007-02-01')
mask <- mask & ( DF$Date <= as.Date('2007-02-02'))
data <- DF[mask,]

# Create a datetime column.
data$Datetime <- do.call(paste, data[,c('Date','Time')])
data$Datetime <- as.POSIXlt( data$Datetime, format='%Y-%m-%d %H:%M:%S')

#Create the line plot.

png('plot4.png')

par(mfrow=c(2,2))

# Upper left plot
x <- data$Datetime
y <- data$Global_active_power
plot(x,y,type='l',ylab='Global Active Power (kilowatts)')

# Upper right plot
x <- data$Datetime
y <- data$Voltage
plot(x,y,type='l',ylab='Voltage')

# Lower left plot
x = data$Datetime
y1 = data$Sub_metering_1
plot(x,y1,type='n',ylab='Energy sub metering')
lines(x,data$Sub_metering_1,col='black')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
lines(x,data$Sub_metering_2,col='red')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
lines(x,data$Sub_metering_3,col='blue')
legend('topright',
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty=1)

# Lower right plot
x <- data$Datetime
y <- data$Global_reactive_power
plot(x,y,type='l',ylab='Global_reactive_power')



dev.off()
