library(shiny)
library(leaflet)
library(rgdal)

###UI
htmlTemplate("template.html",
             navbar = navbarPage(id="nivel",tabPanel("febrero 11"),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 12 </span><br>Ciudad de México")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 13 </span><br>Ciudad de México")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 14 </span><br>Ciudad de México")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 14 </span><br>Ecatepec")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 15 </span><br>San Cristóbal")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 15 </span><br>Tuxtla")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 16 </span><br>Morelia")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 17 </span><br>Ciudad Juárez"))
                                 ),
             mymap = leafletOutput("mapapapa"),
             
             hashhash =  textOutput("hashtag")
             
             
             )