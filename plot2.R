## Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
## to make a plot answering this question.


library(dplyr)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var

NEIbyYear <- NEI %>%                                                            ## Summarize Total emmisions by years
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(sum(Emissions))

png(filename = "plot2.png", width = 480, height = 480, units = "px")            ## Create a windows plot to save in .png
par(mar= c(4,4,4,4), oma = c(1,2,1,1) )
plot(NEIbyYear$year, NEIbyYear$`sum(Emissions)`, pch = 10, cex = 2,type = "b",
     col = "cadetblue", lwd = 3,
     main = expression('Total PM'[2.5]*" Emissions (in Millions) in Maryland from 1999 to 2008"),
     ylab = expression('Total PM'[2.5]*' Emission (in millions of Tons)'), xlab = "Year",
     ylim = c(min(NEIbyYear$`sum(Emissions)`)*.95, c(max(NEIbyYear$`sum(Emissions)`*1.05))),
     xlim = c(min(NEIbyYear$year)-1, max(NEIbyYear$year)+1))

text(NEIbyYear$year-.05,NEIbyYear$`sum(Emissions)`+40,                            ## Show value in points
     labels = as.character(round(NEIbyYear$`sum(Emissions)`, 0)), cex=1, font=1, pos=2)
dev.off()
