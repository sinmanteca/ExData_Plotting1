plot2 <- function(){
    
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
    png(file = "plot2.png")
    
    ## plot line graph and label axes
    with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

    ## close png device
    dev.off()
}