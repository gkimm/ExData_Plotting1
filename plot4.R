rm(list=ls())

#Individual Household Power consumption data: HPCdata
directory<-"HPCdata"
unzip("exdata_data_household_power_consumption.zip", exdir = directory)

(file.list <- list.files(directory, full.names=TRUE))
#Inform Read function about classes of column data

data<-read.table(file.list[1], header = T, sep=";", stringsAsFactors=FALSE)
head(data)


#Format Date column
data[,"Date"]<-as.Date(data[,"Date"], format="%d/%m/%Y")
head(data)
tail(data)

#Subset data
start<-"2007-02-01"
end  <-"2007-02-02"
subset.cond<-data[,"Date"]>= start & data[,"Date"]<= end
data.sub<-subset(data, subset.cond)


# ---------------------
# Plot 4
# ---------------------
par(mfrow=c(2,2))
#plot 1
agp.idx<-!(data.sub[,"Global_active_power"]=="?")
sum(agp.idx)
dat.agp<-as.numeric(data.sub[agp.idx, "Global_active_power"])
plot(1:2880, dat.agp, type="l", xlab="", ylab="Active Global Power (kilowatts)", xaxt="n")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))
#plot 2
#Voltage
vol<-as.numeric(data.sub[,"Voltage"])
plot(1:2880, vol, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))

#plot 3
sub1<-as.numeric(data.sub[, "Sub_metering_1"])
sub2<-as.numeric(data.sub[, "Sub_metering_2"])
sub3<-as.numeric(data.sub[, "Sub_metering_3"])
plot(1:2880, sub1, type="l", xlab="", ylab="Energy Sub metering", xaxt="n")
lines(sub2, col="red")
lines(sub3, col="blue")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))

#Plot 4

#Global_reactive_power
grp<-as.numeric(data.sub[,"Global_reactive_power"])
plot(1:2880, grp, type="l", xlab="datetime", ylab="Global_reactive_power", xaxt="n")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))

dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!

par(mfrow=c(1,1))
