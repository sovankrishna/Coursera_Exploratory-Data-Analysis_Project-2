library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gathering the subset of the NEI data which corresponds to vehicles
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
veh_SCC <- SCC[vehicles,]$SCC
veh_NEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Subseting the vehicles NEI data by city's fip and add city name.
veh_Baltimore_NEI <- veh_NEI[veh_NEI$fips=="24510",]
veh_Baltimore_NEI$city <- "Baltimore City"

veh_NEI_06037 <- veh_NEI[veh_NEI$fips=="06037",]
veh_NEI_06037$city <- "Los Angeles County"

# Combining the subsets with city name and combining into one data frame
full_NEI <- rbind(veh_Baltimore_NEI,veh_NEI_06037)

library(ggplot2)
# Plotting
png("plot6.png")

g <- ggplot(full_NEI, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", ylab="Total PM"[2.5]*" Emission (1000-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

plot(g)

dev.off()


