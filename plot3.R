## Of the four types of sources indicated by the type
## (point, nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)
library(scales)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var

NEIbyYear <- NEI %>%                                                            ## Summarize Total emmisions by years
  filter(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(sum(Emissions))


png(filename = "plot3.png", width = 500, height = 480, units = "px")
ggplot(NEIbyYear, aes(year, NEIbyYear$`sum(Emissions)`, colour = type)) +
  geom_smooth(method ="lm", se = FALSE)+
  geom_point(pch = 8, cex=3) +
  labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City from 1999 to 2008"), x = "Year", y = expression('Total PM'[2.5]*" Emission (in tons)")) +
  theme_linedraw()
dev.off()
