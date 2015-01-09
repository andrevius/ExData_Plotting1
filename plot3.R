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

png('plot3.png')

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



#dev.copy(png,file='plot3.png')
dev.off()
