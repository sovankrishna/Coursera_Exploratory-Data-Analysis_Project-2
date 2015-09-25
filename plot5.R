library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motor_vehicle <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

motor_vehicle_1 <- SCC[SCC$EI.Sector %in% motor_vehicle, ]["SCC"]

motor_vehicle_Baltimore <- NEI[NEI$SCC %in% motor_vehicle_1$SCC & NEI$fips == "24510",]

# finding the emissions due to motor vehicles in Baltimore for every year
balmv.yr <- ddply(motor_vehicle_Baltimore, .(year), function(x) sum(x$Emissions))
colnames(balmv.yr)[2] <- "Emissions"


png("plot5.png")
g <-  qplot(year, Emissions, data=balmv.pm25yr, geom="line") 
g <-  g + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + 
    xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
plot(g)
dev.off()