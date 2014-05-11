#Read "household_power_consumption.txt" as Dataset
Dataset =
read.csv2("household_power_consumption.txt",dec = ".",
		header = TRUE, sep = ";",na.strings = "?")


#Check the structure of Dataset
str(Dataset)

#Check head and tail of Dataset
head(Dataset)
tail(Dataset)


#Change the class of Date from Factor to Date
Dataset$Date = as.Date(Dataset$Date,format="%d/%m/%Y")

#Check the structure of Dataset
str(Dataset)

#Combine Date and Time as datetime
Dataset$datetime = paste(Dataset$Date,Dataset$Time)

#Check the structure of Dataset
str(Dataset)

#Change the class of datetime from chracter to POSIXlt
Dataset$datetime = strptime(Dataset$datetime,
                          format="%Y-%m-%d%H:%M:%S")

#Check the structure of Dataset
str(Dataset)

#Check head and tail of columns 1,2 and 10 ofDataset

head(Dataset[,c(1,2,10)])
tail(Dataset[,c(1,2,10)])


#Save Dataset as household_power_consumption.Rdata
save(Dataset,file="household_power_consumption.Rdata")



#Extract data from the dates 2007-02-01 and 2007-02-02
# as Data1


Data1 = subset(Dataset,Date=="2007-02-01"|Date=="2007-02-02")

#Check the structure of Data1
str(Data1)


#Check head and tail of columns 1,2 and 10 ofData1
head(Data1[,c(1,2,10)])
tail(Data1[,c(1,2,10)])


##################
#Create Plot 4
##################

#Get English names as x axis
Sys.setlocale(locale = "C")


png(file="plot4.png",width = 480, height = 480)


par(mfcol=c(2,2))


with(Data1,{
    plot(datetime,Global_active_power,type="l",
    ylab="Global Active Power (kilowatts)",
    xlab="")

    plot(datetime,Sub_metering_1,type="l",col="black",
    ylab="Energy sub metering",xlab="")
    points(datetime,Sub_metering_2,type="l",col="red")
    points(datetime,Sub_metering_3,type="l",col="blue")
    legend("topright",
      c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
      lty = c(1,1,1),col=c("black","red","blue"),
      bty="n")#bty="n" => no border#

    plot(datetime,Voltage,type="l",
      ylab="Voltage",xlab="datetime")

    plot(datetime,Global_reactive_power,type="l",
      ylab="Global_reactive_power",xlab="datetime")
    }
    )

dev.off()
