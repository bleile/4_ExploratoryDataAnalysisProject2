## Script to explore R Base Graphing Package as part of Cousera JHU Data Science Course
## This is Project 2 of Course 4 - Exploratory Data Analysis, this produces plot 4 of 6 a histogram of PM2.5 particle emissions in the Baltimore by type from 1999-2008
## by C. Bleile

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
coalSCCidx <- grep("coal", SCC$EI.Sector, ignore.case=TRUE) #Create subset index for SCC where EI.Sector = Coal Combustion, does not count Lignite
coalSCC <- SCC$SCC[coalSCCidx] #Create a vector of valid SCC codes to match to for the NEI database.
coalNEI <- subset(NEI, NEI$SCC %in% coalSCC)  #subset the table for coal combustion (where the NEI$SCC matches a value in the list of valid SCC codes)

# 4. Output the plot
png("plot4.png", width=960, height=960) #sets output device to plot4.png located in the working directory

ggplot(coalNEI, aes(factor(year), Emissions/1000)) +
    geom_bar(stat="identity") +
    labs(title=expression("US Coal Combustion PM2.5 Emissions by Year")) +
    labs(x="Year", y=expression("PM2.5 Emissions in Kilotons"))

dev.off() #closes the png output device


