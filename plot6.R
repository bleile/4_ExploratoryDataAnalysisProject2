## Script to explore R Base Graphing Package as part of Cousera JHU Data Science Course
## This is Project 2 of Course 4 - Exploratory Data Analysis, this produces plot 6 of 6 a histogram of PM2.5 particle emissions comparing Batlimore and LA vehicle emissions
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

# 3. Subset the data
# a. subset for vehicle emissions
vehSCC <- subset(SCC, Data.Category == "Onroad")
vehSCClist <- vehSCC$SCC #Create a vector of valid SCC codes to match to for the NEI database.

# b. subset for Baltimore
BaltNEI <- subset(NEI, fips == "24510")
BaltNEI$Place <- "Baltimore"
BaltVehNEI <- subset(BaltNEI, BaltNEI$SCC %in% vehSCClist)  #subset the table for Baltimore Vehicle Emissions

# c. subset for LA
LANEI <- subset(NEI, fips == "06037")
LANEI$Place <- "LA"
LAVehNEI <- subset(LANEI, LANEI$SCC %in% vehSCClist)  #subset the table for LA Vehicle Emissions

# d. bind the two cities into a single dataset
BaLAVehNEI <- rbind(BaltVehNEI, LAVehNEI)

# 4. Output the plot
png("plot6.png", width=960, height=960) #sets output device to plot6.png located in the working directory

ggplot(BaLAVehNEI, aes(x=factor(year), y=Emissions, fill=Place)) +
    geom_bar(aes(fill=year), stat="identity") +
    facet_grid(scales="free", space="free", .~Place) +
    guides(fill=FALSE) +
    labs(title=expression("Baltimore and LA PM2.5 Motor Vehicle Emissions by Year")) +
    labs(x="Year", y=expression("Total PM2.5 Emission in tons)"))

dev.off() #closes the png output device


