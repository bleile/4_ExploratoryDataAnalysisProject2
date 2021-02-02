## Script to explore R Base Graphing Package as part of Cousera JHU Data Science Course
## This is Project 2 of Course 4 - Exploratory Data Analysis, this produces plot 2 of 6 a histogram of PM2.5 particle emissions in the US from 1999-2008
## by C. Bleile

# Outline:
# 1. Set environment
# 2. Import R Data Set to NEI from "summarySCC_PM25.rds" and SCC from "Source_Classification_Code.rds" both from "exdata_data_NEI_data.zip"
# 3. Subset the data
# 4. Output the plot

# 1. Set environment, you can make the working directory anything that works for you, just make sure the .rds files are there.
setwd("~") #Set the working directory to the user's home directory; NOTE: unzipped, downloaded data should be here.

# 2. Import data.table from "household_power_consumption.txt"
NEI <- readRDS("~/summarySCC_PM25.rds")
SCC <- readRDS("~/Source_Classification_Code.rds")

# 3. Subset the data for just Baltimore
BaltNEI <- subset(NEI, fips == "24510")

# 4. Output the plot
png("plot2.png", width=480, height=480) #sets output device to plot2.png located in the working directory
barplot(tapply(BaltNEI$Emissions/1000, format(BaltNEI$year), FUN=sum))
title(main="Baltimore PM2.5 Emissions in Kilotons by Year", ylab="Kilotons of PM2.5 per Year")
dev.off() #closes the png output device

