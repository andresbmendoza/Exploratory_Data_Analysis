## How have emissions from motor vehicle sources changed from 1999–2008
## in Baltimore City?

library(dplyr)
library(ggplot2)
library(scales)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var

NEIbyYear <- NEI[ NEI$fips == "24510" & NEI$type == "ON-ROAD",] %>%                                                            ## Summarize Total Vehicles emmisions by years in Baltymore
  group_by(year) %>%
  summarise(sum(Emissions))


png(filename = "plot5.png", width = 500, height = 480, units = "px")

ggplot(NEIbyYear, aes(NEIbyYear$year, NEIbyYear$`sum(Emissions)`)) +
  geom_line(color = "steelblue") + geom_point(col= "steelblue", pch = 15) +
  labs(title = "Total vehicle Yearly Emissions in Baltimore City", x = "Year", y = "Total Vehicles Emissions (in Tons)") +
  theme_linedraw()
dev.off()
