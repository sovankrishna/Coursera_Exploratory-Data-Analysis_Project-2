library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggregate.data <- NEI %>%
    group_by(year) %>%
    summarise(Emissions_Total = sum(Emissions))

png("plot1.png")
plot(aggregate.data, type = "l", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the United States")
dev.off()
