
# First, listing files in working directory and adding them to a vector
myfiles <- list.files()

# Unzipped file name not in directory, unzip the file
if(is.element("household_power_consumption.txt", myfiles)!=TRUE){
    unzip("exdata-data-household_power_consumption.zip")
}

# Loading the data into a dataframe
power_data <- read.table("household_power_consumption.txt", 
                         header = TRUE, sep = ";", na.strings = "?")

# Printing head of the dataframe
print(head(power_data))

# Changing the class type of Date and Time columns to 
# paste the strings together for the timestamp below
power_data$Date <- as.character(power_data$Date)
power_data$Time <- as.character(power_data$Time)

# Adding a new column to the power_data dataframe with the
# timestamp. This is down by pasting the strings in the 
# Date and Time columns together in the format shown below.
power_data$timestamp <- as.POSIXct(paste(power_data$Date,power_data$Time, sep=" "),
                                   format="%d/%m/%Y %H:%M:%S")

# Defining the start and end dates for subsetting the date
start_date <- as.POSIXct("01/02/2007 00:00:00", 
                         format="%d/%m/%Y %H:%M:%S")
end_date <- as.POSIXct("02/02/2007 23:59:59", 
                       format="%d/%m/%Y %H:%M:%S")

# Subset of timestamp between start date and end date
timestamp_subs <- subset(power_data$timestamp, 
                         power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Subset of global active power between start date and end date
gac_subs <- subset(power_data$Global_active_power, 
                   power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Subset of Sub_metering_1, Sub_metering_2, and
# Sub_metering_3 between start date and end date
subs_met_1 <- subset(power_data$Sub_metering_1, 
                     power_data$timestamp>=start_date & power_data$timestamp<=end_date)
subs_met_2 <- subset(power_data$Sub_metering_2, 
                     power_data$timestamp>=start_date & power_data$timestamp<=end_date)
subs_met_3 <- subset(power_data$Sub_metering_3, 
                     power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Subset of Voltage between start date and end date
volt_subs <- subset(power_data$Voltage, 
                   power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Subset of Global_reactive_power between start date and end date
grc_subs <- subset(power_data$Global_reactive_power, 
                    power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Making plot with 2 rows and 2 columns
png(filename="plot4.png", width=480, height=480)

par(mfcol=c(2,2))

plot(timestamp_subs, gac_subs, col = "black", type= "l", 
     xlab="", ylab="Global Active Power", main="")

plot(timestamp_subs, subs_met_1, col = "black", type= "l", 
     xlab="", ylab="Energy sub metering", main="")
lines(timestamp_subs, subs_met_2,col="red")
lines(timestamp_subs, subs_met_3,col="blue")
legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red","blue"), bty = "n" )

plot(timestamp_subs, volt_subs, col = "black", type= "l", 
     xlab="datetime", ylab="Voltage", main="")

plot(timestamp_subs, grc_subs, col = "black", type= "l", 
     xlab="datetime", ylab="Global_reactive_power", main="")

dev.off()

