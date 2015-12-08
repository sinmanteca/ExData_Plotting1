plot3 <- function(){
    
    library(sqldf)
    
    ## open connection to text file and add lines in date range to data frame
    filePath <- "./data/household_power_consumption.txt"
    con <- file(filePath)
    data <- sqldf("SELECT * FROM con WHERE Date == '1/2/2007' OR Date == '2/2/2007'", 
                  file.format = list(header = TRUE, sep = ";"))
    close(con)
    
    ## combine data and time fields and convert to date/time format
    data$datetime <- strptime(paste(data$Date, data$Time), format="%e/%m/%Y %H:%M:%S")
    
    ## open png device
    png(file = "plot3.png")
    
    ## plot empty graph and add lines for each variable and legend
    with(data, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
    with(data, lines(datetime, Sub_metering_1))
    with(data, lines(datetime, Sub_metering_2, col="red"))
    with(data, lines(datetime, Sub_metering_3, col="blue"))
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = c(1, 1, 1),
           col = c("black", "red", "blue"))
    
    ## close png device
    dev.off()
}