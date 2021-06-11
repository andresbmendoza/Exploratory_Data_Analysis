## How have emissions from motor vehicle sources changed from 1999–2008
## in Baltimore City?

library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var

data <-
  NEI[ (NEI$fips == "24510" | NEI$fips == "06037" ) & NEI$type == "ON-ROAD",] %>%                                                            ## Summarize Total Vehicles emmisions by years in Baltymore
  group_by(fips,year) %>%
  summarise(sum(Emissions)) 

data<- as.data.table(data)
data <- data[data$fips == "24510", loc := "Baltimore"]
data <- data[data$fips == "06037", loc := "Los Angeles"]


png(filename = "plot6.png", width = 500, height = 480, units = "px")

ggplot(data, aes(x = data$year, y = data$`sum(Emissions)`, col = loc)) +
  geom_line() + geom_point(pch = 15) + facet_grid(data$loc~.,scales = "free" ) +
  labs(title = "Total vehicle Yearly Emissions", x = "Year",
       y = "Total Vehicles Emissions (in Tons)", colour = "County")
dev.off()
