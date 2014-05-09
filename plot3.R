## This code constructs a line graph from the household power consumption data.
## The data between dates 1st Feb 2007 and 2nd Feb 2007 is taken into consideration
## for this plot.
## The Y axis contains the Energy Sub metering figures and X axis and the weekdays
## like Thu ,Fri and Sat


##If sqldf package is not installed then remove the comment and run the code.

#install.packages("sqldf")
library(sqldf)

consumptionFile <- "household_power_consumption.txt"

## Using Select query to fetch the appropriate data
sqlDate <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Using read.csv to pull the data into the plot3Data Data frame
plot3Data <- read.csv.sql(consumptionFile, sql=sqlDate, sep=";")

## The date and time columns from the data frame are combined into one column.
## The DtTime column then is converted to POSIXlt.
plot3Data$DtTime <-  strptime(paste(plot3Data$Date, plot3Data$Time) , format='%d/%m/%Y %H:%M:%S')

## Constructing the line graph with Sub metering 1 data
plot( plot3Data$DtTime  , plot3Data$Sub_metering_1, type="l" , xlab="", ylab="Energy sub metering" , main="")

## Adding a line for Sub metering 2 data in the graph
points(plot3Data$DtTime , plot3Data$Sub_metering_2  , col = "red" , type="l")

## Adding a line for Sub metering 3 data in the graph
points(plot3Data$DtTime , plot3Data$Sub_metering_3  , col = "blue" , type="l")

## Adding legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2" , "Sub_metering_3"), col = c("black" ,"red" ,"blue" ) , lty = c(1,1,1) )

## Copy the plot on to a png file.
dev.copy(png, file = "plot3.png" , width = 480 , height =480) 
dev.off()

on.exit()
