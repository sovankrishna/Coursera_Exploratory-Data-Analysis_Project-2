library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.sub <- SCC[grepl("Coal", SCC$Short.Name),]
NEI.sub <- NEI[NEI$SCC %in% SCC.sub$SCC, ]

aggregate.data4 <- NEI.sub %>%
    group_by(year) %>%
    summarise(Emissions_Total = sum(Emissions)/1000)

aggregate.data4

png("plot4.png")

g <- qplot(year, Emissions_Total, data = aggregate.data4)
g <- g + ggtitle(" Coal Combustion source emissions across US from 1998-2008")+ xlab("Year") + ylab("Total PM2.5 Emission (1000 tons)")+ geom_bar(stat= "identity", width = .6)

plot(g)
dev.off()