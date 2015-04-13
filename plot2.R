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
# Plot 2
# ---------------------
agp.idx<-!(data.sub[,"Global_active_power"]=="?")
sum(agp.idx)
dat.agp<-as.numeric(data.sub[agp.idx, "Global_active_power"])

plot(1:2880, dat.agp, type="l", xlab="", ylab="Active Global Power (kilowatts)", xaxt="n")
axis(1, labels = c("Thu", "Fri", "Sat"), at = c(0,1440,2880))
dev.copy(png, file = "plot2.png")
dev.off()

