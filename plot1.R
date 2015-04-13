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
head(data.sub)
tail(data.sub)

# ---------------------
# Plot 1
# ---------------------
agp.idx<-!(data.sub[,"Global_active_power"]=="?")
sum(agp.idx)
dat.agp<-as.numeric(data.sub[agp.idx, "Global_active_power"])

hist(dat.agp, col = "red", main= "Global Active Power", xlab="Active Global Power (kilowatts)")
dev.copy(png, file = "plot1.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
