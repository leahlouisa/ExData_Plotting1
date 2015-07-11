##Read in the necessary packages.
library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

##Read in the file where the data is stored.  
##An assumption is made that the file is saved in the working directory.
household_power_consumption <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")

##Select out the two dates in February that are of interest.
febDays <- filter(household_power_consumption, Date=="1/2/2007" | Date=="2/2/2007")

##Combine the date and time columns for ease of manipulation
febDays <- mutate(febDays, DateTime=paste(Date, Time, sep=" "))

##Convert the DateTime column to the POSIX format
febDays$DateTime <- strptime(febDays$DateTime, "%d/%m/%Y %H:%M:%S")

##Create a 480 x 480 .png file to which to save the graphic
png(filename="plot2.png", width=480, height=480)

##Create the graph itself and specify a label
with(febDays, plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)"))

##Close the .png graphics device and be done!
dev.off()
