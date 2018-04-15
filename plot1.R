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


#constructing plot1
png(filename = "plot1.png",width = 480, height = 480)
hist(hh_power_consumption$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
