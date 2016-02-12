library(shiny)
library(leaflet)
require(dplyr)
require(maps)
library(rgdal)
library(htmltools)


#Icons
EventIcon <- makeIcon(
  iconUrl = "https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png",
  iconWidth = 20, iconHeight = 20
)
AyudaIcon <- makeIcon(
  iconUrl = "https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png",
  iconWidth = 20, iconHeight = 20
)
SaludIcon <- makeIcon(
  iconUrl = "https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png",
  iconWidth = 10, iconHeight = 10
)
PoliciaIcon <- makeIcon(
  iconUrl = "http://104.236.151.123:3838/mapapapa/assets/papa-02.png",
  iconWidth = 10, iconHeight = 10
)
AngelesIcon <- makeIcon(
  iconUrl = "http://104.236.151.123:3838/mapapapa/assets/papa-01.png",
  iconWidth = 10, iconHeight = 10
)

##PoliciaFederal
PoliciaFederal <- read.csv("layers/PoliciaFederal.csv",stringsAsFactors = FALSE)

#Angeles Verdes 
AV <- readOGR("layers","PATAM_Papa",stringsAsFactors = FALSE)
AV$LON <- AV$LONGITUD
AV$LAT <- AV$LATITUD

##Feb12
OGR <- readOGR("layers/12feb1","12FebRuta1")
Event <- readOGR("layers/12feb1","13feb1Eventos")
Ayuda <- readOGR("layers/12feb1","12FebApoyos1")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb12 <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.110055,lat = 19.3844444,zoom=13) %>%
  addPolylines(color = "red", weight = 4, data = OGR,group="<span class='iconline' style='background-color:red;'></span>Hangar presidencial - Nunciatura &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Apostólica<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 19:45 a 20:30 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name), data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(data=Ayuda, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<b class='button1' style='float: right; font-size: 15px;'>&#10006;</b><span style='font-size:20px;color:grey;'>Febrero 12</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Ciudad de México</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:red;'></span>Hangar presidencial - Nunciatura &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Apostólica<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 19:45 a 20:30 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
    options = layersControlOptions(collapsed = FALSE)) 
  

##Feb13 Ciudad de México
OGR <- readOGR("layers/13feb1","13feb1Ruta")
OGR2 <- readOGR("layers/13feb2","13feb2RutasRutas")
OGR3 <- readOGR("layers/13feb3","13feb3Ruta")
Event <- readOGR("layers/13feb1","13feb1Eventos")
Event2 <- readOGR("layers/13feb2","13feb2Eventos")
Event3 <- readOGR("layers/13feb3","13feb3Eventos")
Ayuda <- readOGR("layers/13feb1","13feb1Apoyos")
Ayuda2 <- readOGR("layers/13feb2","13feb2Rutas")
Ayuda3 <- readOGR("layers/13feb3","13feb3Apoyos")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb13 <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.110055,lat = 19.4044444,zoom=12) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Nunciatura Apostólica - Palacio &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nacional<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 9:30 horas</span><br><br>") %>%
  addPolylines(color = "#00cc99", weight = 4, data = OGR2,group="<span class='iconline' style='background-color:#00cc99;'></span>Catedral Metropolitana - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nunciatura Apostólica<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 12:45 a 13:30 horas</span><br><br>") %>%
  addPolylines(color = "#4D92DF", weight = 4, data = OGR3,group="<span class='iconline' style='background-color:#4D92DF;'></span>Nunciatura Apostólica - Basílica &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de Guadalupe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 16:00 a 16:35 y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;19:30 a 20:15 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event2, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event3, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(data=Ayuda, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(data=Ayuda2, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(data=Ayuda3, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 13</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Ciudad de México</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Nunciatura Apostólica - Palacio &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nacional<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 9:30 horas</span><br><br>",
                                     "<span class='iconline' style='background-color:#00cc99;'></span>Catedral Metropolitana - &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nunciatura Apostólica<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 12:45 a 13:30 horas</span><br><br>",
                                     "<span class='iconline' style='background-color:#4D92DF;'></span>Nunciatura Apostólica - Basílica &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de Guadalupe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 16:00 a 16:35 y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;19:30 a 20:15 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 14 CDMX
OGR <- readOGR("layers/14feb1","14feb1Ruta")
OGR2 <- readOGR("layers/14feb2","14feb2Ruta")
OGR3 <- readOGR("layers/14feb3","14feb3Ruta")
Event <- readOGR("layers/14feb1","14feb1Eventos")
Event2 <- readOGR("layers/14feb2","14feb2Evento")
Event3 <- readOGR("layers/14feb3","14feb3Evento")
Ayuda <- readOGR("layers/14feb1","14feb1Apoyos")
Ayuda2 <- readOGR("layers/14feb2","14feb2Apoyo")
Ayuda3 <- readOGR("layers/14feb3","14feb3Apoyo")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb14A <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.133055,lat = 19.4000444,zoom=13) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Nunciatura Apostólica - Campo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marte<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 9:30 horas</span><br><br>") %>%
  addPolylines(color = "#00cc99", weight = 4, data = OGR2,group="<span class='iconline' style='background-color:#00cc99;'></span>Campo Marte - Hospital<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>12:45 a 13:30 horas</span><br><br>") %>%
  addPolylines(color = "#4D92DF", weight = 4, data = OGR3,group="<span class='iconline' style='background-color:#4D92DF;'></span>Hospital - Nunciatura Apostólica <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>16:00 a 16:35 y 19:30 a 20:15 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event2, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event3, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(data=Ayuda, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(data=Ayuda2, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(data=Ayuda3, icon=AyudaIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="domingo 14 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 14</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Ciudad de México</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Nunciatura Apostólica - Campo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marte<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 9:30 horas</span><br><br>",
                                     "<span class='iconline' style='background-color:#00cc99;'></span>Campo Marte - Hospital<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>12:45 a 13:30 horas</span><br><br>",
                                     "<span class='iconline' style='background-color:#4D92DF;'></span>Hospital - Nunciatura Apostólica <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>16:00 a 16:35 y 19:30 a 20:15 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Atención médica, hidratación y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sanitarios<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 14 Ecatepec 	19.6°, -99.05°
OGR <- readOGR("layers/14feb4","14feb4Ruta")
Event <- readOGR("layers/14feb4","14feb4Evento")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb14B <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -99.01,lat = 19.6,zoom=14) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Ecatepec<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 10:35 a 17:00 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="domingo 14 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 14</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Ecatepec</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Ecatepec<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 10:35 a 17:00 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 15 San Cristobal 16.736667°, -92.638333°
OGR <- readOGR("layers/15feb1","15feb1Ruta")
Event <- readOGR("layers/15feb1","15feb1Evento")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb15A <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -92.638333,lat = 16.736667,zoom=14) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>San Cristóbal de las Casas<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 9:40 a 15:30 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="Lunes 15 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 15</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>San Cristóbal de las Casas</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>San Cristóbal de las Casas<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 9:40 a 15:30 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 15 Tluxta 16.753056°, -93.115556°
OGR <- readOGR("layers/15feb2","15feb2Ruta")
Event <- readOGR("layers/15feb2","15feb2Evento")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb15B <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -93.11556,lat = 16.753056,zoom=13) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Tluxtla Gutiérrez<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 15:10 a 18:10 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="Lunes 15 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 15</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Tluxtla Gutiérrez</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Tluxtla Gutiérrez<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 15:10 a 18:10 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 16 Morelia 19.702778°, -101.192222°
OGR <- readOGR("layers/16feb1","16feb1Ruta")
Event <- readOGR("layers/16feb1","16feb1Evento")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb16A <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -101.192222,lat = 19.7202778,zoom=13) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Morelia<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 18:30 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="Martes 16 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 16</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Morelia</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Morelia<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 8:45 a 18:30 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 

