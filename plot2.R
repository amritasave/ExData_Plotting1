## This code constructs a line graph from the household power consumption data.
## The data between dates 1st Feb 2007 and 2nd Feb 2007 is taken into consideration
## for this plot.
## The Y axis contains the Global Active Power figures and X axis and the weekdays
## like Thu ,Fri and Sat


##If sqldf package is not installed then remove the comment and run the code.


#install.packages("sqldf")
library(sqldf)

consumptionFile <- "household_power_consumption.txt"

## Using Select query to fetch the appropriate data
sqlDate <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Using read.csv to pull the data into the plot2Data Data frame
plot2Data <- read.csv.sql(consumptionFile, sql=sqlDate, sep=";")

## The date and time columns from the data frame are combined into one column.
## The DtTime column then is converted to POSIXlt.
plot2Data$DtTime <-  strptime(paste(plot2Data$Date, plot2Data$Time) , format='%d/%m/%Y %H:%M:%S')

## Constructing the line graph 
plot(plot2Data$DtTime , plot2Data$Global_active_power, type="l" , xlab="", ylab="Global Active Power (kilowatts)" , main="")

## Copy the plot on to a png file.
dev.copy(png, file = "plot2.png" , width = 480 , height =480) 
dev.off()

on.exit()
