# Read the data.
DF <- read.table('household_power_consumption.txt',header=T,sep=';',na.strings="?")

# Convert the Date column.
DF$Date <- as.Date(DF$Date,'%d/%m/%Y')

# Eliminate data before/after the specified range.
mask <- DF$Date >= as.Date('2007-02-01')
mask <- mask & ( DF$Date <= as.Date('2007-02-02'))
data <- DF[mask,]

png('plot1.png')
hist(data$Global_active_power,col='red',main="Global Active Power",xlab="Global Active Power (kilowatts)")

#dev.copy(png,file='plot1.png')
dev.off()

