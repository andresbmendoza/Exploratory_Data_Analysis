## Have total emissions from PM2.5 decreased in the United States from
## 1999 to 2008? Using the base plotting system, make a plot showing
## the total PM2.5 emission from all sources for each of the years:
## 1999, 2002, 2005, and 2008.

library(dplyr)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")                      ## Load Data table into NEI Var

NEIbyYear <- NEI %>%                                                            ## Summarize Total emmisions by years
  group_by(year) %>%
  summarise(sum(Emissions))

NEIbyYear <- mutate(NEIbyYear,                                                  ## Create a new column to show total in millions
                    Emissions_millions = NEIbyYear$`sum(Emissions)`/1000000)

png(filename = "plot1.png", width = 480, height = 480, units = "px")            ## Create a windows plot to save in .png
par(mar= c(4,4,4,4), oma = c(1,2,1,1) )
plot(NEIbyYear$year, NEIbyYear$Emissions_millions, pch = 10, cex = 2,type = "b",
     col = "blue1", lwd = 3,
     main = expression('Total PM'[2.5]*" Emissions (in Millions) in the USA from 1999 to 2008"),
     ylab = expression('Total PM'[2.5]*' Emission (in millions of Tons)'), xlab = "Year",
     ylim = c(min(NEIbyYear$Emissions_millions)-1, c(max(NEIbyYear$Emissions_millions+1))),
     xlim = c(min(NEIbyYear$year)-1, max(NEIbyYear$year)+1))

text(NEIbyYear$year+.5,NEIbyYear$Emissions_millions,                            ## Show value in points
     labels = as.character(round(NEIbyYear$Emissions_millions, 3)), cex=1, font=1, pos=3)
dev.off()        
        
