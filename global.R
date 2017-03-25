library(shiny)
library(shinydashboard)
library(leaflet)
library(sp)
library(maptools)
library(rgeos)


setwd("C:/Users/thoma/Rprojects/FishMercuryApp")
hg_agg=readRDS("Data/hg_agg.rds")
#hg_agg=read.csv("Data/hg_agg.csv")
#head(hg_agg)
#location=as.character(hg_agg$hg_data_Sel.final....LOCATION_NAME..)
#hg_agg$hg_data_Sel.final....LOCATION_NAME..=location
#species = as.character(hg_agg$hg_data_Sel.final....SPECIES_NAME..)
#hg_agg$hg_data_Sel.final....SPECIES_NAME..=species

#colnames(hg_agg) = c("ID", "LOCATION","DATE","SPECIES","LAT","LONG","LENGTH","WEIGHT","MERCURY", "SAMPLES")
#str(hg_agg)


### format sampling date vriable to  POSIXlt format###
#dt=strptime(hg_agg$DATE,"%d-%b-%y")
#hg_agg$date=dt

#hg_agg$vals=cut(hg_agg$MERCURY, c(min(hg_agg$MERCURY), 0.61, 1.23, 1.85, max(hg_agg$MERCURY)), labels = c("0 to 0.61", ">0.61 to 1.23", ">1.23 to 1.85", ">1.85"))


#hg_agg=hg_agg[,c(2,4:12)]

Ontario = readShapePoly("GISlayers/1mprovnc.shp")
Waterbodies = readShapePoly("GISlayers/SHAPE_length_5plus_clip.shp")

pallet = colorFactor(c("cyan", "darkolivegreen",  "orange", "firebrick1"),
                     domain = c("0 to 0.61", ">0.61 to 1.23", ">1.23 to 1.85", ">1.85"))



