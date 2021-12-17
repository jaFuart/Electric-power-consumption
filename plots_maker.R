
# Loading data and making some preparations
currdir <- "./data"
if(!dir.exists("./data")) dir.create("./data")
setwd(currdir)

dburl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip <- "household power consumption.zip"
download.file(dburl, zip)

if(file.exists(zip)) unzip(zip)

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';',
                 nrows=2075259, na.strings="?", check.names=F, 
                 stringsAsFactors=FALSE, comment.char="", quote='\"')
data$Date <- as.Date(data$Date, format="%d/%m/%Y", tz="NY")

# Subset the data
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Converting date formats
datetime <- paste(as.Date(sub_data$Date), sub_data$Time)
sub_data$Datetime <- as.POSIXct(datetime)

# Generate 1-st plot
setwd("../")

png("plot1.png", width=480, height=480)
hist(sub_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", 
     col="Red")
dev.off()

# Generate 2-nd plot
png("plot2.png", width=480, height=480)
plot(sub_data$Global_active_power~sub_data$Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

# Generate 3-rd plot
png("plot3.png", width=480, height=480)
with(sub_data, {
  plot(Sub_metering_1~Datetime, 
       type="l", 
       ylab="Global Active Power (kilowatts)", 
       xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  })
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

# Generate 4-th plot
png("plot3.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(sub_data, {
  plot(Global_active_power~Datetime, 
       type="l", 
       ylab="Global Active Power (kilowatts)", 
       xlab="")
  plot(Voltage~Datetime, 
       type="l", 
       ylab="Voltage (volt)", 
       xlab="")
  plot(Sub_metering_1~Datetime, 
       type="l", 
       ylab="Global Active Power (kilowatts)", 
       xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, 
       type="l", 
       ylab="Global Rective Power (kilowatts)",
       xlab="")
  })
dev.off()