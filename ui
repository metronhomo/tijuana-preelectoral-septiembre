library(shiny)
library(shinythemes)


shinyUI(
  navbarPage(theme=shinytheme('Flatly'),
             'Encuesta Preelectoral Tijuana',
             tabPanel(''),
             navbarMenu('Descriptivos',
               tabPanel('Frecuencias',
                        column(3,
                               wellPanel(
                                 tags$style(type='text/css', 
                                            ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                                 selectInput('varfrec',
                                             label=h4('Variable'),
                                             choices=eval(parse(text=paste('list(',paste('"',catalogo[,2],'"="',catalogo[,1],'"',collapse=',',sep=''),')'))),
                                             selected=9
                                 )
                               ),
                               wellPanel(
                                 style = "background-color: #2c3e50;",
                                 h2('¿Qué significa?',align="center",style = "color:#C2D1E0"),
                                 p('La batería es consistente y es estadísticamente correcto suponer la existencia de un índice único que 
                                   resuma adecuadamente a la batería.',style = "color:#C2D1E0; font-size:16pt"),
                                 p('Asimismo comenzamos a ver pequeños clusters de correlaciones, por ejemplo vemos que las variables 
                                   relacionadas con la evaluación del "jefe" tienen correlaciones altas, esto es importante para derivar 
                                   índices secundarios.',style = "color:#C2D1E0; font-size:16pt")
                                 )
                                 ),
                        column(9,
                               plotOutput('frecuencias',height=700,width=700)
                               
                        )
                        
                      ),
               tabPanel('Cruces',
                        column(3,wellPanel(
                          tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                          
                          selectInput('c1',label=h4('Variables para cruce'),
                                      choices=eval(parse(text=paste('list(',paste('"',catalogo[,2],'"="',catalogo[,1],'"',collapse=',',sep=''),')'))),
                                      selected=6
                          ),
                          tags$style(type='text/css', ".selectize-input { font-size: 20px; line-height: 20px;} .selectize-dropdown { font-size: 12px; line-height: 12px; }"),
                          
                          selectInput('c2',label=h4(''),
                                      choices=eval(parse(text=paste('list(',paste('"',catalogo[,2],'"="',catalogo[,1],'"',collapse=',',sep=''),')'))),
                                      selected=6
                          )
                        )
                        
                        
                        ),
                        column(9,
                               plotOutput('cruce',height=800,width=800))
               )
             ),
             tabPanel('Estructura Electoral',
               column(6,wellPanel(
                 h2('Estructura Electoral de Tijuana'),
                 p('La situación general para el partido es buena, la mayoría del voto manifestado es panista. Sin embargo hay ciertas precauciones 
                   que se deben tomar, pero antes de hablar sobre eso, debemos caracterizar a los diferentes grupos electorales')
                        ),
                 wellPanel(h1('Segmento PAN/anti-PRI'),
                           p(''))
               ),
               column(6,
                      plotOutput('estructura',width=600,height=600)
               )
             )
             
    
  )
)
