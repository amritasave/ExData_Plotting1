## This code constructs 4 line graphs from the household power consumption data.
## The data between dates 1st Feb 2007 and 2nd Feb 2007 is taken into consideration
## for these plots.

##If sqldf package is not installed then remove the comment and run the code.

#install.packages("sqldf")
library(sqldf)

consumptionFile <- "household_power_consumption.txt"

## Using Select query to fetch the appropriate data
sqlDate <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Using read.csv to pull the data into the plot4Data Data frame
plot4Data <- read.csv.sql(consumptionFile, sql=sqlDate, sep=";")

## The date and time columns from the data frame are combined into one column.
## The DtTime column then is converted to POSIXlt
plot4Data$DtTime <-  strptime(paste(plot4Data$Date, plot4Data$Time) , format='%d/%m/%Y %H:%M:%S')

## Plots created in 2 rows and 2 columns.
par(mfcol = c(2,2))

## Plot 1 on the top row left side with Global Active Power data on Y axis and weekdays on the X axis.
plot(plot4Data$DtTime , plot4Data$Global_active_power, type="l" , xlab="", ylab="Global Active Power (kilowatts)" , main="")

## Plot 2 on the bottom row left side with 3 lines for the Sub metering data1 , Sub metering data2 
## Sub metering data 3 on Y axis and weekdays on the X axis
plot( plot4Data$DtTime  , plot4Data$Sub_metering_1, type="l" , xlab="", ylab="Energy sub metering" , main="")

points(plot4Data$DtTime , plot4Data$Sub_metering_2  , col = "red" , type="l")

points(plot4Data$DtTime , plot4Data$Sub_metering_3  , col = "blue" , type="l")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2" , "Sub_metering_3"), col = c("black" ,"red" ,"blue" ) , lty = c(1,1,1) ,cex=0.8 ,bty="n")

## Plot 3 on the top row right side with Voltage data on the Y axis and weekdays on the X axis
plot(plot4Data$DtTime , plot4Data$Voltage , type ="l" , xlab ="datetime" , ylab="Voltage" )

## Plot 4 on the bottom row right side with global reactive power data on the Y axis and weekdays on the X Axis.
plot(plot4Data$DtTime , plot4Data$Global_reactive_power , type ="l" , xlab ="datetime" , ylab="Global_reactive_power"  )


## Copy the plot on to a png file.
dev.copy(png, file = "plot4.png" , width = 480 , height =480) 
dev.off()
on.exit()

