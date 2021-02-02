## Script to explore R Base Graphing Package as part of Cousera JHU Data Science Course
## This is Project 2 of Course 4 - Exploratory Data Analysis, this produces plot 5 of 6 a histogram of PM2.5 particle emissions in the Baltimore from vehicles
# by C. Bleile

# Outline:
# 1. Set environment
# 2. Import R Data Set to NEI from "summarySCC_PM25.rds" and SCC from "Source_Classification_Code.rds" both from "exdata_data_NEI_data.zip"
# 3. Subset the data
# 4. Output the plot

# 1. Set environment, you can make the working directory anything that works for you, just make sure the .rds files are there.
setwd("~") #Set the working directory to the user's home directory; NOTE: unzipped, downloaded data should be here.
library(ggplot2)

# 2. Import data.table from "household_power_consumption.txt"
NEI <- readRDS("~/summarySCC_PM25.rds")
SCC <- readRDS("~/Source_Classification_Code.rds")

# 3. Subset the data for just Baltimore
BaltNEI <- subset(NEI, fips == "24510")
vehSCC <- subset(SCC, Data.Category == "Onroad")
vehSCClist <- vehSCC$SCC #Create a vector of valid SCC codes to match to for the NEI database.
BaltVehNEI <- subset(BaltNEI, BaltNEI$SCC %in% vehSCClist)  #subset the table for Baltimore Vehicle Emissions

# 4. Output the plot
png("plot5.png", width=960, height=960) #sets output device to plot5.png located in the working directory

ggplot(BaltVehNEI, aes(factor(year), Emissions)) +
    geom_bar(stat="identity") +
    labs(title=expression("Baltimore Vehicle PM2.5 Emissions by Year")) +
    labs(x="Year", y=expression("PM2.5 Emissions in tons"))

dev.off() #closes the png output device


