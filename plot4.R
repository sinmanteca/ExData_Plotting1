plot4 <- function(){
    
    library(sqldf)
    
    ## open connection to text file and add lines in date range to data frame
    filePath <- "./data/household_power_consumption.txt"
    con <- file(filePath)
    data <- sqldf("SELECT * FROM con WHERE Date == '1/2/2007' OR Date == '2/2/2007'", 
                  file.format = list(header = TRUE, sep = ";"))
    close(con)
    
    ## combine data and time fields and convert to date/time format
    data$datetime <- strptime(paste(data$Date, data$Time), format="%e/%m/%Y %H:%M:%S")
    
    ## open device
    png(file = "plot4.png")
    
    ## set mfcol to put 4 plots on the screen
    par(mfcol = c(2,2))
    
    ## top-left plot:
    ## plot line graph and label axes
    with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
    
    ## bottom-left plot:
    ## plot empty graph and add lines for each variable and legend
    with(data, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
    with(data, lines(datetime, Sub_metering_1))
    with(data, lines(datetime, Sub_metering_2, col="red"))
    with(data, lines(datetime, Sub_metering_3, col="blue"))
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           bty = "n",
           lty = c(1, 1, 1),
           col = c("black", "red", "blue"))
    
    ## top-right plot:
    ## plot line graph and label axes
    with(data, plot(datetime, Voltage, type="l"))
    
    ## bottom-right plot:
    ## plot line graph
    with(data, plot(datetime, Global_reactive_power, type="l"))
    
    dev.off()
}