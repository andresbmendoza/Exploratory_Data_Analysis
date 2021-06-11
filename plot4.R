## cross the United States,
## how have emissions from coal combustion-related sources
## changed from 1999–2008?

library(dplyr)
library(ggplot2)
library(scales)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")           ## Load Data table into SCC

SCC_Coal <- SCC[grep("Comb.*Coal+", SCC$Short.Name), "SCC"]                     ## list with SCC's rows numbers where the pollutant sources are Coal Combustions


NEIbyYear <- NEI[NEI$SCC %in% SCC_Coal, ] %>%                                   ## Summarize Total emmisions of coal sources by years
  group_by(year) %>%
  summarise(sum(Emissions))

png(filename = "plot4.png", width = 480, height = 480, units = "px")
ggplot(NEIbyYear, aes(NEIbyYear$year, NEIbyYear$`sum(Emissions)`)) +
  geom_line(color = "black") + geom_point(col= "gray5", pch = 15) +
  labs(title = "Coal Combustion-Related Sources Yearly Emissions", x = "Year", y = "Total Coal-Related Emissions (in Tons)") +
  theme_linedraw()
dev.off()
