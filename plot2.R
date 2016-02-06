
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

# Subset of global active power between start date and end date
gac_subs <- subset(power_data$Global_active_power, 
                   power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Subset of global active power between start date and end date
timestamp_subs <- subset(power_data$timestamp, 
                        power_data$timestamp>=start_date & power_data$timestamp<=end_date)

# Plotting the subset of the Global_active_power we are interested in
png(filename="plot2.png", width=480, height=480)
plot(timestamp_subs, gac_subs, col = "black", type= "l", 
     xlab="", ylab="Global Active Power (kilowatts)", main=NULL)
dev.off()

