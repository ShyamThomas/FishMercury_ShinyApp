

#setwd("C:/Users/thoma/Rprojects/HgApp")
#hg_agg=read.csv("Data/hg_agg.csv")


### Shiny dynamic session BEGINS below ###
function(input, output, session) {

  getHgvals <- function() {
    startdate = as.POSIXlt(paste(as.character(input$daterange[1])))
    enddate = as.POSIXlt(paste(as.character(input$daterange[2])))
    fishsp = input$fishspecies
    Hg_sptime= hg_agg[hg_agg$date >= startdate & hg_agg$date <= enddate
                                & hg_agg$SPECIES== fishsp,]
    return(Hg_sptime)
  }
  
  hgmp = eventReactive(input$updateButton, {
    Hgvals = getHgvals()
    pu <- paste("<b>Mercury:</b>", as.character(signif(Hgvals$MERCURY),digits=2), "mcg<br>",
                "<b>Weight:</b>", as.character(signif(Hgvals$WEIGHT),2), "gms<br>",
                "<b>Length:</b>", as.character(signif(Hgvals$LENGTH),2), "cm<br>",
                "<b>Samples:</b>", as.character(Hgvals$SAMPLES), "<br>",
                "<b>Dates:</b>", as.character.POSIXt(Hgvals$date), "<br>",
                "<b>Location:</b>", as.character(Hgvals$LOCATION), "<br>"
            )

    tmp = leaflet(data=Hgvals) %>%
        addProviderTiles("Esri.WorldStreetMap", group="Esri.WorldStreetMap") %>%
        #addProviderTiles("OpenTopoMap", group = "OpenTopoMap") %>%
        #addProviderTiles("OpenStreetMap.BlackAndWhite", group = "OpenStreetMap.BlackAndWhite") %>%
        setView(-84.8, 49.3, zoom = 5) %>%
      
        addPolygons(data=Ontario,
                    stroke=TRUE, color="black", weight=4,
                    fill=FALSE, fillOpacity = 0.0,
                    smoothFactor=0.5, group = "Ontario")%>%
      
        addPolygons(data=Waterbodies,
                 stroke=TRUE, color="blue", weight=2,
                 fill=FALSE, fillOpacity = 0.6,
                smoothFactor=0.9, group = "Waterbodies")%>%
        hideGroup("Waterbodies")%>%
      
        addLayersControl(
        baseGroups = "Esri.WorldStreetMap",
        overlayGroups = c("Ontario", "Waterbodies"),
        options = layersControlOptions(collapsed = TRUE)
      )%>%
      
        addCircleMarkers(jitter(Hgvals$LONG, factor = 0.2), jitter(Hgvals$LAT, factor = 0.2),
                    popup = pu,
                    color = ~pallet(vals),
                    radius = ~ifelse(Hgvals$MERCURY > 1.85, 7, 3), 
                    stroke = TRUE, fill=FALSE) %>%
     addLegend(
        "bottomright", pal = pallet,
        values = sort(hg_agg$vals),
        title = "Mercury level"
        )
  })
    HgHist <- eventReactive(input$updateButton, {
      Hgvals = getHgvals()
      hist(Hgvals$MERCURY,breaks = 5, col = "darkgray", xlab = "Mercury levels", ylab = "Frequency", main= " ")
  })
  
#Update Mercury map
  output$mercurymap = renderLeaflet(hgmp())
  output$HgHist <- renderPlot(HgHist())
  
  #print(head(getHgvals()))
  #print(tail(getHgvals()))
  #print(str(getHgvals()))
}

