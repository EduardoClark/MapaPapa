library(shiny)
library(leaflet)
library(rgdal)

###UI
htmlTemplate("template.html",
             navbar = navbarPage(id="nivel",tabPanel("febrero 11") ,
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 15 </span><br>San Cristóbal")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 15 </span><br>Tuxtla")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 16 </span><br>Morelia")),
                                                tabPanel(HTML("<span style='font-weight:bold;'>Febrero 17 </span><br>Ciudad Juárez"))
                                 ),
             mymap = leafletOutput("mapapapa"),
             
             hashhash =  textOutput("hashtag")
             
             
             )