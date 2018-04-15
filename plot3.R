library(data.table)
library(lubridate)
library(dplyr)

#downloading the dataset from the uci website
dataset <- tempfile()
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip",dataset)
hh_power_consumption <- fread(unzip(dataset, files = "household_power_consumption.txt"),sep=";")

#changing the date to lubridate format
hh_power_consumption$Date <-lubridate::dmy(hh_power_consumption$Date)

#filtering for 2 days
hh_power_consumption <- hh_power_consumption %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#changing the data type of columns 3 to 9 to numeric
hh_power_consumption[,c(3:9)]<-sapply(hh_power_consumption[,c(3:9)],as.numeric)

#constructing plot3

png(filename = "plot3.png",width = 480, height = 480)
with(hh_power_consumption,plot(Sub_metering_1,pch=NA,xaxt='n',xlab=" ",ylab="Energy Sub Metering"))
lines(hh_power_consumption$Sub_metering_1)
lines(hh_power_consumption$Sub_metering_2,col="red")
lines(hh_power_consumption$Sub_metering_3,col="blue")
axis(side=1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"),xpd=TRUE) 
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red", "blue"), lty=1,lwd=2)
dev.off()