library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreCity <- subset(NEI, fips=="24510")

typePM25byYr <- BaltimoreCity %>%
    group_by(year, type) %>%
    summarise(Emissions_Total = sum(Emissions))

png("plot3.png")

g <- qplot(year, Emissions_Total, data = typePM25byYr, color= type, geom = "line")
g <- g + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
    xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

plot(g)
dev.off()