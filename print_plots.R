
setwd("C:/Users/Jan/Documents/flux_data")
source("import_flux_data.R")

packages <- c("readxl",
              "tidyverse",
              "lubridate",
              "stringr",
              "metafor",
              "writexl",
              "ggplot2",
              "effsize")

# loads all need libraries
for (package in packages){
  if (!require(package, character.only = TRUE)) install.packages(package)
  library(package, character.only = TRUE)
}



files <- dir("C:/Users/Jan/Desktop/projectwork/data/Checked by Sybryn/1_Checked by Sybryn", pattern = ".xlsx")

for (file in files){
  
  # check if excelsheet 
  stopifnot(str_sub(file,-5,-1)== ".xlsx")
  location <- paste("C:/Users/Jan/Desktop/projectwork/data/Checked by Sybryn/1_Checked by Sybryn/",
                    file,
                    sep="")
  assign(str_sub(file, -15, -6), import_flux(location))
}

data_list <- Filter(function(x) is(x, "data.frame"), mget(ls()))

minCO2 = 0
maxCO2 = 0
maxList <- c(rep(0,length=length(data_list)))
for (i in seq(1,length(data_list))){
  station <- data_list[[i]]
  name <- names(data_list)[[i]]
  
  if (max(station$CO2) > maxCO2){
    maxCO2 <- max(station$CO2)
  }
  if (min(station$CO2) < minCO2){
    minCO2 <- min(station$CO2)
  }
  
  maxList[i] <- max(station$CO2)
  
}

setwd("C:/Users/Jan/Desktop/projectwork/plots_sybryn_mats")


pdf("effectplots.pdf")

for (i in seq(1,length(data_list))){
  station <- data_list[[i]]
  name <- names(data_list)[[i]]
  
  
  effectsize <- cohen.d(station$CO2[station$Treatment.x=="CTL"],
                        station$CO2[station$Treatment.x!="CTL"])
  
  print(ggplot(data=station,aes(x = Treatment.x, y = CO2),fill=CO2)+
    stat_boxplot(geom ='errorbar')+
    geom_boxplot(fill='#A4A4A4', color="black")+
    theme_bw()+
    theme(strip.background = element_rect(color=NA,
                                          fill=NA,
                                          size=1.5,
                                          linetype="solid"))+
    ggtitle(paste("CO2 at ",name))+
    scale_y_continuous(limits = c(0, 25)) +
    annotate("text",
             x = 1.5,
             y = 25,
             label = paste("effectsize",
                           round(effectsize$estimate,
                           digits=2))))
}

dev.off()


setwd("C:/Users/Jan/Documents/flux_data")
