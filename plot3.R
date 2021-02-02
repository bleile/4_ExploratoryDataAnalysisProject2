## Script to explore R Base Graphing Package as part of Cousera JHU Data Science Course
## This is Project 2 of Course 4 - Exploratory Data Analysis, this produces plot 3 of 6 a histogram of PM2.5 particle emissions in the Baltimore by type from 1999-2008
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
BaltNEI <- subset(NEI, fips == "24510")

# 4. Output the plot
png("plot3.png", width=960, height=960) #sets output device to plot3.png located in the working directory

ggplot(BaltNEI, aes(factor(year), Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(.~type, scales = "free", space="free") +
    labs(title=expression("Baltimore PM2.5 Emissions by Year and Type")) +
    labs(x="Year", y=expression("PM2.5 Emissions in tons"))

dev.off() #closes the png output device


