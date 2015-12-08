plot1 <- function(){
    
    library(sqldf)
    
    ## open connection to text file and add lines in date range to data frame
    filePath <- "./data/household_power_consumption.txt"
    con <- file(filePath)
    data <- sqldf("SELECT * FROM con WHERE Date == '1/2/2007' OR Date == '2/2/2007'", 
                  file.format = list(header = TRUE, sep = ";"))
    close(con)
    
    ## open png device
    png(file = "plot1.png")
    
    ## draw histogram, change format, and label axes and title
    hist(data$Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")

    ## close png device
    dev.off()
}