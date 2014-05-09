## This code constructs a histogram from the household power consumption data.
## The data between dates 1st Feb 2007 and 2nd Feb 2007 is taken into consideration
## for this plot.
## The X axis contains the Global Active Power figures.


##If sqldf package is not installed then remove the comment and run the code.

#install.packages("sqldf") 
library(sqldf)

consumptionFile <- "household_power_consumption.txt"

## Using Select query to fetch the appropriate data
sqlDate <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

## Using read.csv to pull the data into the plot1Data Data frame
plot1Data <- read.csv.sql(consumptionFile, sql=sqlDate, sep=";")

## Constructing histogram. 
hist(plot1Data$Global_active_power , main= "Global Active Power",col= "red",  xlab="Global Active Power(kilowatts)")

## Copy the plot on to a png file.
dev.copy(png, file = "plot1.png" , width = 480 , height =480) 
dev.off()

on.exit()
