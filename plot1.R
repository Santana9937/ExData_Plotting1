
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

# Formating the date columns into Date format
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Defining the start and end dates for subsetting the date
start_date <- as.Date("01/02/2007", format="%d/%m/%Y")
end_date <- as.Date("02/02/2007", format="%d/%m/%Y")

# Subset of global active power between start date and end date
gac_subs <- subset(power_data$Global_active_power, 
                   power_data$Date>=start_date & power_data$Date<=end_date)

# Plotting the subset of the Global_active_power we are interested in as
# a histogram and saving the plot to a png file
png(filename="plot1.png", width=480, height=480)
hist(gac_subs, col = "red", 
     xlab=NULL, ylab=NULL,main=NULL)
title(xlab = "Global Active Power (kilowatts)",
      ylab = "Frequency",
      main = "Global Active Power")
dev.off()