##Febrero 17 CDJu 	31.739444°, -106.486944°
OGR <- readOGR("layers/17feb1","17feb1Ruta")
Event <- readOGR("layers/17feb1","17feb1Evento")
CentrosSalud <- read.csv("layers/centrosalud.csv",stringsAsFactors = FALSE)
Feb17A <- leaflet() %>% addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -106.486944,lat = 31.739444,zoom=13) %>%
  addPolylines(color = "#D0021B", weight = 4, data = OGR,group="<span class='iconline' style='background-color:#D0021B;'></span>Ciudad Juárez <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 10:00 a 19:15 horas</span><br><br>") %>%
  addMarkers(popup = ~htmlEscape(Name),data=Event, icon=EventIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>") %>%
  addMarkers(popup = ~htmlEscape(DESCRIPTION),data=CentrosSalud, icon=SaludIcon,group="<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>") %>%
  addMarkers(popup = ~htmlEscape(Ubicacion), data=PoliciaFederal[PoliciaFederal$Dia=="Miércoles 16 de febrero",], icon=PoliciaIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>") %>%
  addMarkers(popup = ~htmlEscape(NOMBRE),data=AV, icon=AngelesIcon,group="<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>") %>%
  addLayersControl(baseGroups = c(HTML("<span style='font-size:20px;color:grey;'>Febrero 17</span><br><span style='font-size:12px;color:grey;font-weight:normal;'>Ciudad Juárez</span><br>")),
                   overlayGroups = c("<span class='iconline' style='background-color:#D0021B;'></span>Ciudad Juárez <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style='font-weight:normal;'>Cierres viales de 10:00 a 19:15 horas</span><br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Eventos<br><br>",
                                     "<span'> <img src='https://framework-gb.cdn.gob.mx/data/mapa/papa01-icono03.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Centros de salud<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-02.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Puntos de apoyo: Policía Federal<br><br>",
                                     "<span'> <img src='http://104.236.151.123:3838/mapapapa/assets/papa-01.png' height='20px' width='20px' style='margin-top: -5px;margin-left: 5px;'> </span>Punto de atención turística y &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;auxilio mecánico<br><br>"),
                   options = layersControlOptions(collapsed = FALSE)) 




##Server

shinyServer(function(input, output) {
  
  output$mapapapa <- renderLeaflet({
    if(input$nivel=="<span style='font-weight:bold;'>Febrero 12 </span><br>Ciudad de México") {Feb12}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 13 </span><br>Ciudad de México") {Feb13}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 14 </span><br>Ciudad de México") {Feb14A}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 14 </span><br>Ecatepec") {Feb14B}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 15 </span><br>San Cristóbal") {Feb15A}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 15 </span><br>Tuxtla") {Feb15B}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 16 </span><br>Morelia") {Feb16A}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 17 </span><br>Ciudad Juárez") {Feb17A}
    else {Feb12}
  })
  
  
  output$hashtag <- renderText({
    if(input$nivel=="<span style='font-weight:bold;'>Febrero 12 </span><br>Ciudad de México") {"#PapaenCDMX"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 13 </span><br>Ciudad de México") {"#PapaenCDMX"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 14 </span><br>Ciudad de México") {"#PapaenCDMX"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 14 </span><br>Ecatepec") {"#PapaenMX"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 15 </span><br>San Cristóbal") {"#PapaenCHPS"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 15 </span><br>Tuxtla") {"#PapaenCHPS"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 16 </span><br>Morelia") {"#PapaenMich"}
    else if(input$nivel=="<span style='font-weight:bold;'>Febrero 17 </span><br>Ciudad Juárez") {"#PapaenCDJ"}
    else {"#PapaenCDMX"}
    })

  
    })
  


