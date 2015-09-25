library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreCity <- subset(NEI, fips == "24510")

aggregate.24510 <- BaltimoreCity %>%
    group_by(year) %>%
    summarise(Emissions_Total= sum(Emissions))
png("plot2.png")
plot(aggregate.24510, type = "l", 
     ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", 
     main = "Total Emissions for Baltimore County", xlim = c(1999, 2008))
dev.off()
