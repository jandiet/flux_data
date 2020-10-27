# script to import data for metaanalysis of arctic carbon fluxes.

# intro: 
# the function import_flux() takes a file name as input and imports the sheet
# to a r-dataframe. Both, flux data and plot data are combined in one. 
# one dataframe per station and per year (as in the sheets)

#TODO combine data from different stations and years to one dataframe 
#TODO assert-functions/prerequisites to check if imported sheets have the
#TODO correct format
#TODO print quickplots, -> bzw summary (x station, x ch4 points, y co2 points)


#### needed libraries ----


packages <- c("readxl",
              "tidyverse",
              "lubridate",
              "stringr",
              "metafor")

# loads all need libraries
for (package in packages){
  if (!require(package, character.only = TRUE)) install.packages(package)
  library(package, character.only = TRUE)
}

#### function to import ----
# can be run in loop for directories

import_flux <- function(file){
  
  
  # check if excelsheet 
  stopifnot(str_sub(file,-5,-1)== ".xlsx")
  
  ## flux_data, skip header, combine columnnames with data
  
  columns <- read_excel(file,
                        sheet = "FLUX_DATA",
                        na = "NA",
                        skip = 1,
                        n_max = 1)
  
  flux_data <- read_excel(file,
                          sheet = "FLUX_DATA",
                          skip = 6)
  
  # assign column names
  colnames(flux_data) <- colnames(columns)
  
  
  # delete not used column
  flux_data$Var <- NULL
  
  # create unique treatment,plot_ID combination to join with plot data
  flux_data$plottreatment <- paste(flux_data$Plot_ID,flux_data$Treatment)
  
  # delete excessive rows 
  flux_data <- flux_data %>% drop_na(`Site_ID [AUTOMATIC]`)
  
  
  
  ## plot_data, skip header, combine columnnames with data
  
  columns_2 <- read_excel(file, 
                          sheet = "PLOT_METADATA",
                          skip = 2,
                          n_max = 1)
  
  
  # change columns to get sufficient information 
  colnames(columns_2) <- gsub("_1","_organic",colnames(columns_2))
  colnames(columns_2) <- gsub("_2","_mineral",colnames(columns_2))
  
  plot_data <- read_excel(file, 
                          sheet = "PLOT_METADATA", skip = 6)
  
  # assign column names
  colnames(plot_data) <- colnames(columns_2)
  
  # delete not used column, unique treatment_ID, drop not used data
  plot_data$Var <- NULL
  plot_data$plottreatment <- paste(plot_data$Plot_ID,plot_data$Treatment)
  plot_data <- plot_data %>% drop_na(Treatment)
  
  
  return(assign(substr(file, 1, 10), merge(x = flux_data, y = plot_data, by = "plottreatment", all = TRUE)))
}


#### im port one file ----

# setwd("...")      # enter directory here
# file <- "SWE_3_2017_Flux dataset MA_MB.xlsx"

# test run 

# assign(substr(file, 1, 10),import_flux(file))
# -> to change the name of the data frame just use assign("..", import_flux())

#### import all from folder ----

# enter folderpath
folder = getwd()   # works because working directory is set to folder

files <- dir(folder, pattern = ".xlsx")

for (file in files){
  
  # check if excelsheet 
  stopifnot(str_sub(file,-5,-1)== ".xlsx")
  
  assign(substr(file, 1, 10), import_flux(file))
}


# just a test
