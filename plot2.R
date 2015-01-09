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


png('plot2.png')

#Create the line plot.
x <- data$Datetime
y <- data$Global_active_power
plot(x,y,type='l',ylab='Global Active Power (kilowatts)')


#dev.copy(png,file='plot2.png')
dev.off()
