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
png(filename="plot3.png", width=480, height=480)

##Graph the three Sub_metering columns and make some aesthetic choices.  Also create a legend.
with(febDays, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(febDays, lines(DateTime, Sub_metering_2, col="red"))
with(febDays, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", pch="", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Close the .png graphics device and be done!
dev.off()