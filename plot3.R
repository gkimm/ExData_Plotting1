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
# Plot 3
# ---------------------
sub1<-as.numeric(data.sub[, "Sub_metering_1"])
sub2<-as.numeric(data.sub[, "Sub_metering_2"])
sub3<-as.numeric(data.sub[, "Sub_metering_3"])

plot(1:2880, sub1, type="l", xlab="", ylab="Energy Sub metering", xaxt="n")
lines(sub2, col="red")
lines(sub3, col="blue")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))
legend("topright", lty = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device
