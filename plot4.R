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
png(filename="plot4.png", width=480, height=480)

##Create and align the 4 plots
par(mfrow = c(2, 2))
with(febDays, {
    plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", main="", xlab="datetime", ylab="Voltage")
    plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", pch="", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
    plot(DateTime, Global_reactive_power, type="l", main="", xlab="datetime")
})

##Close the .png graphics device and be done!
dev.off()