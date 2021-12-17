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

# Generate 2-nd plot
png("plot2.png", width=480, height=480)
plot(sub_data$Global_active_power~sub_data$Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="datetime")
dev.off()